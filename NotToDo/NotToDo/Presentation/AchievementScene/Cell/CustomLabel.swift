//
//  CustomLabel.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

class customLabel : UILabel{
    var color : UIColor = .black
    convenience init(color: UIColor) {
        self.init()
        self.color = color
        setStyle()
    }
    private func setStyle(){
        self.textAlignment = .left
        self.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
}
