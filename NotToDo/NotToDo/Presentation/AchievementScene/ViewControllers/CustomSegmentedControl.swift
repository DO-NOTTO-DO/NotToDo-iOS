//
//  CustomSegmentedControl.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/09.
//

import UIKit

import SnapKit
import Then

class CustomSegmentedControl: UISegmentedControl {
    
    // MARK: - Life Cycle
    
    override init(items: [Any]?) {
        super.init(items: items)
        removeBackgroundDivider()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension CustomSegmentedControl {
    
    private func removeBackgroundDivider() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func setStyle() {
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.nottodoGray2!, .font: UIFont.PretendardRegular(size: 16.adjusted)], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.nottodoBlack!, .font: UIFont.PretendardBold(size: 16.adjusted), .backgroundColor: UIColor.yellow_deep!], for: .selected)
        self.setContentPositionAdjustment(UIOffset(horizontal: -20.adjusted, vertical: 0), forSegmentType: .center, barMetrics: .default)
    }
}
