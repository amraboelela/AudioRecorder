//
//  DateTests.swift
//  AudioRecorderTests
//
//  Created by Amr Aboelela on 3/13/24.
//

import Foundation
import XCTest

@testable import AudioRecorder

class DateTests: XCTestCase {
    
    func testNow() {
        XCTAssertTrue(Date.now <= Int(Date().timeIntervalSince1970))
    }
    
    func testDateString() {
        // Create a sample date
        let sampleDate = Date()
        // Get the current date string using the extension
        let dateString = sampleDate.dateString
        // Create a DateFormatter instance with the expected format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd h:mm a"
        let expectedDateString = dateFormatter.string(from: sampleDate)
        // Assert that both date strings are equal
        XCTAssertEqual(dateString, expectedDateString)
    }
    
    func testTimeWithSeconds() {
        // Test case: timeWith(seconds:)
        var formattedString = Date.timeWith(seconds: 90)
        XCTAssertEqual(formattedString, "01:30", "Formatted string should be '01:30'")
        
        formattedString = Date.timeWith(seconds: 100)
        XCTAssertEqual(formattedString, "01:40")
        
        formattedString = Date.timeWith(seconds: 120)
        XCTAssertEqual(formattedString, "02:00")
    }
}
