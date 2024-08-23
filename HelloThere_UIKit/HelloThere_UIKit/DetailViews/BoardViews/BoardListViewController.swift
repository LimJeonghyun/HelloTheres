//
//  BoardListViewController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/19.
//

import UIKit

class BoardListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NavigationGoBackDelegate, PostUploadNavigationDelegate {

    var boardTitle: String = ""
    var posts : [Post] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tabBarController?.tabBar.isHidden = true
        
        tableView.backgroundColor = .gray
        
        loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = true
        
        posts = RequestApi.shared.getPosts(boardTitle: boardTitle) // 데이터 새로고침
        tableView.reloadData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func loadUI(){
        posts = RequestApi.shared.getPosts(boardTitle: boardTitle)
        
        let navigationView = BoardNavigationCustom(contentView: view, title: boardTitle)
        navigationView.navigationGoBackDelegate = self
        navigationView.navigationPostDelegate = self
        view.addSubview(navigationView)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }

    // 각 셀에 표시할 데이터를 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 기본 셀 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // 기존 셀의 모든 서브뷰를 제거
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        cell.backgroundColor = .white
        
        let bigStackView = UIStackView()
        bigStackView.axis = .horizontal
        bigStackView.alignment = .leading
        bigStackView.distribution = .fillProportionally
        bigStackView.spacing = 8
        bigStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // StackView 생성
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleStackView = UIStackView()
        titleStackView.axis = .horizontal
        titleStackView.alignment = .leading
        titleStackView.spacing = 5
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let post = posts[indexPath.row]
        
        let truncatedText = post.title.count > 18 ? String(post.title.prefix(18)) + "..." : post.title

        // 글 제목 레이블 생성
        let titleLabel = UILabel()
        titleLabel.text = truncatedText
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = UIColor(hexCode: "5D5D5D")
        
        
        let commentIcon = UIImageView(image: UIImage(systemName: "bubble.left"))
        commentIcon.tintColor = UIColor(hexCode: "2BCBA5")
        commentIcon.translatesAutoresizingMaskIntoConstraints = false
        commentIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        commentIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        let commentLabel = UILabel()
        commentLabel.text = String(post.comment)
        commentLabel.font = UIFont.systemFont(ofSize: 12)
        commentLabel.textColor = UIColor(hexCode: "2BCBA5")
        
        
        let likeIcon = UIImageView(image: UIImage(systemName: "hand.thumbsup"))
        likeIcon.tintColor = UIColor(hexCode: "FF7E55")
        likeIcon.translatesAutoresizingMaskIntoConstraints = false
        likeIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        likeIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        let likeLabel = UILabel()
        likeLabel.text = String(post.like)
        likeLabel.font = UIFont.systemFont(ofSize: 12)
        likeLabel.textColor = UIColor(hexCode: "FF7E55")
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(commentIcon)
        titleStackView.addArrangedSubview(commentLabel)
        titleStackView.addArrangedSubview(likeIcon)
        titleStackView.addArrangedSubview(likeLabel)
        
        // 설명 레이블 생성
        let descriptionLabel = UILabel()
        descriptionLabel.text = post.content
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = UIColor(hexCode: "5D5D5D")
        
        
        let timeLabel = UILabel()
        timeLabel.text = "(3시간 전)"
        timeLabel.font = UIFont.systemFont(ofSize: 11)
        timeLabel.textColor = UIColor(hexCode: "CCCCCC")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let pastDate = dateFormatter.date(from: post.date) {
            // 현재 시간
            let currentDate = Date()

            // 시간 차이 계산
            let timeInterval = currentDate.timeIntervalSince(pastDate)
            let hoursDifference = Int(timeInterval / 3600)
            
            if (hoursDifference >= 24) {
                timeLabel.text = "(\(hoursDifference/24)일 전)"
            } else if ( hoursDifference == 0) {
                timeLabel.text = "(\(Int(timeInterval / 60))분 전)"
            } else {
                timeLabel.text = "(\(hoursDifference)시간 전)"
            }
        } else {
            print("잘못된 날짜 형식")
        }
        
        
        
        
        let viewsLabel = UILabel()
        viewsLabel.text = "조회수 \(post.views)"
        viewsLabel.font = UIFont.systemFont(ofSize: 11)
        viewsLabel.textColor = UIColor(hexCode: "CCCCCC")
        
        let timeAndViewsStack = UIStackView()
        timeAndViewsStack.axis = .horizontal
        timeAndViewsStack.alignment = .leading
        timeAndViewsStack.spacing = 8
        timeAndViewsStack.translatesAutoresizingMaskIntoConstraints = false
        
        timeAndViewsStack.addArrangedSubview(timeLabel)
        timeAndViewsStack.addArrangedSubview(viewsLabel)
        
        // StackView에 레이블 추가
        stackView.addArrangedSubview(titleStackView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(timeAndViewsStack)
        
        
        let iconNoPic = UIImageView()
        iconNoPic.image = UIImage(named: "icon_noPic")
        
        bigStackView.addArrangedSubview(stackView)
        bigStackView.addArrangedSubview(iconNoPic)
        
        // StackView를 셀에 추가
        cell.contentView.addSubview(bigStackView)
        
        // StackView의 오토레이아웃 설정
        NSLayoutConstraint.activate([
            bigStackView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            bigStackView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            bigStackView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            bigStackView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8),
            
            iconNoPic.widthAnchor.constraint(equalToConstant: 80),
            iconNoPic.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        return cell
    }
    
    
    // 셀이 선택되었을 때 실행될 동작 설정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        
        let nextViewController = PostDetailViewController()
        nextViewController.boardTitle = boardTitle
        nextViewController.post = post
        self.navigationController?.pushViewController(nextViewController, animated: true)
        print("선택된 글: \(post.title)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func navigateGoBack() {
        print("go back here")
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigatePostUploadPage() {
        let nextViewController = PostUploadPageViewController()
        nextViewController.boardType = boardTitle
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
}

#Preview {
//        let vc = BoardListViewController()
    let vc = ViewController()
    return vc
}
