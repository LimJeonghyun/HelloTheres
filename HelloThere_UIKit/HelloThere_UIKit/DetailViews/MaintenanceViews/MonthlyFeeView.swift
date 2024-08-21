//
//  MonthlyFeeView.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/21.
//

import UIKit
import DropDown

extension MaintenanceMainViewController {
    
    func monthlyFeeStackView(currentMonth : Int) -> UIStackView {
        let monthlyFeeStackView = UIStackView()
        monthlyFeeStackView.axis = .horizontal
        monthlyFeeStackView.alignment = .center
        monthlyFeeStackView.spacing = 5
        monthlyFeeStackView.distribution = .fillProportionally
        monthlyFeeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        for i in 1...currentMonth {
            months.append(String(i) + "월")
        }
        
        
        var titleAttr = AttributedString.init("\(currentMonth)월")
        titleAttr.foregroundColor = UIColor(hexCode: "5D5D5D")
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor =  UIColor(hexCode: "F1F1F1")
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        config.attributedTitle = titleAttr
        config.image = UIImage(systemName: "chevron.down")
        let imageColor = UIImage.SymbolConfiguration(paletteColors: [UIColor(hexCode: "2BCBA4")])
        config.preferredSymbolConfigurationForImage = imageColor
        monthSelectButton.configuration = config
        monthSelectButton.addTarget(self, action: #selector(toggleDropDown), for: .touchUpInside)
        
        
        
        let monthlyFeeLabel = UILabel()
        monthlyFeeLabel.text = "의 관리비"
        monthlyFeeLabel.textColor = UIColor(hexCode: "5D5D5D")
        
        monthlyFeeStackView.addArrangedSubview(monthSelectButton)
        monthlyFeeStackView.addArrangedSubview(monthlyFeeLabel)
        
        
        return monthlyFeeStackView
    }
    
    @objc func  toggleDropDown() {
        let dropDown = DropDown()
        dropDown.dataSource = months
        dropDown.show()
        dropDown.anchorView = monthSelectButton
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.cornerRadius = 15
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            monthSelectButton.setTitle(" \(item)", for: .normal)
            monthSelectButton.setTitleColor(UIColor(hexCode: "5D5D5D"), for: .normal)
            clickedMonth = index + 1
        }
    }
}

#Preview {
    let vc = MaintenanceMainViewController()
    return vc
}
