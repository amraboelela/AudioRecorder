//
//  AudioRecorderApp.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import SwiftUI

@main
struct AudioRecorderApp: App {
    var recordingsViewModel = RecordingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            RecordingsView(recordingsViewModel: recordingsViewModel)
        }
    }
}
