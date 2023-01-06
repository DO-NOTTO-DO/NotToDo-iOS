//
//  TabBarItem.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import Foundation

struct CustomTabBarItem: Hashable {
    var name: String
    var image: String
    var activeImage: String
}
extension CustomTabBarItem {
   static let items: [CustomTabBarItem] = [
    CustomTabBarItem(name: "SNS", image: "Recommend/ic_sns_default", activeImage: "Recommend/ic_sns_active"),
                                            CustomTabBarItem(name: "작업,업무", image: "Recommend/ic_work_default", activeImage: "Recommend/ic_work_active"),
                                            CustomTabBarItem(name: "건강", image: "Recommend/ic_health_default", activeImage: "Recommend/ic_health_active"),
                                            CustomTabBarItem(name: "생활습관", image: "Recommend/ic_habit_default", activeImage: "Recommend/ic_habit_active"),
                                            CustomTabBarItem(name: "기상,취침", image: "Recommend/ic_sleep_default", activeImage: "Recommend/ic_sleep_active")
    ]
}
