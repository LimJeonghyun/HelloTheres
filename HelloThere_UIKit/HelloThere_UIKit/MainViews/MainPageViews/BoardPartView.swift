//
//  BoardPartView.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/12.
//

import UIKit

class BoardPartView: UIStackView, UIGestureRecognizerDelegate {
    let utils = MainPageCommonUtils()
    weak var navigationDelegate : NavigationDelegate?
    
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
        
        let boardListStackView = UIStackView()
        boardListStackView.axis = .vertical
        boardListStackView.alignment = .leading
        boardListStackView.distribution = .equalCentering
        boardListStackView.spacing = 15
        boardListStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let boardNameLists = ["자유소통 게시판", "갈등 소통 게시판", "공구/나눔 게시판", "중고장터 게시판", "정보공유 게시판", "질문 게시판"]
        
        for boardName in boardNameLists{
            let boardNameLabel = utils.boardList(boardName: boardName)
            
            boardNameLabel.isUserInteractionEnabled = true
            let tapGesture = BoardTapGesture(target: self, action: #selector(boardTapped(_:)))
            tapGesture.data = boardName
            boardNameLabel.addGestureRecognizer(tapGesture)
            
            boardListStackView.addArrangedSubview(boardNameLabel)
            
        }
        
        
        self.addArrangedSubview(utils.boardTitle(partName: "주민 게시판"))
        self.addArrangedSubview(boardListStackView)
        
        contentView.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: belowView.bottomAnchor, constant: 30),
            self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            self.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func boardTapped(_ sender : BoardTapGesture) {
        print("board clicked")
        
        if let data = sender.data {
            navigationDelegate?.navigateToBoardListPage(with: data)
        }
    }
}
