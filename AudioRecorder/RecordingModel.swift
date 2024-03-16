//
//  RecordingModel.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import AVFoundation
import SwiftUI

enum RecordingStatus {
    case stopped
    case playing
    case paused
}

class RecordingModel: Identifiable {
    
    var id: Int
    var date = Date()
    var duration: TimeInterval = 0
    var status = RecordingStatus.stopped
    
    init(id: Int) async {
        self.id = id
        await loadData()
    }
    
    static var sampleAudio: Data {
        let fileName = "alert1"
        let fileExtension = "wav"
        guard let audioURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
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
        return "Recording #\(id)"
    }
    
    func loadData() async {
        duration = await audioRecorder.durationForAudio(number: id)
        date = await audioRecorder.timeForAudio(number: id)
    }
    
    var formattedDuration: String {
        return Date.timeWith(seconds: duration)
    }

    var formattedDate: String {
        return date.dateString
    }
    
    func play(callback: @escaping () -> ()) {
        switch status {
        case .paused:
            status = .playing
            Task {
                await audioRecorder.continuePlaying(number: id) {
                    Task {
                        await MainActor.run {
                            self.status = .stopped
                            callback()
                        }
                    }
                }
            }
        case .playing:
            status = .playing
        case .stopped:
            status = .playing
            Task {
                await audioRecorder.play(number: id) {
                    Task {
                        await MainActor.run {
                            self.status = .stopped
                            callback()
                        }
                    }
                }
            }
        }
    }
    
    func pause() {
        status = .paused
        Task {
            await audioRecorder.pause(number: id)
        }
    }
    
    func stop() {
        status = .stopped
        Task {
            await audioRecorder.stop(number: id)
        }
    }
}
