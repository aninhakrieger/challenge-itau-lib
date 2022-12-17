//
//  DateExtesion.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import Foundation

extension Date {
    func toStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ssss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
}
