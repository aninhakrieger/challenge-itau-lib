//
//  ITContainerView.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import UIKit

class ITContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(backgorungColor: UIColor = .systemBackground){
        backgroundColor = backgorungColor
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 16
        layer.borderWidth = 2
        translatesAutoresizingMaskIntoConstraints = false
    }
}
