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
        
        titlePart.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
        titlePart.isLayoutMarginsRelativeArrangement = true
        
        let title1 = UILabel()
        title1.text =  partName
        title1.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        title1.textColor = UIColor(hexCode: "5D5D5D")
        
        let icon = UIImageView()
        icon.image = UIImage(named: "chervron-right")
        icon.contentMode = .scaleAspectFit
        
        titlePart.addArrangedSubview(title1)
        titlePart.addArrangedSubview(icon)
        
        return titlePart
    }
    
    func createInteriorContentView(imageName: String, text: String) -> UIView {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalStackView = UIStackView(arrangedSubviews: [imageView, label])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 5
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fillProportionally
        verticalStackView.alignment = .leading
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(verticalStackView)
        
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return contentView
    }
    
    func createGarageSaleContentView(imageName: String, text: String) -> UIView {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalStackView = UIStackView(arrangedSubviews: [imageView, label])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 5
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fillProportionally
        verticalStackView.alignment = .leading
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(verticalStackView)
        
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
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
        boardNameLabel.text = boardName
        boardNameLabel.minimumScaleFactor = 0.5
        boardNameLabel.textAlignment = .right
        boardNameLabel.textColor = UIColor(hexCode: "2BCBA5")
        
        
        // 간격을 맞출 수 있는 방법이 없는 듯 하다..
        var word = 9
        if boardName.count <= 7 {
            word = Int(13)
        }
        let str = String(repeating: " ", count: (word - boardName.count))
        
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 12)
        title.minimumScaleFactor = 0.5
        title.textColor = UIColor(hexCode: "8F8F8F")
        title.textAlignment = .right
        title.text =   str + RequestApi.shared.getRecentPostTitle(boardName: boardName)
        
        
        smallBoard.addArrangedSubview(icon)
        smallBoard.addArrangedSubview(boardNameLabel)
        smallBoard.addArrangedSubview(title)
        
        return smallBoard
    }
}
