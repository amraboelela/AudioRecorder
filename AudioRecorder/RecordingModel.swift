//
//  RecordingModel.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import AVFoundation
import Combine
import SwiftUI

enum RecordingStatus {
    case stopped
    case playing
    case paused
}

class RecordingModel: Identifiable {
    
    var id: Int
    var date = Date()
    @Published var duration: TimeInterval = 0
    var status = RecordingStatus.stopped
    private var cancellables = Set<AnyCancellable>()
    
    init(id: Int, callback: @escaping (RecordingModel) -> ()) {
        self.id = id
        $duration
            .sink { newDuration in
                print("duration got updates, newDuration: \(newDuration)")
                if newDuration > 0 {
                    callback(self)
                }
            }
            .store(in: &cancellables)
        loadData()
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
    
    func loadData() {
        Task {
            let theDate = audioRecorder.timeForAudio(number: id)
            let theDuration = audioRecorder.durationForAudio(number: id)
            await MainActor.run {
                self.date = theDate
                self.duration = theDuration
            }
        }
    }
    
    var subject: String {
        return "Recording #\(id)"
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
                audioRecorder.continuePlaying(number: id) {
                    //Task {
                    //  await MainActor.run {
                    self.status = .stopped
                    callback()
                    //}
                    //}
                }
            }
        case .playing:
            status = .playing
        case .stopped:
            status = .playing
            //Task {
            audioRecorder.play(number: id) {
                //Task {
                //  await MainActor.run {
                self.status = .stopped
                callback()
                //}
                //}
            }
            //}
        }
    }
    
    func pause() {
        status = .paused
        //Task {
        audioRecorder.pause(number: id)
        //}
    }
    
    func stop() {
        status = .stopped
        //Task {
        audioRecorder.stop(number: id)
        //}
    }
}
