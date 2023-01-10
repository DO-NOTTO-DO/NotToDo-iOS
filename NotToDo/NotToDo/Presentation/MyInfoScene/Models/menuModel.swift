//
//  menuModel.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/05.
//

import UIKit

struct menu {
    let icon: UIImage?
    let title: String
    let goToButton: UIImage?
}

// 이미지 에셋 추가 후 이미지 변경
var myInfoFirstMenuList: [menu] = [
    menu(icon: .guide, title: I18N.missionGuide, goToButton: .myInfoRightButton),
    menu(icon: .question, title: I18N.oftenQuestion, goToButton: .myInfoRightButton)
]

var myInfoSecondMenuList: [menu] = [
    menu(icon: nil, title: I18N.settingPushAlarm, goToButton: .myInfoRightButton),
    menu(icon: nil, title: I18N.notice, goToButton: .myInfoRightButton),
    menu(icon: nil, title: I18N.inquiry, goToButton: .myInfoRightButton),
    menu(icon: nil, title: I18N.termsPolicies, goToButton: .myInfoRightButton),
    menu(icon: nil, title: I18N.version, goToButton: nil)
]
