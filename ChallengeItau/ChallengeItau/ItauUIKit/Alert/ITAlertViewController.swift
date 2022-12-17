//
//  ITAlertViewController.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import UIKit

class ITAlertViewController: UIViewController {
    
    let containerView = ITContainerView()
    let titleLabel = ITTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = ITBodyLabel(textAlignment: .center )
    let btnAlert = ITButton(backgroundColor: .systemPink, title: "OK")
    
    var alertTitle: String?
    var messageTitle: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title:String, message: String, buttonTitle:String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.messageTitle = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "blackTransparence")
        configureContainerView()
        configureTitleLabel()
        configureButton()
        configureMessageLabel()
    }
    
    func configureContainerView(){
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureButton(){
        containerView.addSubview(btnAlert)
        btnAlert.setTitle(buttonTitle ?? "OK", for: .normal)
        btnAlert.addTarget(self, action: #selector(dismissvc), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            btnAlert.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -padding),
            btnAlert.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            btnAlert.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            btnAlert.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func configureMessageLabel(){
        containerView.addSubview(messageLabel)
        messageLabel.text = messageTitle ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: btnAlert.topAnchor, constant: -12)
        ])
    }
    
    @objc func dismissvc(){
        dismiss(animated: true)
    }
}
