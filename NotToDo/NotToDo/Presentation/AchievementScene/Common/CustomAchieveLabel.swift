//
//  CustomLabel.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

class CustomAchieveLabel: UILabel {
    
    var color: UIColor = .black
    
    // MARK: - View Life Cycle
    
    convenience init(color: UIColor, font: UIFont) {
        self.init()
        textAlignment = .left
        self.color = color
        self.font = font
    }
}
