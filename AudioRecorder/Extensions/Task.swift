//
//  Task.swift
//  AudioRecorder
//
//  Created by Amr Aboelela on 9/2/22.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    public static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
