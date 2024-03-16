//
//  RecordingsView.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import SwiftUI

struct RecordingsView: View {
    @ObservedObject var recordingsViewModel: RecordingsViewModel
    @State var playImage = "play.circle"
    
    func playImageFor(_ recording: RecordingModel) -> String {
        switch recording.status {
        case .playing:
            return "pause.circle"
        case .paused:
            return "playpause.circle"
        case .stopped:
            return "play.circle"
        }
    }
    
    var body: some View {
        VStack {
            Text("Recordings")
                .font(Font.body.weight(.bold))
            List(recordingsViewModel.recordings) { recording in
                HStack {
                    Image(systemName: playImageFor(recording))
                        .font(.system(size: 30))
                        .foregroundColor(.orange)
                    VStack(alignment: .leading) {
                        Text(recording.subject)
                            .bold()
                        Text(recording.formattedDate)
                    }
                    Spacer()
                    Text("\(recording.formattedDuration)")
                }
                .onTapGesture {
                    switch recording.status {
                    case .playing:
                        recording.pause()
                    case .paused:
                        recording.play {
                            recordingsViewModel.reloadUI()
                        }
                    case .stopped:
                        recordingsViewModel.stopAll()
                        recording.play {
                            recordingsViewModel.reloadUI()
                        }
                    }
                    recordingsViewModel.reloadUI()
                }
            }
            MicrophoneButton(
                buttonTapped: { isRecording in
                    if isRecording {
                        Task {
                            await recordingsViewModel.startRecording()
                        }
                    } else {
                        Task {
                            await recordingsViewModel.stopRecording()
                        }
                    }
                }
            )
            .padding(.top, 30)
            .background(Color.orange)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            print("RecordingsView, coming back!")
            Task {
                await recordingsViewModel.startRecording()
            }
        }
    }
}

#Preview {
    RecordingsView(recordingsViewModel: RecordingsViewModel())
}
