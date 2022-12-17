//
//  HomeViewController.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    let homeButton = ITButton(backgroundColor: .systemPurple, title: "Compartilhar informações")
    var info: MobileInfo = .init(systemUptime: "", latitude: "", longitude: "", altitude: "", deviceModel: UIDevice.current.name)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configurebutton()
        configureLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configurebutton() {
        view.addSubview(homeButton)
        homeButton.addTarget(self, action: #selector(postSendInformation), for: UIControl.Event.touchUpInside)
        
        NSLayoutConstraint.activate([
            homeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            homeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            homeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            homeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func postSendInformation() {
        SendInformationGateway.shared.postSendInformation(data: info) { result in
            switch result {
            case .success(let info):
                print(info.ticket ?? "")
                
            case .failure(let error): self.presentAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureLocationManager() {
        GeolocationService.shared.delegate = self
        GeolocationService.shared.getGPSLocation()
    }
}

extension HomeViewController: LocationDelegate {
    func getLocation(location: CLLocation) {
        info.latitude = "\(location.coordinate.latitude)"
        info.longitude = "\(location.coordinate.longitude)"
        info.altitude = "\(location.altitude)"
    }
}
