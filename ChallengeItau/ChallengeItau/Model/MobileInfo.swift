//
//  MobileInfo.swift
//  GitFollowers
//
//  Created by Ana Krieger on 16/12/22.
//

import Foundation
import UIKit

struct MobileInfo: Codable {
    var systemUptime: String
    var latitude: String
    var longitude: String
    var altitude: String
    var deviceModel: String
    
    enum CodingKeys: String, CodingKey {
        case systemUptime = "SystemUptime"
        case latitude
        case longitude
        case altitude
        case deviceModel
    }
}
