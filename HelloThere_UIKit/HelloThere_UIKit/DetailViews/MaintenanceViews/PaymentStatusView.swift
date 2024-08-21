//
//  PaymentStatusView.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/21.
//

import UIKit

extension MaintenanceMainViewController {
    
    func paymentStatusStackView(currentMonth : Int) -> UIStackView {
        let paymentStatusStackView = UIStackView()
        paymentStatusStackView.axis = .vertical
        paymentStatusStackView.alignment = .center
        paymentStatusStackView.distribution = .fillProportionally
        paymentStatusStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let fee : String = RequestApi.shared.getMonthFee(currentMonth: clickedMonth)
        if (fee.isEmpty) {
            monthFeeTextField.placeholder = "관리비를 입력해주세요"
        } else {
            monthFeeTextField.placeholder = fee + "원"
        }
        monthFeeTextField.textAlignment = .center
        
        monthFeeTextField.borderStyle = .none
        monthFeeTextField.layer.cornerRadius = 20  // 둥글게 설정
        monthFeeTextField.layer.masksToBounds = true
        monthFeeTextField.layer.borderWidth = 1.5  // 테두리 두께 설정
        monthFeeTextField.layer.borderColor = UIColor(hexCode: "CCCCCC").cgColor
        monthFeeTextField.textColor = UIColor(hexCode: "5D5D5D")
        monthFeeTextField.keyboardType = .numberPad
        
        
        var titleAttr = AttributedString.init("입력완료")
        titleAttr.font = .systemFont(ofSize: 12.0, weight: .heavy)
        titleAttr.foregroundColor = UIColor.white
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(hexCode: "2BCBA5")
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        config.attributedTitle = titleAttr
        
        let submitButton = UIButton(configuration: config)
        submitButton.layer.cornerRadius = 12
        submitButton.sizeToFit()
        submitButton.layer.masksToBounds = true
        submitButton.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
        
        
        let rightViewContainer = UIView(frame : CGRect(x : 0, y : 0, width : submitButton.frame.width + 10, height : submitButton.frame.height))
        
        rightViewContainer.addSubview(submitButton)
        
        
        monthFeeTextField.rightView = rightViewContainer
        monthFeeTextField.rightViewMode = .always
        monthFeeTextField.rightView?.isUserInteractionEnabled = true
        
        paymentStatusStackView.addArrangedSubview(monthFeeTextField)
        
        
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .center
        buttonStackView.spacing = 20
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        radioButton1.setTitle("관리비 미납", for: .normal)
        radioButton1.setTitleColor(UIColor(hexCode : "5D5D5D"), for: .normal)
        radioButton1.setImage(UIImage(systemName: "circle"), for: .normal)
        radioButton1.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected)
        radioButton1.tintColor = UIColor(hexCode: "2BCBA5")
        radioButton1.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        radioButton1.frame = CGRect(x: 50, y: 200, width: 150, height: 50)
        radioButton1.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        
        
        radioButton2.setTitle("관리비 완납", for: .normal)
        radioButton2.setTitleColor(UIColor(hexCode : "5D5D5D"), for: .normal)
        radioButton2.setImage(UIImage(systemName: "circle"), for: .normal)
        radioButton2.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected)
        radioButton2.tintColor = UIColor(hexCode: "2BCBA5")
        radioButton2.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        radioButton2.frame = CGRect(x: 50, y: 300, width: 150, height: 50)
        radioButton2.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(radioButton1)
        buttonStackView.addArrangedSubview(radioButton2)
        //        buttonStackView.backgroundColor = .yellow
        buttonStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        paymentStatusStackView.addArrangedSubview(buttonStackView)
        
        
        let label = UILabel()
        label.text = "* 납부 상태를 체크 해주세요"
        label.textColor = UIColor(hexCode: "FF7E55")
        label.font = UIFont.systemFont(ofSize: 14)
        //        label.backgroundColor = .gray
        
        paymentStatusStackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            monthFeeTextField.widthAnchor.constraint(equalToConstant: 240),
            monthFeeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            submitButton.trailingAnchor.constraint(equalTo: rightViewContainer.trailingAnchor, constant: -5),
            submitButton.centerYAnchor.constraint(equalTo: rightViewContainer.centerYAnchor),
            
            
            label.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
        return paymentStatusStackView
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        print("here")
        if let text = monthFeeTextField.text, !text.isEmpty {
            print("입력된 값: \(text)")
            monthFee = text
            monthFeeTextField.text = ""
        } else {
            print("TextField is empty.")
        }
        view.endEditing(true)
    }
    
    @objc func radioButtonTapped(_ sender: UIButton) {
        // 선택된 라디오 버튼이 이미 선택된 상태이면 아무 작업도 하지 않음
        if selectedRadioButton == sender {
            return
        }
        
        // 이전에 선택된 라디오 버튼 선택 해제
        selectedRadioButton?.isSelected = false
        
        // 새로운 라디오 버튼 선택
        sender.isSelected = true
        selectedRadioButton = sender
        
        print("\(sender.currentTitle ?? "") selected")
        
        if (sender.currentTitle == "관리비 완납")
        {
            isPaid = true
        } else
        {
            isPaid = false
        }
    }
    
}
