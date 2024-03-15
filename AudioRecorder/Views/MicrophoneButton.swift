//
//  MicrophoneButton.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/14/24.
//

import SwiftUI

struct MicrophoneButton: View {
    @State private var isRecording = true
    @State private var circleOpacity = 0.0
    @State private var scaleEffect = 1.0
    var buttonTapped: (Bool) -> ()
    
    func animate() {
        if isRecording {
            withAnimation(
                .easeInOut(
                    duration: 0.5
                ).repeatForever(autoreverses: true)
            ) {
                circleOpacity = 1.0
                scaleEffect = 1.3
            }
        } else {
            circleOpacity = 0.0
            scaleEffect = 1.0
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(isRecording ? .blue : .white)
                .frame(width: 80, height: 80)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 5)
                        .opacity(circleOpacity)
                        .scaleEffect(scaleEffect)
                )
                .shadow(radius: 7)
            Image(systemName: "mic.fill")
                .font(.system(size: 30))
                .foregroundColor(isRecording ? .white : .blue)
                .onTapGesture {
                    isRecording.toggle()
                    animate()
                    buttonTapped(isRecording)
                }
        }
        .onAppear {
            animate()
        }
    }
}

#Preview {
    MicrophoneButton(
        buttonTapped: { isRecording in
            print("isRecording: \(isRecording)")
        }
    )
}
