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
    
    func addRecording() async {
        let count = await audioRecorder.theRecordingsCount()
        let recording = await RecordingModel(id: count)
        await MainActor.run {
            recordings.insert(recording, at:0)
        }
    }
    
    func startRecording() async {
        print("startRecording")
        await audioRecorder.startRecording()
    }
    
    func stopRecording() async {
        print("stopRecording")
        await audioRecorder.stopRecording()
        await addRecording()
    }
    
    func stopAll() {
        for recording in recordings {
            recording.stop()
        }
    }
    
    func reloadUI() {
        recordings = recordings
    }
}

