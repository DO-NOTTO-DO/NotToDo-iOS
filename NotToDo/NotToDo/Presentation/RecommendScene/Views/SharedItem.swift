//
//  SharedItem.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/06.
//

import Foundation

struct ShardedItem<TShardingKey, TItem> : Hashable
    where TShardingKey:Hashable, TItem:Hashable
{
    let shard:TShardingKey
    let item:TItem
}
