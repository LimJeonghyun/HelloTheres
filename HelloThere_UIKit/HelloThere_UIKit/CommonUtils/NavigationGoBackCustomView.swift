//
//  NavigationGoBackCustomViewController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/20.
//

import UIKit

protocol NavigationGoBackDelegate : AnyObject{
    func navigateGoBack()
}

class NavigationGoBackCustomView: UIView {
    weak var navigationDelegate: NavigationGoBackDelegate?
    init(contentView: UIView) {
        super.init(frame: .zero)
        setupView(contentView: contentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(contentView: UIView())
    }
    
    private func setupView(contentView: UIView) {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = UIButton(type : .system)
        backButton.setImage(UIImage(systemName: "chevron.left"),for: .normal)
        backButton.tintColor = UIColor(hexCode: "5D5D5D")
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "이달의 관리비"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = UIColor(hexCode: "2BCBA5")
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        contentView.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    @objc func goBack() {
        navigationDelegate?.navigateGoBack()
    }
    

}
