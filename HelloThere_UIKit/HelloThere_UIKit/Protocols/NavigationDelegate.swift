//
//  NavigationDelegate.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/19.
//

import UIKit

class BoardTapGesture : UITapGestureRecognizer {
    var data : String?
}

class PostTapGesture: UITapGestureRecognizer {
    var boardName: String?
    var postTitle: String?
}

protocol NavigationDelegate : AnyObject {
    func navigateToNextPage()
    func navigateToBoardDetailPage(with title : String)
    // 현재는 직접 게시글에 대한 제목을 넘겨주지만 api로 연동하는 경우 고유의 게시글의 번호 등을 통해 게시글 구분
    // 게시글 페이지
    func navigateToBoardListPage(with boardName : String)
    // 게시판 리스트 페이지
    func postDetailNavigateToNextPage(boardName: String, postName : String)
    // 게시글 디테일 페이지
}
