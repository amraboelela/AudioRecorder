//
//  RecordingsViewModel.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import Foundation
import SwiftUI

struct RecordingsFetch {
    
    static func fetchNewRecording(count: Int) -> [RecordingModel] {
        
        let InvestingSpam = [
            "Dear Fellow Investor Heres something only a handful of people know - On March 19 2023 AI discovered a new drug for liver cancer in only 30 days",
            "Financial leaders like Ray Dalio Stanley Druckenmiller and David Tepper have silently sunk millions into the AI sector and these ventures",
            "On December 22 2022 AI discovered a new treatment for multiple myeloma in just 4 months",
            "When he made his first 100000 trading penny stocks with zero financial experience they told him he got lucky"
        ]
        
        let spammers = [
            "support@gorgeousincome.com",
            "seven@daily.the7at7.com"
        ]
        
        precondition(count > 0)
        var newRecording: [RecordingModel] = []
        
        let subjects = [
            "AI stock's 1,029% month!",
            "Top Stocks to Profit from the ChatGPT",
            "Today's Top Optionable Stocks: MU, TSM and more",
            "Traders blog"
        ]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let fmtDate = dateFormatter.string(from: Date())
        
        let to = "dxc@dxc.com"
        for _ in 0..<count {
            let recording = RecordingModel(
                id: Date.now, //UUID(),
                //subject: subjects.randomElement()!,
                message: RecordingModel.sampleAudio
            )
            newRecording.append(recording)
        }
        
        return newRecording
    }
    
}

let recordingsViewModel = RecordingsViewModel()

class RecordingsViewModel: ObservableObject {
    @Published var recordings = [RecordingModel]()
    
    init() {
        fetchRecordings()
    }
    
    func fetchRecordings() {
        recordings = RecordingsFetch.fetchNewRecording(count: 5)
    }
}

