//
//  HomeViewController.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import UIKit


class HomeViewController: BaseViewController {

    var interactor: SendInformationIteractor?
    let homeButton = ITButton(backgroundColor: .systemPink, title: "Compartilhar informações")
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configurebutton()
        injectInteractor()
        interactor?.configureLocationManager()
    }
    
    func injectInteractor() {
        interactor = SendInformationIteractor(viewController: self)
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
        interactor?.postSendInfomation()
    }
}

extension HomeViewController: SendInformationViewControlleProtocol {
    func postSendInfomationSuccess() {
        self.fullScreenLoading(hide: true)
        self.presentAlertOnMainThread(title: "Sucesso", message: "Informações compartilhadas com sucesso.", buttonTitle: "OK")
    }
    
    func postSendInfomationError(error: Error) {
        self.fullScreenLoading(hide: true)
        self.presentAlertOnMainThread(title: "Bad Stuff Happend", message: error.localizedDescription, buttonTitle: "OK")
    }
}
