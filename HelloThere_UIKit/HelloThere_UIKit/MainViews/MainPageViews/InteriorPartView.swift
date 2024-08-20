//
//  InteriorPartView.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/12.
//

import UIKit

class InteriorPartView: UIView {
    let utils = MainPageCommonUtils()
    let api = RequestApi()
    weak var navigateDelegate : NavigationDelegate?
    
    init(contentView: UIView, belowView: UIView) {
        super.init(frame: .zero)
        setupView(contentView: contentView, belowView: belowView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(contentView: UIView(), belowView: UIView())
    }
    
    private func setupView(contentView: UIView, belowView: UIView) {
        let interiorBoardPart = UIStackView()
        interiorBoardPart.axis = .vertical
        interiorBoardPart.alignment = .leading
        interiorBoardPart.spacing = 20
        interiorBoardPart.distribution = .fillProportionally
        interiorBoardPart.translatesAutoresizingMaskIntoConstraints = false
        
        
        let boardTitle = utils.boardTitle(partName: "오늘의 홈테리어")
        boardTitle.isUserInteractionEnabled = true
        let tapGesture = BoardTapGesture(target: self , action: #selector(boardTapped(_:)))
        tapGesture.data = "오늘의 홈테리어"
        boardTitle.addGestureRecognizer(tapGesture)
        
        
        interiorBoardPart.addArrangedSubview(boardTitle)
        
        
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
        interiorBoardPart.addArrangedSubview(boardScrollView)
        contentView.addSubview(interiorBoardPart)
        
        
        var contents = api.getRecentInteriorPost()
        
        for i in 0...6 {
            
            let contentView = utils.createInteriorContentView(imageName:contents[i][0], text: contents[i][1])
            
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
                tapGestureLabel.data = "오늘의 홈테리어"
                contentView.addGestureRecognizer(tapGestureLabel)
                
                boardStackView.addArrangedSubview(contentView)
            }
            
            boardStackView.addArrangedSubview(contentView)
        }
        
        
        NSLayoutConstraint.activate([
            boardScrollView.leadingAnchor.constraint(equalTo: interiorBoardPart.leadingAnchor),
            boardScrollView.trailingAnchor.constraint(equalTo: interiorBoardPart.trailingAnchor),
            boardScrollView.topAnchor.constraint(equalTo: boardTitle.bottomAnchor, constant: 30),
            boardScrollView.heightAnchor.constraint(equalToConstant: 150),
            
            
            boardStackView.leadingAnchor.constraint(equalTo: boardScrollView.leadingAnchor),
            boardStackView.trailingAnchor.constraint(equalTo: boardScrollView.trailingAnchor),
            boardStackView.topAnchor.constraint(equalTo: boardScrollView.topAnchor),
            boardStackView.bottomAnchor.constraint(equalTo: boardScrollView.bottomAnchor),
            boardStackView.heightAnchor.constraint(equalTo: boardScrollView.heightAnchor),
            boardStackView.widthAnchor.constraint(equalToConstant: 700),
            
            
            
            interiorBoardPart.topAnchor.constraint(equalTo: belowView.bottomAnchor, constant: 30),
            interiorBoardPart.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            interiorBoardPart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
        ])
    }
    
    @objc func boardTapped(_ sender : BoardTapGesture) {
        print("board Interior clicked")
        
        if let data = sender.data {
            navigateDelegate?.navigateToBoardListPage(with: data)
        }
    }
    
    @objc func labelTapped(_ sender : BoardTapGesture) {
        print("boardInterior detail clicked")
        
        if let data = sender.data {
            navigateDelegate?.navigateToBoardDetailPage(with: data)
        }
    }
}
