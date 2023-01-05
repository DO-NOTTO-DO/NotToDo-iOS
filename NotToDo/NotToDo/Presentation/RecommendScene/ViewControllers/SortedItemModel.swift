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
    var list: [ItemModel]
}
extension SortedItemModel {
    static var sampleData: [SortedItemModel] =
    [
    SortedItemModel(title: "sns",
                    itemsList: [ItemModel(subTitle: "ddcvd"),
                                ItemModel(subTitle: "ddxd"),
                                ItemModel(subTitle: "Ddxd"),
                                ItemModel(subTitle: "ddd")],
                    list:[ItemModel(subTitle: "helelel"),
                                ItemModel(subTitle: "ahlghal"),
                                ItemModel(subTitle: "oooo")]),
    SortedItemModel(title: "유튜브",
                    itemsList: [ItemModel(subTitle: "hhh"),
                                ItemModel(subTitle: "hhhh"),
                                ItemModel(subTitle: "hhhhh"),
                                ItemModel(subTitle: "hhhhhh")],
                    list:[ItemModel(subTitle: "helelel"),
                     ItemModel(subTitle: "ahlghal"),
                     ItemModel(subTitle: "oooo")]
                   ),
    SortedItemModel(title: "식습관",
                    itemsList: [ItemModel(subTitle: "Aaaaa"),
                                ItemModel(subTitle: "aaa"),
                                ItemModel(subTitle: "aaaa"),
                                ItemModel(subTitle: "dfdfdafd")],
                    list:[ItemModel(subTitle: "helelel"),
                     ItemModel(subTitle: "ahlghal"),
                     ItemModel(subTitle: "oooo")]),
    SortedItemModel(title: "멀티태스킹",
                    itemsList:[ItemModel(subTitle: "dcdddd"),
                               ItemModel(subTitle: "dddd"),
                               ItemModel(subTitle: "Ddd"),
                               ItemModel(subTitle: "ddccccd")],
                    list:[ItemModel(subTitle: "helelel"),
                     ItemModel(subTitle: "ahlghal"),
                     ItemModel(subTitle: "oooo")]),
    SortedItemModel(title: "늦잠",
                    itemsList: [ItemModel(subTitle: "hhh"),
                                ItemModel(subTitle: "hhhh"),
                                ItemModel(subTitle: "hhhhh"),
                                ItemModel(subTitle: "hhhhhh")
                               ],list:[ItemModel(subTitle: "helelel"),
                                        ItemModel(subTitle: "ahlghal"),
                                        ItemModel(subTitle: "oooo")])
                    ]
    

}


struct ItemModel: Hashable{
    let subTitle: String
}
