//
//  CustomLabel.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

class customLabel : UILabel{
    var color : UIColor = .black
    convenience init(color: UIColor, font: UIFont) {
        self.init()
        self.textAlignment = .left
        self.color = color
        self.font = font
    }
}
