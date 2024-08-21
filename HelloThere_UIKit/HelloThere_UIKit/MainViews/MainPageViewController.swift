//
//  MainTapViewController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/09.
//

import UIKit

class MainPageViewController: UIViewController, NavigationDelegate {
    
    let scrollView = UIScrollView()
    let scrollContentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // 상단 navigationBar로 인한 빈 공간 없애기
        
        loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollContentView.subviews.forEach { $0.removeFromSuperview() }
        
        loadUI()
    }
    
    func loadUI() {
        let appBarView = AppBarView()
        appBarView.isUserInteractionEnabled = true
        view.addSubview(appBarView)
        
        scrollContent()
        
        view.addSubview(scrollView)
        
        let topPartView = TopPartView(contentView: scrollContentView)
        topPartView.navigationDelegate = self
        topPartView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(topPartView)
        
        
        let boardPartView = BoardPartView(contentView: scrollContentView, belowView: topPartView)
        boardPartView.navigationDelegate = self
        boardPartView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(boardPartView)
        
        
        let interiorPartView = InteriorPartView(contentView: scrollContentView, belowView: boardPartView)
        interiorPartView.navigateDelegate = self
        interiorPartView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(interiorPartView)
        
        
        let garageSalePartView = GarageSalePartView(contentView: scrollContentView, belowView: interiorPartView)
        garageSalePartView.navigateDelegate = self
        garageSalePartView.translatesAutoresizingMaskIntoConstraints = false
        interiorPartView.layer.borderColor = UIColor.systemPink.cgColor
        interiorPartView.layer.borderWidth = 5.0
        scrollContentView.addSubview(garageSalePartView)
        
        
        NSLayoutConstraint.activate([
            
            appBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            appBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            scrollView.topAnchor.constraint(equalTo: appBarView.bottomAnchor, constant:10),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.widthAnchor.constraint(equalTo:  scrollView.widthAnchor),
            
            
            topPartView.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 30),
            topPartView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 15),
            topPartView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -15),
            topPartView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            
            boardPartView.topAnchor.constraint(equalTo: topPartView.bottomAnchor, constant: 30),
            boardPartView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 15),
            boardPartView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -15),
            boardPartView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            
            interiorPartView.topAnchor.constraint(equalTo: boardPartView.bottomAnchor, constant: 30),
            interiorPartView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 15),
            interiorPartView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            
            garageSalePartView.topAnchor.constraint(equalTo: interiorPartView.bottomAnchor, constant: 30),
            garageSalePartView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 15),
            garageSalePartView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor, constant: -30),
            garageSalePartView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }
    
    
    func scrollContent() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(scrollContentView)
    }
    
    func navigateToNextPage() {
        print("nextPage here")
        
        let nextViewController = MaintenanceMainViewController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
    
    func navigateToBoardDetailPage(with title: String) {
        print("boardDetailPage here")
        
        let nextViewController = PostDetailViewController()
        nextViewController.receivedData = title
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
    
    func navigateToBoardListPage(with boardName: String) {
        print("boardListPage here")
        
        let nextViewController = BoardListViewController()
        nextViewController.receivedData = boardName
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
}


#Preview {
    let vc = ViewController()
    return vc
}
