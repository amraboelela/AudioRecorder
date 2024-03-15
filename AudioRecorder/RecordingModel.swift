//
//  RecordingModel.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import AVFoundation
import SwiftUI

class RecordingModel: Identifiable {
    
    var id: Int
    var duration: TimeInterval = 0
    
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
    }
    
    var formattedDuration: String {
        return Date.timeWith(seconds: duration)
    }

    func play() {
        Task {
            await audioRecorder.playRecording(number: id)
        }
    }
}
