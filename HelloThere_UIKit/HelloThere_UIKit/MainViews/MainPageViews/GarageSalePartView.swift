//
//  GarageSalePartView.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/12.
//

import UIKit

class GarageSalePartView: UIView {
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
        let garageSaleBoardPart = UIStackView()
        garageSaleBoardPart.axis = .vertical
        garageSaleBoardPart.alignment = .leading
        garageSaleBoardPart.spacing = 20
        garageSaleBoardPart.distribution = .fillProportionally
        garageSaleBoardPart.translatesAutoresizingMaskIntoConstraints = false
//        garageSaleBoardPart.backgroundColor = .orange
        
        
        let tmp = utils.boardTitle(partName: "중고장터")
        garageSaleBoardPart.addArrangedSubview(tmp)
        
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
        
        garageSaleBoardPart.addArrangedSubview(boardScrollView)
        contentView.addSubview(garageSaleBoardPart)
        
        NSLayoutConstraint.activate([
            garageSaleBoardPart.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
//
        NSLayoutConstraint.activate([
            boardScrollView.leadingAnchor.constraint(equalTo: garageSaleBoardPart.leadingAnchor),
            boardScrollView.trailingAnchor.constraint(equalTo: garageSaleBoardPart.trailingAnchor),
            boardScrollView.topAnchor.constraint(equalTo: tmp.bottomAnchor, constant: 10),
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
            let contentView = utils.createContentView(imageName: "test2", text: "Item \(i)")
            boardStackView.addArrangedSubview(contentView)
        }
    

        NSLayoutConstraint.activate([
            
            garageSaleBoardPart.topAnchor.constraint(equalTo: belowView.bottomAnchor, constant: 30),
            garageSaleBoardPart.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            garageSaleBoardPart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
        
    }
}
