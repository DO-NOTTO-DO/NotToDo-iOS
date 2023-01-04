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
        let ratioH: CGFloat = Numbers.height / 852
        return ratio <= ratioH ? self * ratio : self * ratioH
    }
}

extension Int {
    var adjusted: CGFloat {
        let ratio: CGFloat = (Numbers.width) / 393
        let ratioH: CGFloat = (Numbers.height) / 852
        return ratio <= ratioH ? CGFloat(self) * ratio : CGFloat(self) * ratioH
    }
}

extension Double {
    var adjusted: CGFloat {
        let ratio: CGFloat = (Numbers.width) / 393
        let ratioH: CGFloat = (Numbers.height) / 852
        return ratio <= ratioH ? CGFloat(self) * ratio : CGFloat(self) * ratioH
    }
}
