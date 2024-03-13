//
//  RecordButton.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import SwiftUI

struct RecordButton: View {
    var size: CGFloat
    @State var isRecording = false
    @State private var rectSize: CGFloat
    @State private var rectCornerRadius: CGFloat
    var buttonTapped: () -> ()
    
    init(
        size: CGFloat = 60.0,
        buttonTapped: @escaping () -> ()
    ) {
        self.size = size
        self.buttonTapped = buttonTapped
        rectSize = size * 0.9
        rectCornerRadius = size * 0.9
    }
    
    var body: some View {
        Button(
            action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isRecording.toggle()
                    rectSize = isRecording ? size * 0.5 : size * 0.9
                    rectCornerRadius = isRecording ? size * 0.1 : size * 0.9
                }
                buttonTapped()
            },
            label: {
                Circle()
                    .frame(width: size, height: size)
                    .foregroundColor(Color.white)
                    .padding(5)
                    .background(.gray)
                    .clipShape(Circle())
                    .overlay {
                        RoundedRectangle(cornerRadius: rectCornerRadius)
                            .fill(Color.red)
                            .frame(width: rectSize, height: rectSize)
                    }
            }
        )
    }
}

#Preview {
    RecordButton(
        size: 70,
        buttonTapped: {
        }
    )
}
