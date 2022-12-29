//
//  UIStackView+.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
