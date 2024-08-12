//
//  TopPart.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/12.
//

import UIKit

class TopPartView: UIView {
    var popularPosts : [String] = []
    
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
        
        
        let topPartContainerView = UIView()
        topPartContainerView.translatesAutoresizingMaskIntoConstraints = false
        topPartContainerView.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        topPartContainerView.layer.borderWidth = 2.0
        topPartContainerView.layer.cornerRadius = 20.0
        
        
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
        
        
        readPopularPosts()
        for title in popularPosts {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = UIFont.systemFont(ofSize: 11)
            titleLabel.textColor = UIColor(hexCode: "5D5D5D")
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
        
        maintenancePart.addArrangedSubview(titlePart(titlename: "이달의 관리비", icon: "icon_maintenanceCost"))
        
        
        maintenancePart.addArrangedSubview(getMyMaintenanceState())
        maintenancePart.addArrangedSubview(getMyMaintenanceCost())
        
        
        topPartStackView.addArrangedSubview(maintenancePart)
        
        topPartContainerView.addSubview(topPartStackView)
        contentView.addSubview(topPartContainerView)
        
       
        
        NSLayoutConstraint.activate([
            topPartContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            topPartContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            topPartContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            topPartContainerView.bottomAnchor.constraint(equalTo: topPartStackView.bottomAnchor, constant: 20),
       
            topPartStackView.topAnchor.constraint(equalTo: topPartContainerView.topAnchor, constant: 30),
            topPartStackView.leadingAnchor.constraint(equalTo: topPartContainerView.leadingAnchor, constant: 20),
            topPartStackView.trailingAnchor.constraint(equalTo: topPartContainerView.trailingAnchor, constant: -20),
//
            
            popularBoardListPart.leadingAnchor.constraint(equalTo: topPartStackView.leadingAnchor, constant: 20)
        ])
    }
    
    
    // API로 인기 게시물 내용을 가져올 때 해당 함수를 사용
    // 지금은 메인 페이지에 올 때마다 갱신하지만 하루에 한번만 실행할 수 있도록 하는 부분도 고려해보기
    func readPopularPosts(){
        for i in 1...4 {
            popularPosts.append("title" + String(i))
        }
    }
    
    func getMyMaintenanceState() -> UIImageView {
        var payState = true
        // API로 미납 / 완납 여부를 받아와서 payState 변수로 저장
        
        let stateImage = UIImageView()
        if payState {
            stateImage.image = UIImage(named: "icon_fullPayment")
        }
        else {
            stateImage.image = UIImage(named: "icon_nonPayment")
        }
        
        return stateImage
    }
    
    func getMyMaintenanceCost() -> UILabel{
        var cost = "15799"
        
        let attributedString = NSMutableAttributedString(string: cost + " 원")
        let stringLength = attributedString.length
        
        attributedString.addAttributes([
            .foregroundColor : UIColor(hexCode: "2BCBA5"), .font:UIFont.systemFont(ofSize: 17, weight: .bold)],
                                       range: NSRange(location: 0, length : stringLength - 2)
        )
        attributedString.addAttributes([
            .foregroundColor : UIColor(hexCode: "8F8F8F"), .font:UIFont.systemFont(ofSize: 17, weight: .bold)],
                                       range: NSRange(location: stringLength - 2, length : 2)
        )
        
        let stateLabel = UILabel()
        stateLabel.attributedText = attributedString
        
        return stateLabel
    }
    
    
    func titlePart(titlename : String, icon : String) -> UIStackView {
        let titlePart = UIStackView()
        titlePart.axis = .horizontal
        titlePart.spacing = 5
        titlePart.alignment = .center
        titlePart.distribution = .equalCentering
        titlePart.translatesAutoresizingMaskIntoConstraints = false
        //        titlePart.backgroundColor = .systemPink
        
        
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
}
