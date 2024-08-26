//
//  FullScreenImageViewController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/23.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    
    var imageView = UIImageView()
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // 이미지 뷰 설정
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        // 이미지 뷰의 Auto Layout 설정
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 탭 제스처 추가 (화면을 누르면 닫기)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullScreen))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissFullScreen() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
