//
//  RequestApi.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/13.
//

import UIKit

class RequestApi {
    static let shared = RequestApi()
    
    private init() {}
    
    var data = [101000, 109000, -1]
    var payState = false
    
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
            posts.append(["test1", "설명 부분"])
        }
        posts.append(["icon_morePost", " "])
        
        return posts
    }
    
    // 중고장터 사진이랑 제목 API로 가져오기
    func getRecentGarageSalePost() -> [[String]]{
        var posts : [[String]] = []
        
        for i in 0...5 {
            posts.append(["test2", "설명 부분"])
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
        if (isPaid){
            payState = isPaid
            print("완납")
        }else{
            payState = isPaid
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
}
