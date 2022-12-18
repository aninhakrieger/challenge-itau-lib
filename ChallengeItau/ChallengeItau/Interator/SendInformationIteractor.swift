//
//  SendInformationIteractor.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 18/12/22.
//

import Foundation
import CoreLocation
import UIKit

protocol SendInformationIteractorProtocol: AnyObject {
    func postSendInfomation()
    func configureLocationManager()
}

final class SendInformationIteractor: SendInformationIteractorProtocol {
    private weak var viewController: SendInformationViewControlleProtocol?
    var info: MobileInfo
    
    init(viewController: SendInformationViewControlleProtocol) {
        self.viewController = viewController
        info = .init(systemUptime: "", latitude: "", longitude: "", altitude: "", deviceModel: UIDevice.current.name)
    }
    
    func configureLocationManager() {
        GeolocationService.shared.delegate = self
        GeolocationService.shared.getGPSLocation()
    }
    
    func postSendInfomation() {
        if let bootTime = bootTime() {
            info.systemUptime = bootTime.toStringDate()
        }
        
        print(info)
        
        SendInformationGateway.shared.postSendInformation(data: info) { result in
            switch result {
            case .success(_): self.viewController?.postSendInfomationSuccess()
            case .failure(let erro): self.viewController?.postSendInfomationError(error: erro)
            }
        }
    }
    
    func bootTime() -> Date? {
        var tv = timeval()
        var tvSize = MemoryLayout<timeval>.size
        let err = sysctlbyname("kern.boottime", &tv, &tvSize, nil, 0);
        guard err == 0, tvSize == MemoryLayout<timeval>.size else {
            return nil
        }
        return Date(timeIntervalSince1970: Double(tv.tv_sec) + Double(tv.tv_usec) / 1_000_000.0)
    }
}

extension SendInformationIteractor: LocationDelegate {
    func getLocation(location: CLLocation) {
        info.latitude = "\(location.coordinate.latitude)"
        info.longitude = "\(location.coordinate.longitude)"
        info.altitude = "\(location.altitude)"
    }
}

protocol SendInformationViewControlleProtocol: AnyObject {
    func postSendInfomationSuccess()
    func postSendInfomationError(error: Error)
}
