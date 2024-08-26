//
//  MonthlyFeeGraphStackView.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/21.
//

import UIKit

extension MaintenanceMainViewController {
    
    func monthlyFeeGraphStackView() -> UIStackView {
        let monthlyGraphStackView = UIStackView()
        monthlyGraphStackView.axis = .vertical
        monthlyGraphStackView.alignment = .center
        monthlyGraphStackView.spacing = 10
        monthlyGraphStackView.distribution = .fillProportionally
        monthlyGraphStackView.translatesAutoresizingMaskIntoConstraints = false
        monthlyGraphStackView.backgroundColor = .white
        
        
        let titleLabel = UILabel()
        titleLabel.text = "월별 그래프"
        titleLabel.textColor = UIColor(hexCode: "5D5D5D")
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = true
        
        
        var months : [String] = []
        if (currentMonth == 1) {
            months = ["11월", "12월", "1월"]
        } else if (currentMonth == 2) {
            months = ["12월", "1월", "2월"]
        } else {
            for i in currentMonth - 2 ... currentMonth {
                months.append(String(i) + "월")
            }
        }
        
        let data = RequestApi.shared.getMonthlyFeeData(currentMonth: currentMonth)
        let feeDiff = RequestApi.shared.getMonthlyFeeDiff(currentMonth: currentMonth)
        
        
        let graphStackView = UIStackView()
        graphStackView.axis = .horizontal
        graphStackView.alignment = .bottom
        graphStackView.spacing = 40
        graphStackView.distribution = .fillEqually
        graphStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, value) in data.enumerated() {
            let barStackView = UIStackView()
            barStackView.axis = .vertical
            barStackView.alignment = .center
            barStackView.spacing = 5
            barStackView.distribution = .fill
            barStackView.translatesAutoresizingMaskIntoConstraints = false
            
            
            let valueLabel = UILabel()
            if (value == -1) {
                valueLabel.text = "미입력"
            } else {
                valueLabel.text = "\(value)"
            }
            valueLabel.font = .systemFont(ofSize: 10)
            valueLabel.textAlignment = .center
            valueLabel.textColor = UIColor(hexCode: "5D5D5D")
            
            // 막대 그래프
            let barView = UIView()
            if (value == -1) {
                barView.backgroundColor = UIColor(hexCode: "CCCCCC")
            } else {
                if (feeDiff[index] == "down") {
                    barView.backgroundColor = UIColor(hexCode: "2BCBA5")
                } else {
                    barView.backgroundColor = UIColor(hexCode: "FF7E55")
                }
                
            }
            barView.layer.cornerRadius = 5
            barView.translatesAutoresizingMaskIntoConstraints = false
            
            
            if (value == -1) {
                barView.heightAnchor.constraint(equalToConstant: CGFloat(10)).isActive = true
            }else {
                barView.heightAnchor.constraint(equalToConstant: CGFloat(value/1000)).isActive = true
            }
            
            barView.widthAnchor.constraint(equalToConstant:45).isActive = true
            
            
            
            let monthLabel = UILabel()
            monthLabel.text = months[index]
            monthLabel.font = .systemFont(ofSize: 12)
            monthLabel.textAlignment = .center
            monthLabel.textColor = UIColor(hexCode: "5D5D5D")
            
            
            barStackView.addArrangedSubview(valueLabel)
            barStackView.addArrangedSubview(barView)
            barStackView.addArrangedSubview(monthLabel)
            
            graphStackView.addArrangedSubview(barStackView)
        }
        
        
        monthlyGraphStackView.addArrangedSubview(titleLabel)
        monthlyGraphStackView.addArrangedSubview(graphStackView)
        
        
        return monthlyGraphStackView
    }
}

#Preview {
    let vc = MaintenanceMainViewController()
    return vc
}
