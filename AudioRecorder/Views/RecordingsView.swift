//
//  RecordingsView.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import SwiftUI

struct RecordingsView: View {
    @ObservedObject var recordingsViewModel: RecordingsViewModel
    
    var body: some View {
        VStack {
            Text("Recordings")
                .font(Font.body.weight(.bold))
            List(recordingsViewModel.recordings) { recording in
                HStack {
                    Text(recording.subject)
                        .font(Font.body.weight(.bold))
                    Spacer()
                    Text("\(recording.formattedDuration)")
                }
            }
            RecordButton(buttonTapped: {
                print("Button tapped")
            })
        }
    }
}

#Preview {
    RecordingsView(recordingsViewModel: recordingsViewModel)
}
