//
//  SortedItemModel.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import Foundation
struct SortedItemModel: Hashable{
    var title: String
    var itemsList: [ItemModel]
   
}
extension SortedItemModel {
    static var sampleData: [SortedItemModel] =
    [
    SortedItemModel(title: "유튜브 보지 않기",
                    itemsList: [ItemModel(subTitle: "스마트폰 전원 꺼두기"),
                                ItemModel(subTitle: "유튜브 프리미엄 해지")                                ]),
    SortedItemModel(title: "인스타그램 스토리 보지 않기",
                    itemsList: [ItemModel(subTitle: "계정 비활성화하기"),
                                ItemModel(subTitle: "인스타그램 어플 삭제")]
                   )
                    ]
    
}
struct ItemModel: Hashable{
    let subTitle: String
}
