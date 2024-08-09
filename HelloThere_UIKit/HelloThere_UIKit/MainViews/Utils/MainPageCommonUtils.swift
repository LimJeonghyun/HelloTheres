//
//  ViewController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/09.
//

import UIKit

class MainPageCommonUtils {
    
    func boardTitle(partName : String) -> UIStackView {
        let titlePart = UIStackView()
        titlePart.axis = .horizontal
        titlePart.alignment = .center
        titlePart.distribution = .equalCentering
        titlePart.translatesAutoresizingMaskIntoConstraints = false
//        titlePart.backgroundColor = .systemPink
        
        titlePart.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
        titlePart.isLayoutMarginsRelativeArrangement = true
        
        let title1 = UILabel()
        title1.text =  partName
        title1.font = UIFont.systemFont(ofSize: 16)
        title1.textColor = .black
        
        let icon = UIImageView()
        icon.image = UIImage(named: "chervron-right")
        icon.contentMode = .scaleAspectFit
        
        titlePart.addArrangedSubview(title1)
        titlePart.addArrangedSubview(icon)
        
        return titlePart
    }
    
    func createContentView(imageName: String, text: String) -> UIView {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = text
        label.textAlignment = .left
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalStackView = UIStackView(arrangedSubviews: [imageView, label])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 5
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(verticalStackView)
        
        // verticalStackView 제약조건 설정
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        // 이미지와 텍스트의 크기 설정
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return contentView
    }

    func boardList(boardName : String) -> UIStackView{
        let smallBoard = UIStackView()
        smallBoard.axis = .horizontal
        smallBoard.alignment = .center
        smallBoard.distribution = .fillProportionally
        smallBoard.spacing = 5
        smallBoard.translatesAutoresizingMaskIntoConstraints = false
//        smallBoard.backgroundColor = .systemCyan
        
        let icon = UIImageView()
        icon.image = UIImage(named : "icon_boardName")
        
        let boardNameLabel = UILabel()
        boardNameLabel.adjustsFontSizeToFitWidth = true
        boardNameLabel.translatesAutoresizingMaskIntoConstraints = false
        boardNameLabel.font = UIFont.systemFont(ofSize: 12)
        boardNameLabel.minimumScaleFactor = 0.5
        boardNameLabel.textAlignment = .right
        boardNameLabel.textColor = .green
        boardNameLabel.text = String(boardName.prefix(10))
        
        let containerView = UIView()
        containerView.backgroundColor = .lightGray
        containerView.layer.cornerRadius = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(boardNameLabel)
        
        
        let title = UILabel()
        title.adjustsFontSizeToFitWidth = true
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 12)
        title.minimumScaleFactor = 0.5
        title.textColor = .gray
        title.textAlignment = .right
        let text = " |   테스트"
        title.text = String(text.prefix(10))
        
        
        smallBoard.addArrangedSubview(icon)
        smallBoard.addArrangedSubview(boardNameLabel)
        smallBoard.addArrangedSubview(title)
        
        return smallBoard
    }
    
}
