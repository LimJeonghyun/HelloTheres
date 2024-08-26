//
//  BoardNavigationCustom.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/23.
//

import UIKit

class BoardNavigationCustom: UIView {
    
    weak var navigationGoBackDelegate : NavigationGoBackDelegate?
    weak var navigationPostDelegate : PostUploadNavigationDelegate?
    
    init(contentView: UIView, title : String) {
        super.init(frame: .zero)
        setupView(contentView: contentView, title : title)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(contentView: UIView(), title : "기본 제목")
    }
    
    private func setupView(contentView: UIView, title : String) {
        
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
        
        
        let logoStackView = UIStackView(arrangedSubviews: [logo, titleLabel])
        logoStackView.axis = .vertical
        logoStackView.alignment = .center
        logoStackView.spacing = 8
        logoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let writingButton = UIButton(type: .system)
        writingButton.tintColor = UIColor(hexCode: "2BCBA5")
        writingButton.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .medium) // 아이콘 크기 설정
        config.image = UIImage(systemName: "plus.circle.fill", withConfiguration: imageConfig)
        config.baseBackgroundColor = .white
        config.baseForegroundColor = UIColor(hexCode: "2BCBA5")
        
        var titleAttr = AttributedString("글쓰기")
        titleAttr.font = UIFont.systemFont(ofSize: 12, weight: .bold)  // 글씨 크기와 스타일 설정
        titleAttr.foregroundColor = UIColor(hexCode: "2BCBA5")         // 글씨 색상 설정
        
        config.attributedTitle = titleAttr
        config.contentInsets = NSDirectionalEdgeInsets(top:20, leading: 20, bottom: 20, trailing: 20)
        writingButton.configuration = config
        
        writingButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        
        self.addSubview(backButton)
        self.addSubview(logoStackView)
        self.addSubview(writingButton)
        
        
        contentView.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.heightAnchor.constraint(equalToConstant: 40),
            
            logoStackView.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            writingButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            writingButton.centerYAnchor.constraint(equalTo: logoStackView.centerYAnchor, constant: 10),
        ])
    }
    
    @objc func goBack() {
        print("here")
        navigationGoBackDelegate?.navigateGoBack()
    }
    
    @objc func buttonClicked() {
        print("writingButton clicked")
        navigationPostDelegate?.navigatePostUploadPage()
    }
}
