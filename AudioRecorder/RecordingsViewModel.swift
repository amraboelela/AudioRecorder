//
//  RecordingsViewModel.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import Foundation
import SwiftUI

class RecordingsViewModel: ObservableObject {
    @Published var recordings = [RecordingModel]()
    
    init() {
    }
    
    func loadRecordings() async {
        var newRecordings: [RecordingModel] = []
        let count = await audioRecorder.theRecordingsCount()
        for i in (0..<count).reversed() {
            let recording = await RecordingModel(
                id: i + 1
            )
            newRecordings.append(recording)
        }
        let finalRecordings = newRecordings
        Task {
            await MainActor.run {
                self.recordings = finalRecordings
            }
        }
    }
    
    func startRecording() async {
        print("startRecording")
        await audioRecorder.startRecording()
    }
    
    func stopRecording() async {
        print("stopRecording")
        await audioRecorder.stopRecording()
        await loadRecordings()
    }
}

