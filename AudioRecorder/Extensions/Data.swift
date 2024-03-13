//
//  Data.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 3/13/24.
//

import CoreFoundation
import Foundation

extension Data {

    public var hexEncodedString: String {
        return map { String(format: "%02X", $0) }.joined()
    }
    
    public var simpleDescription : String {
        if let result = String(data: self, encoding: .utf8) {
            return result.truncate(length:500)
        } else {
            return String(decoding: self, as: UTF8.self).truncate(length:500)
        }
    }
}
