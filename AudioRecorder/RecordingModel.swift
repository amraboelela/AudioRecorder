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
        //Task {
        await loadData()
        //}
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
        return "Recording #\(id)" //Date(timeIntervalSince1970: TimeInterval(time)).dateString
    }
    
    func loadData() async {
        duration = await audioRecorder.durationForAudio(number: id) //5 //audioPlayer?.duration ?? 0
    }
    
    var formattedDuration: String {
        return Date.timeWith(seconds: duration)
    }

    func play() {
        Task {
            await audioRecorder.playRecording(number: id)
        }
        /*audioPlayer?.prepareToPlay()
        // Start playing the audio
        audioPlayer?.play()*/
    }
}

/*
extension RecordingModel: Hashable {
    static func == (lhs: RecordingModel, rhs: RecordingModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}*/
