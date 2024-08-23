//
//  PostDetailViewController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/19.
//

import UIKit

class PostDetailViewController: UIViewController, NavigationGoBackDelegate {
    
    var boardTitle: String = ""
    var postTitle : String = ""
    var direct = false
    var post : Post = Post(title: "제목 없음", content: "내용 없음", date: "2024-08-22", views: 0, comment: 0, like: 0, nickName: "없음")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = .white
        
        let navigationView = PostNavigationCustom(contentView: view, title: boardTitle, rightMenu: "menu")
        navigationView.navigationDelegate = self
        view.addSubview(navigationView)
        
        let titleStackView = UIStackView()
        titleStackView.axis = .horizontal
        titleStackView.alignment = .leading
        titleStackView.spacing = 5
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        let iconStackView = UIStackView()
        iconStackView.axis = .horizontal
        iconStackView.alignment = .leading
        iconStackView.spacing = 5
        iconStackView.translatesAutoresizingMaskIntoConstraints = false
        //
        //        // 글 제목 레이블 생성
        let titleLabel = UILabel()
        if (direct) {
            titleLabel.text = postTitle
        } else {
            titleLabel.text = post.title
        }
        
        //        post.title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = UIColor(hexCode: "5D5D5D")
        //
        //
        let commentIcon = UIImageView(image: UIImage(systemName: "bubble.left"))
        commentIcon.tintColor = UIColor(hexCode: "2BCBA5")
        commentIcon.translatesAutoresizingMaskIntoConstraints = false
        commentIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        commentIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        let commentLabel = UILabel()
        commentLabel.text = String(post.comment)
        commentLabel.font = UIFont.systemFont(ofSize: 12)
        commentLabel.textColor = UIColor(hexCode: "2BCBA5")
        //
        //
        let likeIcon = UIImageView(image: UIImage(systemName: "hand.thumbsup"))
        likeIcon.tintColor = UIColor(hexCode: "FF7E55")
        likeIcon.translatesAutoresizingMaskIntoConstraints = false
        likeIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        likeIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        //
        let likeLabel = UILabel()
        likeLabel.text = String(post.like)
        likeLabel.font = UIFont.systemFont(ofSize: 12)
        likeLabel.textColor = UIColor(hexCode: "FF7E55")
        
        iconStackView.addArrangedSubview(commentIcon)
        iconStackView.addArrangedSubview(commentLabel)
        iconStackView.addArrangedSubview(likeIcon)
        iconStackView.addArrangedSubview(likeLabel)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(iconStackView)
        
        view.addSubview(titleStackView)
        
        
        let lineView = LineView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = UIColor(hexCode: "F1F1F1")
        
        view.addSubview(lineView)
        
        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.spacing = 30
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let userStack = UIStackView()
        userStack.axis = .horizontal
        userStack.spacing = 10
        userStack.translatesAutoresizingMaskIntoConstraints = false
        
        let userNickname = UILabel()
        userNickname.text = post.nickName
        //        post.nickName
        userNickname.textColor = UIColor(hexCode: "2BCBA5")
        userNickname.font = UIFont.systemFont(ofSize: 12)
        
        let userWritingTime = UILabel()
        userWritingTime.text = "\(post.date) 작성"
        userWritingTime.textColor = (UIColor(hexCode: "CCCCCC"))
        userWritingTime.font = UIFont.systemFont(ofSize: 12)
        
        userStack.addArrangedSubview(userNickname)
        userStack.addArrangedSubview(userWritingTime)
        
        contentView.addArrangedSubview(userStack)
        
        let contentLabel = UILabel()
        contentLabel.text = post.content
        contentLabel.textColor = UIColor(hexCode: "5D5D5D")
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = . byWordWrapping
        contentView.addArrangedSubview(contentLabel)
        
        
        
        let boardScrollView = UIScrollView()
        boardScrollView.translatesAutoresizingMaskIntoConstraints = false
        boardScrollView.showsHorizontalScrollIndicator = false
        boardScrollView.isPagingEnabled = false
        boardScrollView.alwaysBounceHorizontal = true
        
        
        
        let boardStackView = UIStackView()
        boardStackView.translatesAutoresizingMaskIntoConstraints = false
        boardStackView.axis = .horizontal
        boardStackView.spacing = 10
        boardStackView.alignment = .fill
        boardStackView.distribution = .fillEqually
        
        boardScrollView.addSubview(boardStackView)
        contentView.addArrangedSubview(boardScrollView)
        
        view.addSubview(contentView)
        
        for i in 0...6 {
            let contentView =  UIImageView()
            contentView.image = UIImage(named: "icon_noPic")
            contentView.contentMode = .scaleToFill
            contentView.clipsToBounds = true
            contentView.translatesAutoresizingMaskIntoConstraints = false
            
            contentView.isUserInteractionEnabled = true
            
            
            boardStackView.addArrangedSubview(contentView)
            
            NSLayoutConstraint.activate([
                contentView.widthAnchor.constraint(equalToConstant: 100), // 각 이미지의 너비 설정
                contentView.heightAnchor.constraint(equalToConstant: 100) // 각 이미지의 높이 설정
            ])
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            contentView.addGestureRecognizer(tapGesture)
            //            contentView.addGestureRecognizer(tapGestureLabel)
        }
        
        
        let underLineView = LineView()
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = UIColor(hexCode: "F1F1F1")
        
        view.addSubview(underLineView)
        
        
        
        
        
        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor),
            titleStackView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 10),
            
            
            iconStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            lineView.widthAnchor.constraint(equalTo: titleStackView.widthAnchor,constant: 4),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            
            
            contentView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            
            boardScrollView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            boardScrollView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            boardScrollView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 30),
            boardScrollView.heightAnchor.constraint(equalToConstant: 150),
            
            boardStackView.leadingAnchor.constraint(equalTo: boardScrollView.leadingAnchor),
            boardStackView.trailingAnchor.constraint(equalTo: boardScrollView.trailingAnchor),
            boardStackView.topAnchor.constraint(equalTo: boardScrollView.topAnchor),
            boardStackView.bottomAnchor.constraint(equalTo: boardScrollView.bottomAnchor),
            
            underLineView.widthAnchor.constraint(equalTo: titleStackView.widthAnchor,constant: 4),
            underLineView.heightAnchor.constraint(equalToConstant: 1),
            underLineView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            underLineView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            
            
        ])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func navigateGoBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let tappedImageView = sender.view as? UIImageView, let image = tappedImageView.image {
            let fullScreenVC = FullScreenImageViewController()
            fullScreenVC.modalPresentationStyle = .fullScreen
            fullScreenVC.image = image // 이미지 전달
            self.present(fullScreenVC, animated: true, completion: nil)
        }
    }
}
