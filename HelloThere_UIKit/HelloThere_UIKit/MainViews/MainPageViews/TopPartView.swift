//
//  TopPart.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/12.
//

import UIKit

class TopPartView: UIView, UIGestureRecognizerDelegate {
    var popularPosts : [Post] = []
    weak var navigationDelegate : NavigationDelegate?
    
    private var maintenanceStateImageView: UIImageView!
    private var maintenanceCostLabel: UILabel!
    
    
    init(contentView: UIView) {
        super.init(frame: .zero)
        setupView(contentView: contentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(contentView: UIView())
    }
    
    private func setupView(contentView: UIView) {
        let topPartStackView = UIStackView()
        topPartStackView.axis = .horizontal
        topPartStackView.alignment = .leading
        topPartStackView.spacing = 10
        topPartStackView.distribution = .fillEqually
        topPartStackView.translatesAutoresizingMaskIntoConstraints = false
        topPartStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        topPartStackView.isLayoutMarginsRelativeArrangement = true
        topPartStackView.isUserInteractionEnabled = true
        
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 20.0
        
        
        let popularBoardPart = UIStackView()
        popularBoardPart.axis = .vertical
        popularBoardPart.alignment = .center
        popularBoardPart.spacing = 20
        popularBoardPart.distribution = .fillProportionally
        popularBoardPart.translatesAutoresizingMaskIntoConstraints = false
        
        
        let popularBoardListPart = UIStackView()
        popularBoardListPart.axis = .vertical
        popularBoardListPart.alignment = .leading
        popularBoardListPart.spacing = 15
        popularBoardListPart.distribution = .fillEqually
        popularBoardListPart.translatesAutoresizingMaskIntoConstraints = false
        
        
        popularPosts = RequestApi.shared.getPopularPosts()
        for post in popularPosts {
            let titleLabel = UILabel()
            titleLabel.text = post.title
            titleLabel.font = UIFont.systemFont(ofSize: 11)
            titleLabel.textColor = UIColor(hexCode: "5D5D5D")
            
            titleLabel.isUserInteractionEnabled = true
            let tapGestureLabel = PostTapGesture(target : self, action : #selector(labelTapped(_:)))
            tapGestureLabel.boardName = "인기 게시글"
            tapGestureLabel.postInfo = post
            titleLabel.addGestureRecognizer(tapGestureLabel)
            
            popularBoardListPart.addArrangedSubview(titleLabel)
        }
        
        popularBoardPart.addArrangedSubview(titlePart(titlename: "인기 게시물", icon: "icon_popularPosts"))
        popularBoardPart.addArrangedSubview(popularBoardListPart)
        
        
        topPartStackView.addArrangedSubview(popularBoardPart)
        
        
        let maintenancePart = UIStackView()
        maintenancePart.axis = .vertical
        maintenancePart.alignment = .center
        maintenancePart.spacing = 30
        maintenancePart.distribution = .fillProportionally
        maintenancePart.translatesAutoresizingMaskIntoConstraints = false
        //        maintenancePart.backgroundColor = .white
        
        maintenancePart.addArrangedSubview(titlePart(titlename: "이달의 관리비", icon: "icon_maintenanceCost"))
        
        
        //        maintenanceStateImageView.image = RequestApi.shared.getMyMaintenanceState().image
        //        maintenanceCostLabel.attributedText = RequestApi.shared.getMyMaintenanceCost().attributedText
        //
        //        maintenancePart.addArrangedSubview(maintenanceStateImageView)
        //        maintenancePart.addArrangedSubview(maintenanceCostLabel)
        maintenancePart.addArrangedSubview(RequestApi.shared.getMyMaintenanceState())
        maintenancePart.addArrangedSubview(RequestApi.shared.getMyMaintenanceCost())
        
        
        topPartStackView.addArrangedSubview(maintenancePart)
        
        self.addSubview(topPartStackView)
        contentView.addSubview(self)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
        tapGesture.cancelsTouchesInView = false
        maintenancePart.addGestureRecognizer(tapGesture)
        
        
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            self.bottomAnchor.constraint(equalTo: topPartStackView.bottomAnchor, constant: 20),
            
            topPartStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            topPartStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            topPartStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            
            popularBoardListPart.leadingAnchor.constraint(equalTo: topPartStackView.leadingAnchor, constant: 20)
        ])
    }
    
//    func updateContent() {
//        maintenanceStateImageView.image = RequestApi.shared.getMyMaintenanceState().image
//        maintenanceCostLabel.attributedText = RequestApi.shared.getMyMaintenanceCost().attributedText
//    }
    
    func titlePart(titlename : String, icon : String) -> UIStackView {
        let titlePart = UIStackView()
        titlePart.axis = .horizontal
        titlePart.spacing = 5
        titlePart.alignment = .center
        titlePart.distribution = .equalCentering
        titlePart.translatesAutoresizingMaskIntoConstraints = false
        
        
        let popularIcon = UIImageView()
        popularIcon.image = UIImage(named: icon)
        popularIcon.contentMode = .scaleAspectFit
        
        let popularText = UILabel()
        popularText.text = titlename
        popularText.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        popularText.textColor = UIColor(hexCode: "2BCBA5")
        
        titlePart.addArrangedSubview(popularIcon)
        titlePart.addArrangedSubview(popularText)
        
        
        return titlePart
    }
    
    @objc func labelTapped(_ sender: PostTapGesture) {
        print("toppart label clicked")
        if let data = sender.postInfo, let title = sender.boardName {
            navigationDelegate?.postDetailNavigateToNextPageWithPost(boardName: title, postName: data)
        }
    }
    
    @objc func stackViewTapped() {
        print("toppart stackView clicked")
        navigationDelegate?.navigateToNextPage()
    }
}
