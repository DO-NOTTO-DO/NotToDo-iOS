//
//  NotToDoList.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

struct MissionList: Hashable {
    var title: String
    var color: UIColor
}
extension MissionList {
    static var titles: [MissionList] = [MissionList(title: "🧑🏻‍⚖️ 낫투두 1", color: .yellow_basic ?? .label),
                                        MissionList(title: "🥞 낫투두 2", color: .yellow_mild ?? .label),
                                        MissionList(title: "💼 낫투두 3", color: .yellow_deep ?? .label),
                                        MissionList(title: "💼 낫투두 4", color: .yellow_basic ?? .label),
                                        MissionList(title: "💼 낫투두 5", color: .yellow_basic ?? .label)
    ]
}
