//
//  GarageSalePartView.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/12.
//

import UIKit

class GarageSalePartView: UIStackView {
    let utils = MainPageCommonUtils()
    let api = RequestApi()
    weak var navigateDelegate : NavigationDelegate?
    
    init(contentView: UIView, belowView: UIView) {
        super.init(frame: .zero)
        setupView(contentView: contentView, belowView: belowView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView(contentView: UIView, belowView: UIView) {
        axis = .vertical
        alignment = .leading
        spacing = 20
        distribution = .fillProportionally
        translatesAutoresizingMaskIntoConstraints = false
        
        
        let boardTitle = utils.boardTitle(partName: "중고장터")
        boardTitle.isUserInteractionEnabled = true
        let tapGesture = BoardTapGesture(target: self, action: #selector(boardTapped(_:)))
        tapGesture.data = "중고장터"
        boardTitle.addGestureRecognizer(tapGesture)
        
        
        self.addArrangedSubview(boardTitle)
        
        
        let boardScrollView = UIScrollView()
        boardScrollView.translatesAutoresizingMaskIntoConstraints = false
        boardScrollView.showsHorizontalScrollIndicator = false
        
        let boardStackView = UIStackView()
        boardStackView.translatesAutoresizingMaskIntoConstraints = false
        boardStackView.axis = .horizontal
        boardStackView.spacing = 10
        boardStackView.alignment = .fill
        boardStackView.distribution = .fillEqually
        
        boardScrollView.addSubview(boardStackView)
        self.addArrangedSubview(boardScrollView)
        contentView.addSubview(self)
        
        var contents = api.getRecentGarageSalePost()
        
        for i in 0...6 {
            let contentView = utils.createGarageSaleContentView(imageName:contents[i][0], text: contents[i][1])
            
            if (i < 6) {
                contentView.isUserInteractionEnabled = true
                let tapGestureLabel = BoardTapGesture(target: self, action: #selector(labelTapped(_:)))
                tapGestureLabel.data = contents[i][1]
                contentView.addGestureRecognizer(tapGestureLabel)
                
                boardStackView.addArrangedSubview(contentView)
            }
            else{
                contentView.isUserInteractionEnabled = true
                let tapGestureLabel = BoardTapGesture(target: self, action: #selector(boardTapped(_:)))
                tapGestureLabel.data = "중고장터"
                contentView.addGestureRecognizer(tapGestureLabel)
                
                boardStackView.addArrangedSubview(contentView)
            }
            
            boardStackView.addArrangedSubview(contentView)
        }
        
        
        
        NSLayoutConstraint.activate([
            boardScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            boardScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            boardScrollView.topAnchor.constraint(equalTo: boardTitle.bottomAnchor, constant: 30),
            boardScrollView.heightAnchor.constraint(equalToConstant: 150),
            
            boardStackView.leadingAnchor.constraint(equalTo: boardScrollView.leadingAnchor),
            boardStackView.trailingAnchor.constraint(equalTo: boardScrollView.trailingAnchor),
            boardStackView.topAnchor.constraint(equalTo: boardScrollView.topAnchor),
            boardStackView.bottomAnchor.constraint(equalTo: boardScrollView.bottomAnchor),
            boardStackView.heightAnchor.constraint(equalTo: boardScrollView.heightAnchor),
            boardStackView.widthAnchor.constraint(equalToConstant: 700),
            
            self.topAnchor.constraint(equalTo: belowView.bottomAnchor, constant: 30),
            self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
        ])
    }
    
    @objc func boardTapped(_ sender : BoardTapGesture) {
        print("board garageSale clicked")
        
        if let data = sender.data {
            navigateDelegate?.navigateToBoardListPage(with: data)
        }
    }
    
    @objc func labelTapped(_ sender : BoardTapGesture) {
        print("boardGarageSlae detail clicked")
        
        if let data = sender.data {
            navigateDelegate?.navigateToBoardDetailPage(with: data)
        }
    }
}
