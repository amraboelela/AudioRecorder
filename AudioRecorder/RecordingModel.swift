//
//  RecordingModel.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import AVFoundation
import SwiftUI

struct RecordingModel: Hashable, Identifiable {
    var id: Int // it holds the time stamp of the recording, as number of seconds since 1970
    var message: Data
    
    static var sampleAudio: Data {
        guard let audioURL = Bundle.main.url(forResource: "046", withExtension: "mp3") else {
            print("Audio file not found")
            return Data()
        }
        do {
            return try Data(contentsOf: audioURL)
        } catch {
            print("Error loading audio data:", error.localizedDescription)
            return Data()
        }
    }
    
    var subject: String {
        return Date(timeIntervalSince1970: TimeInterval(id)).dateString
    }
    
    var duration: TimeInterval {
        do {
            // Create an AVAudioPlayer instance with the audio data
            let audioPlayer = try AVAudioPlayer(data: message)
            // Get the duration of the audio file
            let duration = audioPlayer.duration
            return duration
        } catch {
            print("Error creating AVAudioPlayer:", error.localizedDescription)
            return 0
        }
    }
    
    var formattedDuration: String {
        return Date.timeWith(seconds: duration)
    }

}
