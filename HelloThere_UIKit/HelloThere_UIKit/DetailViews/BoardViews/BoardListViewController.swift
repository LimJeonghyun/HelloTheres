//
//  BoardListViewController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/19.
//

import UIKit

class BoardListViewController: UIViewController {
    
    var receivedData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let navigationBar = UIView()
        navigationBar.backgroundColor = .white
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = UIButton(type : .system)
        backButton.setImage(UIImage(systemName: "chevron.left"),for: .normal)
        backButton.tintColor = UIColor(hexCode: "5D5D5D")
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = receivedData
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = UIColor(hexCode: "2BCBA5")
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        navigationBar.addSubview(stackView)
        
        let label = UILabel()
        label.text = "게시판 목록 들어올 페이지"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(navigationBar)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 16),
            stackView.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            
            label.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant : 15)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
