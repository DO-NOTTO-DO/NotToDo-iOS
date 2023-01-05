//
//  adjusted+.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/28.
//

import UIKit

extension CGFloat {
    var adjusted: CGFloat {
        let ratio: CGFloat = Numbers.width / 393
        return ratio * CGFloat(self)
    }
}

extension Int {
    var adjusted: CGFloat {
        let ratio: CGFloat = (Numbers.width) / 393
        return ratio * CGFloat(self)
    }
}

extension Double {
    var adjusted: CGFloat {
        let ratio: CGFloat = (Numbers.width) / 393
        return ratio * CGFloat(self)
    }
}
