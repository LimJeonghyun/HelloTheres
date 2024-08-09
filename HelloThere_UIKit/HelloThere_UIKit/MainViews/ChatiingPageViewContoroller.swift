//
//  ChattingRoomViewController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/09.
//

import UIKit

class ChattingPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel()
        titleLabel.text = "채팅 페이지"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        
        let safeArea = view.safeAreaLayoutGuide
        titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 100).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
