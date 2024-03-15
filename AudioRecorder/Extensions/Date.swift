//
//  Date.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 3/13/24.
//

import Foundation

extension Date {
    
    public static var now: Int {
        return Int(Date().timeIntervalSince1970)
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd h:mm a"
        let dateString = dateFormatter.string(from: self)
        
        return dateString
    }
    
    static func timeWith(seconds: TimeInterval) -> String {
        let timeInterval = TimeInterval(seconds)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        let formattedString = formatter.string(from: timeInterval)!
        //print(formattedString) // Output: "01:30"
        return formattedString
    }
    
}
