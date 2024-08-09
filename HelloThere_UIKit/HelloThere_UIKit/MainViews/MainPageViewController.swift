//
//  MainTapViewController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/09.
//

import UIKit

class MainPageViewController: UIViewController {
    
    let contentViewFactory = MainPageCommonUtils()
    
    let containerView1 = UIView()
    let topStackView = UIStackView()
    let logoStackView = UIStackView()
    let buttonStackView = UIStackView()
    let scrollView = UIScrollView()
    let firstPart = UIStackView()
    let contentView = UIView()
    let boardListPart = UIStackView()
    let interiorBoardPart = UIStackView()
    let garageSaleBoardPart = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let appBarView = AppBarView()
        view.addSubview(appBarView)
        
        NSLayoutConstraint.activate([
            appBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            appBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ])
    }
}


#Preview {
    let vc = MainPageViewController()
    return vc
}
