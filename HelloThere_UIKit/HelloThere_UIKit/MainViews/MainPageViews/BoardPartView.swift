//
//  BoardPartView.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/12.
//

import UIKit

class BoardPartView: UIView {
    let utils = MainPageCommonUtils()
    
    init(contentView: UIView, belowView: UIView) {
        super.init(frame: .zero)
        setupView(contentView: contentView, belowView: belowView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(contentView: UIView(), belowView: UIView())
    }
    
    private func setupView(contentView: UIView, belowView: UIView) {
        let boardPartStackView = UIStackView()
        boardPartStackView.axis = .vertical
        boardPartStackView.alignment = .leading
        boardPartStackView.spacing = 20
        boardPartStackView.distribution = .fillProportionally
        boardPartStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let boardListStackView = UIStackView()
        boardListStackView.axis = .vertical
        boardListStackView.alignment = .leading
        boardListStackView.distribution = .equalCentering
        boardListStackView.spacing = 15
        boardListStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        boardListStackView.addArrangedSubview(utils.boardList(boardName: "자유소통 게시판"))
        boardListStackView.addArrangedSubview(utils.boardList(boardName: "갈등 소통 게시판"))
        boardListStackView.addArrangedSubview(utils.boardList(boardName: "공구/나눔 게시판"))
        boardListStackView.addArrangedSubview(utils.boardList(boardName: "중고장터 게시판"))
        boardListStackView.addArrangedSubview(utils.boardList(boardName: "정보공유 게시판"))
        boardListStackView.addArrangedSubview(utils.boardList(boardName: "질문 게시판"))
        
        
        boardPartStackView.addArrangedSubview(utils.boardTitle(partName: "주민 게시판"))
        boardPartStackView.addArrangedSubview(boardListStackView)
        
        contentView.addSubview(boardPartStackView)
        
        NSLayoutConstraint.activate([
            boardPartStackView.topAnchor.constraint(equalTo: belowView.bottomAnchor, constant: 30),
            boardPartStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            boardPartStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            boardPartStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
        
    }
}
