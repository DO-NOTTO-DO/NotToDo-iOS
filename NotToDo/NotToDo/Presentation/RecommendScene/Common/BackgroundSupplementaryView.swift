//
//  BackgroundSupplementaryView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

final class BackgroundSupplementaryView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .nottodoWhite
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.nottodoGray2?.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
