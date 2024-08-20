//
//  AppBarView.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/09.
//

import UIKit

class AppBarView: UIStackView {
    let api = RequestApi()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        axis = .horizontal
        alignment = .fill
        distribution = .fillProportionally
        spacing = 10
        translatesAutoresizingMaskIntoConstraints = false
        // autolayout을 사용할 때는 false로 설정
        
        
        let logoStackView = UIStackView()
        logoStackView.axis = .vertical
        logoStackView.alignment = .leading
        logoStackView.spacing = 10
        logoStackView.distribution = .fillProportionally
        logoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .top
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let logo = UIImageView()
        logo.image = UIImage(named: "logo_noHand")
        logo.contentMode = .scaleAspectFit
        
        let userAddressInfo = api.getUserAddress()
        let aptNameLabel = UILabel()
        aptNameLabel.text = userAddressInfo[0]
        aptNameLabel.textAlignment = .left
        aptNameLabel.font = aptNameLabel.font.withSize(22)
        aptNameLabel.textColor = .black
        
        let userAddress = UILabel()
        userAddress.text = userAddressInfo[1]
        userAddress.textAlignment = .left
        userAddress.font = userAddress.font.withSize(12)
        userAddress.textColor = .black
        
        logoStackView.addArrangedSubview(logo)
        logoStackView.addArrangedSubview(aptNameLabel)
        logoStackView.addArrangedSubview(userAddress)
        
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(named: "icon_search")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        let notiButton = UIButton(type: .system)
        notiButton.setImage(UIImage(named: "icon_noti")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        buttonStackView.addArrangedSubview(searchButton)
        buttonStackView.addArrangedSubview(notiButton)
        
        addArrangedSubview(logoStackView)
        addArrangedSubview(buttonStackView)
    }
}
