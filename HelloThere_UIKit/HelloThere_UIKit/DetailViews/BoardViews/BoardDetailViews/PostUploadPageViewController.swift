//
//  PostUploadPageViewController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/23.
//

import UIKit

class PostUploadPageViewController: UIViewController, NavigationGoBackDelegate, UITextViewDelegate  {
    
    var boardTitle : String?
    let navigationDelegate : NavigationGoBackDelegate? = nil
    var placeholderText : String?
    
    let titleTextField = UITextField()
    let textView = UITextView()
    let button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = true
        
        placeholderText = "[\(boardTitle ?? "")]\n내용을 입력하세요"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
        
        let navigationView = PostNavigationCustom(contentView: view, title: "글쓰기", rightMenu: "x")
        navigationView.navigationDelegate = self
        
        view.addSubview(navigationView)
        
        let lineView = LineView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = UIColor(hexCode: "F1F1F1")
        
        view.addSubview(lineView)
        
        let titleStackView = UIStackView()
        titleStackView.axis = .horizontal
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.spacing = 10
        
        let titleLabel = UILabel()
        titleLabel.text = "제목 : "
        titleLabel.textColor = UIColor(hexCode: "8F8F8F")
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleStackView.addArrangedSubview(titleLabel)
        
        
        titleTextField.placeholder = "제목을 입력하세요."
        titleStackView.addArrangedSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.textColor = UIColor(hexCode: "8F8F8F")
        
        
        view.addSubview(titleStackView)
        
        let underLineView = LineView()
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = UIColor(hexCode: "F1F1F1")
        
        view.addSubview(underLineView)
        
       
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = UIColor.darkGray

        textView.backgroundColor = UIColor(hexCode :"#DCF0EB")
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.isScrollEnabled = true // 스크롤 가능하도록 설정
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.text = placeholderText
        
        view.addSubview(textView)
        
        
        button.setTitle("게시", for: .normal)
        button.backgroundColor = UIColor(hexCode: "2BCBA5")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
               
               // 버튼 둥글게 설정
        button.layer.cornerRadius = 10  // 높이의 절반
        button.layer.masksToBounds = true
               
               // 버튼 액션 추가
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
               
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            lineView.widthAnchor.constraint(equalTo: view.widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            
            titleTextField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            titleTextField.widthAnchor.constraint(equalTo : view.safeAreaLayoutGuide.widthAnchor, constant: -30),
            
            titleStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 15),
            titleStackView.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor),
            //            titleStackView.widthAnchor.constraint(equalTo : view.safeAreaLayoutGuide.widthAnchor, constant: -30),
            
            
            underLineView.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor),
            underLineView.widthAnchor.constraint(equalTo: titleTextField.widthAnchor),
            underLineView.heightAnchor.constraint(equalToConstant: 1),
            underLineView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 10),
            
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.topAnchor.constraint(equalTo: underLineView.topAnchor, constant: 20),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
            
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: textView.trailingAnchor)

        ])
    }
    

    @objc func navigateGoBack() {
        print("here")
        self.navigationController?.popViewController(animated: true)
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
             textView.text = ""
             textView.textColor = UIColor.black
         }
        }
        
        // 텍스트 뷰에 아무것도 입력하지 않고 편집이 끝날 때 placeholder 텍스트를 다시 보여줌
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = placeholderText
                textView.textColor = UIColor.lightGray
            }
        }
    
    
    @objc func buttonTapped() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        print("textView : \(textView.text)\n")
        let formattedDate = dateFormatter.string(from: Date())
        RequestApi.shared.postPost(title: titleTextField.text ?? "제목 없음", content: textView.text ?? "내용 없음", date: formattedDate, views: 0, comment: 0, like: 0, nickName: "멋찐 깜자", boardTitle: boardTitle ?? "게시판 해당 안됨")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
