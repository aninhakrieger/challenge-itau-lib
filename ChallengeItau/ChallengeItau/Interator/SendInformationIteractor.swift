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
    func postSendInfomation(bootTime: String)
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
    
    func postSendInfomation(bootTime: String) {
        info.systemUptime = bootTime
        
        print(info)
        
        SendInformationGateway.shared.postSendInformation(data: info) { result in
            switch result {
            case .success(_): self.viewController?.postSendInfomationSuccess()
            case .failure(let erro): self.viewController?.postSendInfomationError(error: erro)
            }
        }
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
