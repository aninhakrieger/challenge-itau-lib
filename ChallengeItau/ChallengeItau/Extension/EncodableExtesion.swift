//
//  EncodableExtesion.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any] {
        (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
