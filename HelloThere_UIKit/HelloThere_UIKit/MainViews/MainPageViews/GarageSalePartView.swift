//
//  GarageSalePartView.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/12.
//

import UIKit

class GarageSalePartView: UIView {
    let utils = MainPageCommonUtils()
    let api = RequestApi()
    
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
        
        
        let boardTitle = utils.boardTitle(partName: "중고장터")
        garageSaleBoardPart.addArrangedSubview(boardTitle)
        
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
        
        var contents = api.getRecentGarageSalePost()
        
        for i in 0...6 {
            let contentView = utils.createGarageSaleContentView(imageName:contents[i][0], text: contents[i][1])
            boardStackView.addArrangedSubview(contentView)
        }
        
        
        
        NSLayoutConstraint.activate([
            boardScrollView.leadingAnchor.constraint(equalTo: garageSaleBoardPart.leadingAnchor),
            boardScrollView.trailingAnchor.constraint(equalTo: garageSaleBoardPart.trailingAnchor),
            boardScrollView.topAnchor.constraint(equalTo: boardTitle.bottomAnchor, constant: 30),
            boardScrollView.heightAnchor.constraint(equalToConstant: 150),
            
            boardStackView.leadingAnchor.constraint(equalTo: boardScrollView.leadingAnchor),
            boardStackView.trailingAnchor.constraint(equalTo: boardScrollView.trailingAnchor),
            boardStackView.topAnchor.constraint(equalTo: boardScrollView.topAnchor),
            boardStackView.bottomAnchor.constraint(equalTo: boardScrollView.bottomAnchor),
            boardStackView.heightAnchor.constraint(equalTo: boardScrollView.heightAnchor),
            boardStackView.widthAnchor.constraint(equalToConstant: 700),
            
            garageSaleBoardPart.topAnchor.constraint(equalTo: belowView.bottomAnchor, constant: 30),
            garageSaleBoardPart.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            garageSaleBoardPart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
        ])
        
    }
}
