//
//  Fonts.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

struct AppFontName {
    static let pretendardBold = "Pretendard-Bold"
    static let pretendardSemiBold = "Pretendard-SemiBold.otf"
    static let pretendardMedium = "Pretendard-Medium"
    static let pretendardRegular = "Pretendard-Regular"
}

extension UIFont {
    
    // MARK: - Pretendard Font
    
    @nonobjc class func PretendardBold(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.pretendardBold, size: size)!
    }
    
    @nonobjc class func PretendardSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.pretendardSemiBold, size: size)!
    }

    @nonobjc class func PretendardMedium(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.pretendardMedium, size: size)!
    }

    @nonobjc class func PretendardRegular(size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.pretendardRegular, size: size)!
    }
}
