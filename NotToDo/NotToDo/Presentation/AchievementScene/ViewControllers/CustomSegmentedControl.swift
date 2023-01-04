//
//  CustomSegmentedControl.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

import Then
import SnapKit

class CustomSegmentedControl: UISegmentedControl {
    override init(items: [Any]?) {
        super.init(items: items)
        self.removeBackgroundDivider()
        self.setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // background color clear
    private func removeBackgroundDivider(){
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    // font color
    private func setStyle(){
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray,.font: UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemPurple, .font: UIFont.systemFont(ofSize: 16, weight: .semibold), .backgroundColor : UIColor.yellow], for: .selected)
    }
}

