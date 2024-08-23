//
//  RequestApi.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/13.
//

import UIKit

struct Post {
    let title : String
    let content : String
    let date : String
    let views : Int
    let comment : Int
    let like : Int
    let nickName : String
}


class RequestApi {
    static let shared = RequestApi()
    
    private init() {}
    
    var data = [101000, 109000, -1]
    var payState = false
    
    var userPost:[Post] = []
    var userPostFree:[Post] = []
    var userPostConflic:[Post] = []
    var userPostTool:[Post] = []
    var userPostGarage:[Post] = []
    var userPostInfo:[Post] = []
    var userPostQuestion:[Post] = []
    var userPostInterior:[Post] = []
    
    // AppBarView
    // 유저의 주소를 읽어오는 API함수
    func getUserAddress() -> [String]{
        var userAddress : [String] = []
        
        userAddress.append("테스트 오피스텔")
        userAddress.append("테스트시 테스트구 테스트동 123-45 123호")
        
        print(userAddress)
        return userAddress
    }
    
    //     TopPartView
    //     API로 인기 게시물 내용을 가져올 때 해당 함수를 사용
    //     지금은 메인 페이지에 올 때마다 갱신하지만 하루에 한번만 실행할 수 있도록 하는 부분도 고려해보기
    func getPopularPosts() -> [String]{
        var popularPosts : [String] = []
        for i in 1...4 {
            popularPosts.append("title" + String(i))
        }
        
        return popularPosts
    }
    
    // 미납 / 완납 이미지 표시를 위한 미남 / 완납 여부 API로 읽어오기
    func getMyMaintenanceState() -> UIImageView {
        // API로 미납 / 완납 여부를 받아와서 payState 변수로 저장
        
        let stateImage = UIImageView()
        if payState {
            stateImage.image = UIImage(named: "icon_fullPayment")
        }
        else {
            stateImage.image = UIImage(named: "icon_nonPayment")
        }
        
        return stateImage
    }
    
    // 관리비를 API로 불러오기
    func getMyMaintenanceCost() -> UILabel{
        var cost = String(data[2])
        
        if (data[2] == -1) {
            cost = "103000"
        }
        
        let attributedString = NSMutableAttributedString(string: cost + " 원")
        let stringLength = attributedString.length
        
        attributedString.addAttributes([
            .foregroundColor : UIColor(hexCode: "2BCBA5"), .font:UIFont.systemFont(ofSize: 17, weight: .bold)],
                                       range: NSRange(location: 0, length : stringLength - 2)
        )
        attributedString.addAttributes([
            .foregroundColor : UIColor(hexCode: "8F8F8F"), .font:UIFont.systemFont(ofSize: 17, weight: .bold)],
                                       range: NSRange(location: stringLength - 2, length : 2)
        )
        
        let stateLabel = UILabel()
        stateLabel.attributedText = attributedString
        
        return stateLabel
    }
    
    // BoardPartView
    // 게시판 별 최근 글 제목에 대한 API
    func getRecentPostTitle(boardName: String) -> String {
        return "|   테스트"
    }
    
    // InteriorPartView
    // 홈인테리어 사진이랑 제목 API로 가져오기
    func getRecentInteriorPost() -> [[String]]{
        var posts : [[String]] = []
        
        for i in 0...5 {
            posts.append(["test1", "\(i+1)번째 인텔이어"])
        }
        posts.append(["icon_morePost", " "])
        
        return posts
    }
    
    // 중고장터 사진이랑 제목 API로 가져오기
    func getRecentGarageSalePost() -> [[String]]{
        var posts : [[String]] = []
        
        for i in 0...5 {
            posts.append(["test2", "\(i+1)번째 상품"])
        }
        posts.append(["icon_morePost", " "])
        
        return posts
    }
    
    // 현재 달에 해당하는 관리비 데이터가 있으면 가져오기
    func getMonthFee(currentMonth : Int) -> String {
        var fee : String
        if (data[2] == -1 || currentMonth != 8) {
            fee = ""
        } else {
            fee = String(data[2])
        }
        
        print("checkPoing : \(fee)")
        return fee
    }
    
    // 현재 달에 해당하는 관리비와 완납 여부를 db로 전달
    func postMonthFeeData(fee : String, isPaid : Bool) {
        if (!fee.isEmpty){
            print("입력된 값 : " + fee)
            data[2] = Int(fee) ?? -1
            print(data[2])
        }
        
        payState = isPaid
        if (isPaid){
            print("완납")
        }else{
            print("미납")
        }
        
        print("checkPoint : \(data[2]) \(payState)")
    }
    
    // 현재달을 포함하여 3개월 관리비 데이터
    func getMonthlyFeeData(currentMonth : Int) -> [Int] {
        var monthFeeData : [Int] = []
        var index = 0
        
        print("checkPoint \(data[2])")
        for i in currentMonth - 2 ... currentMonth {
            monthFeeData.append(data[index])
            index+=1
        }
        
        return monthFeeData
    }
    
    // 이전달과 비교하여 현재 달의 관리비가 올랐는지 하락했는지 데이터를 받아오기
    func getMonthlyFeeDiff(currentMonth : Int) -> [String] {
        var feeData = ["down", "up", ""]
        
        if (data[1] >= data[2]) {
            feeData[2] = "down"
        } else {
            feeData[2] = "up"
        }
        
        print("checkPoint \(feeData[2])")
        
        var monthFeeData : [String] = []
        var index = 0
        
        for i in currentMonth - 2 ... currentMonth {
            monthFeeData.append(feeData[index])
            index+=1
        }
        
        return monthFeeData
    }
    
