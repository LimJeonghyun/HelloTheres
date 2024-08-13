//
//  ViewController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 7/9/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = .white
        
        let nextPageButton : UIButton = .init(frame : .init())
        nextPageButton.backgroundColor = .systemPink
        nextPageButton.setTitle("로그인 화면이 될 예정입니다", for: .normal)
        nextPageButton.addTarget(self, action: #selector(setBtnTap), for: .touchUpInside)
        
        self.view.addSubview(nextPageButton)
        nextPageButton.translatesAutoresizingMaskIntoConstraints = false
        nextPageButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        nextPageButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100).isActive = true
    }
    
    
    @objc
    func setBtnTap() {
        let nextVC  = TabBarController()
        nextVC.selectedIndex = 1
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = nextVC
            UIView.transition(with: window, duration: 0.5, animations: nil, completion: nil)
        }
    }
}

