//
//  TitleButton.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/09.
//

import Foundation
import UIKit

struct TitleButtonList {
    let title: String
}
extension TitleButtonList {
    static var titles: [TitleButtonList] = [TitleButtonList(title: "딸기"),
                                            TitleButtonList(title: "바나나"),
                                            TitleButtonList(title: "망고")

    ]
}
