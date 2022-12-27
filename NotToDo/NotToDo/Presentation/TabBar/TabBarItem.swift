//
//  TabBarItem.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

enum TabBarItemType: Int, CaseIterable {
    case home
    case recommend
    case achievement
    case myInfo
}

extension TabBarItemType {
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .recommend:
            return "추천"
        case .achievement:
            return "성취"
        case .myInfo:
            return "내 정보"
        }
    }
    
    var selectedIcon: UIImage {
        switch self {
        case .home:
            return UIImage.homeActive
        case .recommend:
            return UIImage.recommendActive
        case .achievement:
            return UIImage.achievementActive
        case .myInfo:
            return UIImage.myInfoActive
        }
    }
    
    var unSelectedIcon: UIImage {
        switch self {
        case .home:
            return UIImage.home
        case .recommend:
            return UIImage.recommend
        case .achievement:
            return UIImage.ahcievement
        case .myInfo:
            return UIImage.myInfo
        }
    }
    
    public func setTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: unSelectedIcon,
            selectedImage: selectedIcon)
    }
}
