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
    
    func addRecording() {
        let count = audioRecorder.theRecordingsCount()
        _ = RecordingModel(id: count) { [weak self] recording in
            self?.recordings.insert(recording, at:0)
        }
    }
    
    func startRecording() {
        print("startRecording")
        audioRecorder.startRecording()
    }
    
    func stopRecording() {
        print("stopRecording")
        audioRecorder.stopRecording()
        addRecording()
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