    func getPosts(boardTitle : String) -> [Post] {
        var posts = [
            Post(title :"\(boardTitle) 첫 번째 게시물", content: "\(boardTitle)  첫 번째 게시물 내용", date : "2024-08-22 12:35", views : 3, comment: 3, like : 1, nickName : "닉네임 1"),
            Post(title :"\(boardTitle) 첫 번째 게시물", content: "\(boardTitle)  첫 번째 게시물 내용", date : "2024-08-22 12:35", views : 3, comment: 3, like : 1, nickName : "닉네임 1"),
            Post(title :"\(boardTitle) 두 번째 게시물", content: "\(boardTitle) 두 번째 게시물 내용", date : "2024-08-22 12:00", views : 10, comment: 3, like : 1, nickName : "닉네임 2"),
            Post(title :"\(boardTitle) 세 번째 게시물", content: "\(boardTitle) 세 번째 게시물 내용", date : "2024-08-22 11:35", views : 0, comment: 3, like : 1, nickName : "닉네임 3"),
            Post(title :"\(boardTitle) 네 번째 게시물", content: "\(boardTitle) 네 번째 게시물 내용", date : "2024-08-22 10:35", views : 1, comment: 3, like : 1, nickName : "닉네임 4"),
            Post(title :"\(boardTitle) 다섯 번째 게시물", content: "\(boardTitle) 다섯 번째 게시물 내용", date : "2024-08-21 22:35", views : 5, comment: 3, like : 1, nickName : "닉네임 5"),
            Post(title :"\(boardTitle) 여섯 번째 게시물", content: "\(boardTitle) 여섯 번째 게시물 내용", date : "2024-08-21 20:10", views : 7, comment: 3, like : 1, nickName : "닉네임 6"),
            Post(title :"\(boardTitle) 일곱 번째 게시물", content: "\(boardTitle) 일곱 번째 게시물 내용", date : "2024-08-21 12:30", views : 24, comment: 3, like : 1, nickName : "닉네임 7"),
            Post(title :"\(boardTitle) 여덟 번째 게시물", content: "\(boardTitle) 여덟 번째 게시물 내용", date : "2024-08-20 12:35", views : 2, comment: 3, like : 1, nickName : "닉네임 8"),
            Post(title :"\(boardTitle) 아홉 번째 게시물2222222222", content: "\(boardTitle) 아홉 번째 게시물 내용222222222222", date : "2024-08-19 12:35", views : 10, comment: 3, like : 1, nickName : "닉네임 10"),
            Post(title :"\(boardTitle) 열 번째 게시물", content: "\(boardTitle) 열 번째 게시물 내용", date : "2024-08-18 12:35", views : 9, comment: 3, like : 1, nickName : "닉네임 10")
        ]
        
        var addPosts : [Post] = []
        
        if (boardTitle == "자유소통 게시판") {
            for post in userPostFree.reversed() {
                addPosts.append(post)
            }
        } else if (boardTitle == "갈등 소통 게시판"){
            for post in userPostConflic.reversed() {
                addPosts.append(post)
            }
        } else if (boardTitle == "공구/나눔 게시판"){
            for post in userPostTool.reversed() {
                addPosts.append(post)
            }
        } else if (boardTitle == "중고장터 게시판") {
            for post in userPostGarage.reversed() {
                addPosts.append(post)
            }
        } else if (boardTitle == "질문 게시판") {
            for post in userPostQuestion.reversed() {
                addPosts.append(post)
            }
        } else if (boardTitle == "정보공유 게시판") {
            for post in userPostInfo.reversed() {
                addPosts.append(post)
            }
        } else if (boardTitle == "오늘의 홈테리어") {
            for post in userPostInterior.reversed() {
                addPosts.append(post)
            }
        } else {
            for post in userPost.reversed() {
                addPosts.append(post)
            }
        }
        
        for post in posts {
            addPosts.append(post)
        }
        
        posts = addPosts
        
        print(posts)
        
        return posts
    }
    
    func postPost(title : String, content : String, date : String, views : Int, comment : Int, like : Int, nickName : String, boardTitle : String)
    {
        if(boardTitle == "자유소통 게시판") {
            userPostFree.append(Post(title: title, content: content, date: date, views: views, comment: comment, like: like, nickName: nickName))
        } else if (boardTitle == "갈등 소통 게시판") {
            userPostConflic.append(Post(title: title, content: content, date: date, views: views, comment: comment, like: like, nickName: nickName))
        } else if (boardTitle == "공구/나눔 게시판") {
            userPostTool.append(Post(title: title, content: content, date: date, views: views, comment: comment, like: like, nickName: nickName))
        } else if (boardTitle == "정보공유 게시판") {
            userPostInfo.append(Post(title: title, content: content, date: date, views: views, comment: comment, like: like, nickName: nickName))
        } else if (boardTitle == "질문 게시판" ){
            userPostQuestion.append(Post(title: title, content: content, date: date, views: views, comment: comment, like: like, nickName: nickName))
        } else if (boardTitle == "오늘의 홈테리어") {
            userPostInterior.append(Post(title: title, content: content, date: date, views: views, comment: comment, like: like, nickName: nickName))
        } else {
            userPost.append(Post(title: title, content: content, date: date, views: views, comment: comment, like: like, nickName: nickName))
        }
    }
}
