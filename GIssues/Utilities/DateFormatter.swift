//
//  DateFormatter.swift
//  GIssues
//
//  Created by SATOSHI OKI on 12/19/18.
//

import Foundation

extension DateFormatter {

    static let fullDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .autoupdatingCurrent
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "YYYY/MM/dd HH:mm:ss"
        return formatter
    }()
}
