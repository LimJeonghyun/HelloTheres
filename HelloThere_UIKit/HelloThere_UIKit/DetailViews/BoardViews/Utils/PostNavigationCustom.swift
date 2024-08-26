//
//  PostNavigationCustom.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/23.
//

import UIKit

class PostNavigationCustom: UIView {
    
    weak var navigationDelegate: NavigationGoBackDelegate?
    
    init(contentView: UIView, title : String, rightMenu : String) {
        super.init(frame: .zero)
        setupView(contentView: contentView, title : title, rightMenu : rightMenu)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(contentView: UIView(), title : "기본 제목", rightMenu : "")
    }
    
    private func setupView(contentView: UIView, title : String, rightMenu : String) {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        
        let backButton = UIButton(type : .system)
        backButton.setImage(UIImage(systemName: "chevron.left"),for: .normal)
        backButton.tintColor = UIColor(hexCode: "5D5D5D")
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = UIColor(hexCode: "5D5D5D")
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let logo = UIImageView()
        logo.image = UIImage(named: "logo_noHand")
        let menuButton = UIButton()
        
        let logoStackView = UIStackView()
        logoStackView.axis = .horizontal
        logoStackView.alignment = .center
        logoStackView.spacing = 8
        logoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        if (rightMenu == "menu") {
            menuButton.setImage(UIImage(named: "icon_menu"), for: .normal)
            menuButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            logoStackView.addArrangedSubview(backButton)
        } else {
            menuButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            menuButton.tintColor = UIColor(hexCode: "2BCBA5")
            menuButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
            menuButton.translatesAutoresizingMaskIntoConstraints = false
        }
        
        logoStackView.addArrangedSubview(logo)
        logoStackView.addArrangedSubview(titleLabel)
        logoStackView.addArrangedSubview(menuButton)
        
        
        
        self.addSubview(logoStackView)
        self.addSubview(menuButton)
        
        
        
        contentView.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.heightAnchor.constraint(equalToConstant: 40),
            
            menuButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func goBack() {
        navigationDelegate?.navigateGoBack()
    }
    
    @objc func buttonTapped() {
        print("button tapped")
    }
}
