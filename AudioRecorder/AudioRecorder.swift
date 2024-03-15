//
//  AudioRecorder.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import AVFoundation

let audioRecorder = AudioRecorder()

actor AudioRecorder: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    private var recordingsCount = 0
    
    override init() {
        super.init()
        
        // Set up audio session
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try session.setActive(true)
            session.requestRecordPermission { allowed in
                if allowed {
                    print("Audio permission granted")
                } else {
                    // Handle permission not granted
                    print("Permission not granted for recording")
                }
            }
        } catch {
            // Handle audio session setup errors
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    }

    var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func theRecordingsCount() -> Int {
        return recordingsCount
    }
    func startRecording() {
        // Set up audio file path
        recordingsCount += 1
        let audioFileURL = documentsDirectory.appendingPathComponent("recording\(recordingsCount).m4a")

        // Set up audio settings
        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        // Initialize audio recorder
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
        } catch {
            recordingsCount -= 1
            // Handle audio recorder initialization errors
            print("Error initializing audio recorder: \(error.localizedDescription)")
        }
    }

    func stopRecording() {
        // Stop recording
        audioRecorder?.stop()

        // Optionally, you can release and nil out the audioRecorder object
        // to free up memory once recording is finished
        audioRecorder = nil
    }
    
    func playRecording(number: Int) {
        let audioFileURL = documentsDirectory.appendingPathComponent("recording\(number).m4a")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
            audioPlayer?.delegate = self
            audioPlayer?.play()
        } catch {
            // Handle audio player initialization errors
            print("Error initializing audio player: \(error.localizedDescription)")
        }
    }
    
    func durationForAudio(number: Int) -> TimeInterval {
        let audioFileURL = documentsDirectory.appendingPathComponent("recording\(number).m4a")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
            return audioPlayer?.duration ?? 0
        } catch {
            // Handle audio player initialization errors
            print("Error initializing audio player: \(error.localizedDescription)")
        }
        return 0
    }
}
