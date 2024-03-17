//
//  RecordingsViewModel.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import Foundation
import SwiftUI

@MainActor
class RecordingsViewModel: ObservableObject {
    @Published var recordings = [RecordingModel]()
    
    init() {
    }
    
    func addRecording() async {
        let count = audioRecorder.theRecordingsCount()
        let recording = await RecordingModel(id: count)
        recordings.insert(recording, at:0)
    }
    
    func startRecording() {
        print("startRecording")
        audioRecorder.startRecording()
    }
    
    func stopRecording() async {
        print("stopRecording")
        audioRecorder.stopRecording()
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

