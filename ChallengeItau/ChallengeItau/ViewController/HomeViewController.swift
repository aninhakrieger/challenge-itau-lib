//
//  HomeViewController.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import UIKit


class HomeViewController: BaseViewController {

    var listOfInfo: [Info] = []
    var interactor: SendInformationIteractor?
    let homeButton = ITButton(backgroundColor: .systemPink, title: Constants.Strings.sharedInfo)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configurebutton()
        injectInteractor()
        interactor?.configureLocationManager()
        configureTableView()
    }
    
    func injectInteractor() {
        interactor = SendInformationIteractor(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configurebutton() {
        view.addSubview(tableView)
        view.addSubview(homeButton)
        homeButton.addTarget(self, action: #selector(postSendInformation), for: UIControl.Event.touchUpInside)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            tableView.bottomAnchor.constraint(equalTo: homeButton.topAnchor, constant: -20),
            
            homeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            homeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            homeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            homeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func postSendInformation() {
        self.fullScreenLoading(hide: false)
        interactor?.postSendInfomation()
    }
    
    func fetchListOfInfo(info: MobileInfo, ticket: String) {
        listOfInfo.removeAll()
        listOfInfo.append(.init(label: Constants.Strings.systemUptime, value: info.systemUptime))
        listOfInfo.append(.init(label: Constants.Strings.longitude, value: info.longitude))
        listOfInfo.append(.init(label: Constants.Strings.latitude, value: info.latitude))
        listOfInfo.append(.init(label: Constants.Strings.deviceModel, value: info.deviceModel))
        listOfInfo.append(.init(label: Constants.Strings.altitude, value: info.altitude))
        listOfInfo.append(.init(label: Constants.Strings.ticket, value: ticket))

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController: SendInformationViewControlleProtocol {
    func postSendInfomationSuccess(_ info: MobileInfo, ticket: String) {
        fetchListOfInfo(info: info, ticket: ticket)
        self.fullScreenLoading(hide: true)
        self.presentAlertOnMainThread(title: Constants.Strings.success, message: Constants.Strings.successSendInfo, buttonTitle: Constants.Strings.OK)
    }
    
    func postSendInfomationError(error: Error) {
        self.fullScreenLoading(hide: true)
        self.presentAlertOnMainThread(title: ItauError.unableToComplete.rawValue, message: error.localizedDescription, buttonTitle: Constants.Strings.OK)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = UIListContentConfiguration.valueCell()
        content.text = listOfInfo[indexPath.row].label
        content.secondaryText = listOfInfo[indexPath.row].value
        cell.contentConfiguration = content
        return cell
    }
}
