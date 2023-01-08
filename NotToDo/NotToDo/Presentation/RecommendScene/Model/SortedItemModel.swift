//
//  SortedItemModel.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/05.
//

import Foundation

struct SortedItemModel: Hashable {
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
    
    static var sampleData1: [SortedItemModel] =
    [
        SortedItemModel(title: "작업",
                        itemsList: [ItemModel(subTitle: "작업1 ..."),
                                    ItemModel(subTitle: "작업2 ...")                                ]),
        SortedItemModel(title: "업무",
                        itemsList: [ItemModel(subTitle: "업무1 ..."),
                                    ItemModel(subTitle: "업무2 ...")]
                       )
    ]
    
    static var sampleData2: [SortedItemModel] =
    [
        SortedItemModel(title: "건강하자...",
                        itemsList: [ItemModel(subTitle: "건강1 ..."),
                                    ItemModel(subTitle: "건강2...")                                ]),
        SortedItemModel(title: "건강....하자..",
                        itemsList: [ItemModel(subTitle: "건...강...1"),
                                    ItemModel(subTitle: "건...강...2")]
                       )
    ]
    static var sampleData3: [SortedItemModel] =
    [
        SortedItemModel(title: "생활",
                        itemsList: [ItemModel(subTitle: "생활1"),
                                    ItemModel(subTitle: "생활2")                                ]),
        SortedItemModel(title: "습관",
                        itemsList: [ItemModel(subTitle: "습관1"),
                                    ItemModel(subTitle: "습관2")]
                       )
    ]
    static var sampleData4: [SortedItemModel] =
    [
        SortedItemModel(title: "기상",
                        itemsList: [ItemModel(subTitle: "기상1"),
                                    ItemModel(subTitle: "기상2")                                ]),
        SortedItemModel(title: "취침",
                        itemsList: [ItemModel(subTitle: "취침1"),
                                    ItemModel(subTitle: "취침2")]
                       )
    ]
}
struct ItemModel: Hashable {
    let subTitle: String
}
