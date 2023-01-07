//
//  UIView+.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}

struct BorderOptions: OptionSet {
    let rawValue: Int

    static let top = BorderOptions(rawValue: 1 << 0)
    static let left = BorderOptions(rawValue: 1 << 1)
    static let bottom = BorderOptions(rawValue: 1 << 2)
    static let right = BorderOptions(rawValue: 1 << 3)
    
    static let horizontal: BorderOptions = [.left, .right]
    static let vertical: BorderOptions = [.top, .bottom]
}
extension UIView {
    func removeBorder(toSide options: BorderOptions) {
        if options.contains(.bottom),
        let border = layer.sublayers?.first(where: { $0.name == "bottom" }) {
            border.removeFromSuperlayer()
        }
        /**
        다른 사이드도 동일하게 적용
        */
    }
}
