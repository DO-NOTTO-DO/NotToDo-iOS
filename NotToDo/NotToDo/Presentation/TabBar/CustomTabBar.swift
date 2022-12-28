//
//  CustomTabBar.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

class CustomTabBar: UITabBar {
    
    // MARK: - Properties
    
    private var shapeLayer: CALayer?
    
    // MARK: - Methods
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 117
        return sizeThatFits
    }
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 48
        return sizeThatFits
    }
    
}
