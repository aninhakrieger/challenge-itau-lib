//
//  HomeViewController.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import UIKit
import CoreLocation

class HomeViewController: BaseViewController {
    
    let homeButton = ITButton(backgroundColor: .systemPink, title: "Compartilhar informações")
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews = [UIView]()
    
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
            homeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            homeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            homeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func postSendInformation() {
        self.fullScreenLoading(hide: false)
        
        if let bootTime = bootTime() {
            info.systemUptime = bootTime.toStringDate()
        }
        print(info)
        SendInformationGateway.shared.postSendInformation(data: info) { result in
            self.fullScreenLoading(hide: true)
            switch result {
            case .success(_): self.presentAlertOnMainThread(title: "Sucesso", message: "Informações compartilhadas com sucesso.", buttonTitle: "OK")
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
