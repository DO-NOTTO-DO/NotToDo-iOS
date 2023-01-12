//
//  CompositionalLayout.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/09.
//

import UIKit

final class Layout {
    
    static  let spacing: NSCollectionLayoutSpacing = .fixed(10)
    
    class func compositional_vertical(itemW: NSCollectionLayoutDimension, itemH: NSCollectionLayoutDimension, gWidth: NSCollectionLayoutDimension, gHeight: NSCollectionLayoutDimension, count: Int?) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: itemW, heightDimension: itemH))
        if count == nil {
            let groups = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: gWidth, heightDimension: gHeight), subitems: [item])
            groups.interItemSpacing = spacing
            return missionSection(groups, NSDirectionalEdgeInsets(top: 14, leading: 20, bottom: 27, trailing: 20))
        } else {
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: gWidth, heightDimension: gHeight), subitem: item, count: count! )
            return emptySection(group, NSDirectionalEdgeInsets(top: 56, leading: 0, bottom: 27, trailing: 0))
        }
    }
    
    class func missionSection(_ group: NSCollectionLayoutGroup, _ edge: NSDirectionalEdgeInsets) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = edge
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        section.decorationItems = [backgroundItem]
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    class func emptySection(_ group: NSCollectionLayoutGroup, _ edge: NSDirectionalEdgeInsets) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = edge
        return section
    }
}
