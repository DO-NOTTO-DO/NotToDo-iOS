//
//  UITabBar.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

extension UITabBar {
    static func clearUI() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.clear
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16.adjusted)
    }
}
