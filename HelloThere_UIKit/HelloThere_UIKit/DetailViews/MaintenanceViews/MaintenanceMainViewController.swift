//
//  MaintenanceMainViewController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/19.
//

import UIKit

class MaintenanceMainViewController: UIViewController, NavigationGoBackDelegate {
    
    var months : [String] = []
    let monthSelectButton = UIButton()
    let monthFeeTextField = UITextField()
    let radioButton1 = UIButton(type: .custom)
    let radioButton2 = UIButton(type: .custom)
    var selectedRadioButton: UIButton?
    var currentMonth : Int = 0
    var monthFee : String = ""
    var isPaid : Bool = false
    var clickedMonth : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = .white
        
        currentMonth = getCurrentMonth()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        let navigationView = NavigationGoBackCustomView(contentView: view)
        navigationView.navigationDelegate = self
        view.addSubview(navigationView)
        
        
        let monthlyFeeStackView = monthlyFeeStackView(currentMonth : currentMonth)
        view.addSubview(monthlyFeeStackView)
        
        
        let paymentStatusStackView = paymentStatusStackView(currentMonth : currentMonth)
        view.addSubview(paymentStatusStackView)
        
        
        let monthlyFeeGraphStackView = monthlyFeeGraphStackView()
        view.addSubview(monthlyFeeGraphStackView)
        
        
        var titleAttr = AttributedString.init("저장")
        titleAttr.font = .systemFont(ofSize: 18.0, weight: .heavy)
        titleAttr.foregroundColor = UIColor.white
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor =  UIColor(hexCode: "2BCBA5")
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        config.attributedTitle = titleAttr
        let storeButton = UIButton(configuration: config)
        storeButton.layer.cornerRadius = 30  // 둥글게 설정
        storeButton.layer.masksToBounds = true
        storeButton.translatesAutoresizingMaskIntoConstraints = false
        
        storeButton.addTarget(self, action: #selector(storeButtonTapped), for: .touchUpInside)
        
        view.addSubview(storeButton)
        
        
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            
            
            monthlyFeeStackView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 50),
            monthlyFeeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            monthlyFeeStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            
            paymentStatusStackView.topAnchor.constraint(equalTo: monthlyFeeStackView.bottomAnchor, constant:  40),
            paymentStatusStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            paymentStatusStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentStatusStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 240),
            //
            //
            //
            monthlyFeeGraphStackView.topAnchor.constraint(equalTo: paymentStatusStackView.bottomAnchor, constant:  40),
            monthlyFeeGraphStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            monthlyFeeGraphStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            monthlyFeeGraphStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 300),
            
            
            storeButton.topAnchor.constraint(equalTo: monthlyFeeGraphStackView.bottomAnchor, constant:  80),
            storeButton.heightAnchor.constraint(equalToConstant: 58),
            storeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            storeButton.widthAnchor.constraint(greaterThanOrEqualToConstant:240),
        ])
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //    func goBack() {
    //        self.navigationController?.popViewController(animated: true)
    //    }
    
    func navigateGoBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getCurrentMonth() -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        
        return currentMonth
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func storeButtonTapped(_ sender: UIButton) {
        print("send here postMonthFeeData \(monthFee) \(isPaid)")
        RequestApi.shared.postMonthFeeData(fee: monthFee, isPaid: isPaid)
        monthFee = ""
        isPaid = false
        self.navigationController?.popViewController(animated: true)
    }
}

#Preview {
    let vc = MaintenanceMainViewController()
    return vc
}
