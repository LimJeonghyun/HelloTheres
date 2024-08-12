//
//  InteriorPartView.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/12.
//

import UIKit

class InteriorPartView: UIView {
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
        let interiorBoardPart = UIStackView()
        interiorBoardPart.axis = .vertical
        interiorBoardPart.alignment = .leading
        interiorBoardPart.spacing = 20
        interiorBoardPart.distribution = .fillProportionally
        interiorBoardPart.translatesAutoresizingMaskIntoConstraints = false
//        interiorBoardPart.backgroundColor = .orange
        
        
        let tmp = utils.boardTitle(partName: "오늘의 홈테리어")
        interiorBoardPart.addArrangedSubview(tmp)
        
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
        
        NSLayoutConstraint.activate([
            boardScrollView.leadingAnchor.constraint(equalTo: interiorBoardPart.leadingAnchor),
            boardScrollView.trailingAnchor.constraint(equalTo: interiorBoardPart.trailingAnchor),
            boardScrollView.topAnchor.constraint(equalTo: tmp.bottomAnchor, constant: 30),
            boardScrollView.heightAnchor.constraint(equalToConstant: 150)
            
        ])
        
        NSLayoutConstraint.activate([
            boardStackView.leadingAnchor.constraint(equalTo: boardScrollView.leadingAnchor),
            boardStackView.trailingAnchor.constraint(equalTo: boardScrollView.trailingAnchor),
            boardStackView.topAnchor.constraint(equalTo: boardScrollView.topAnchor),
            boardStackView.bottomAnchor.constraint(equalTo: boardScrollView.bottomAnchor),
            boardStackView.heightAnchor.constraint(equalTo: boardScrollView.heightAnchor),
            boardStackView.widthAnchor.constraint(equalToConstant: 1000)
        ])
        
        for i in 1...10 {
            let contentView = utils.createContentView(imageName: "test1", text: "Item \(i)")
            boardStackView.addArrangedSubview(contentView)
        }
    

        NSLayoutConstraint.activate([
            
            interiorBoardPart.topAnchor.constraint(equalTo: belowView.bottomAnchor, constant: 30),
            interiorBoardPart.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            interiorBoardPart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
        
    }
}
