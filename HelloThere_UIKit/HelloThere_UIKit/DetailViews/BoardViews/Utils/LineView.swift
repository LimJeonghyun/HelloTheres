//
//  LineView.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/23.
//

import UIKit

class LineView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 선을 그리기 위한 context 얻기
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // 선 색 설정
        context.setStrokeColor(UIColor(hexCode:"F1F1F1").cgColor)
        //        (hexCode:"F1F1F1")
        
        // 선 굵기 설정
        context.setLineWidth(2.0)
        
        // 선의 시작점 설정
        context.move(to: CGPoint(x: 0, y: self.bounds.height / 2))
        
        // 선의 끝점 설정
        context.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height / 2))
        
        // 선 그리기
        context.strokePath()
    }
    
}
