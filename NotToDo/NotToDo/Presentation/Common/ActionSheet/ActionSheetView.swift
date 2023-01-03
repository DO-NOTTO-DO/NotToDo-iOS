//
//  ActionSheetView.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/03.
//

import UIKit

final class ActionSheetView: UIView {
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        addShape()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func draw(_ rect: CGRect) {
//        let dn: CGFloat = 15.adjusted
//        let path = UIBezierPath()
//
//        path.move(to: CGPoint(x: dn, y: 0))
//        path.addLine(to: CGPoint(x: Numbers.width - dn, y: 0))
//        path.addLine(to: CGPoint(x: Numbers.width, y: dn))
//        path.addLine(to: CGPoint(x: Numbers.width, y: Numbers.height))
//        path.addLine(to: CGPoint(x: 0, y: Numbers.height))
//        path.addLine(to: CGPoint(x: 0, y: dn))
//        path.close()
//
//        UIColor.nottodoWhite?.set()
//        path.fill()
//    }
}

extension ActionSheetView {
    private func setUI() {
        backgroundColor = .clear
    }
    
    private func createPath() -> CGPath {
        let dn: CGFloat = 15.adjusted
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: dn, y: 0))
        path.addLine(to: CGPoint(x: Numbers.width - dn, y: 0))
        path.addLine(to: CGPoint(x: Numbers.width, y: dn))
        path.addLine(to: CGPoint(x: Numbers.width, y: Numbers.height))
        path.addLine(to: CGPoint(x: 0, y: Numbers.height))
        path.addLine(to: CGPoint(x: 0, y: dn))
        path.close()
        return path.cgPath
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.nottodoWhite?.cgColor
        self.layer.addSublayer(shapeLayer)
    }
}
