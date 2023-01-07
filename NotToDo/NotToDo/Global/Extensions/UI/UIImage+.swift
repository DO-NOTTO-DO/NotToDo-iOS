//
//  UIImage+.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import UIKit

extension UIImage {
    
    // TabBar
    
    static let home = UIImage(named: "TabBar/ic_home")!.withRenderingMode(.alwaysOriginal)
    static let homeActive = UIImage(named: "TabBar/ic_home_active")!.withRenderingMode(.alwaysOriginal)
    static let myInfo = UIImage(named: "TabBar/ic_profile")!.withRenderingMode(.alwaysOriginal)
    static let myInfoActive = UIImage(named: "TabBar/ic_profile_active")!.withRenderingMode(.alwaysOriginal)
    static let recommend = UIImage(named: "TabBar/ic_recommend")!.withRenderingMode(.alwaysOriginal)
    static let recommendActive = UIImage(named: "TabBar/ic_recommend_active")!.withRenderingMode(.alwaysOriginal)
    static let ahcievement = UIImage(named: "TabBar/ic_result")!.withRenderingMode(.alwaysOriginal)
    static let achievementActive = UIImage(named: "TabBar/ic_result_active")!.withRenderingMode(.alwaysOriginal)
    
    // Home
    
    static let addNotToDo = UIImage(named: "Home/btn_nottodo")!.withRenderingMode(.alwaysOriginal)
    static let target = UIImage(named: "Home/ic_target")!.withRenderingMode(.alwaysOriginal)
    static let checkBox = UIImage(named: "Home/checkbox/btn_check_blank")!.withRenderingMode(.alwaysOriginal)
    static let checkDefault = UIImage(named: "Home/checkbox/Default")!.withRenderingMode(.alwaysOriginal)
    static let checkCircle = UIImage(named: "Home/checkbox/circle")!.withRenderingMode(.alwaysOriginal)
    static let checkTriangle = UIImage(named: "Home/checkbox/triangle")!.withRenderingMode(.alwaysOriginal)
    static let dot = UIImage(named: "Home/btn_dot")!.withRenderingMode(.alwaysOriginal)

    // Recent
    
    static let addEnabledBtn = UIImage(named: "Recent/btn_add/enabled")!.withRenderingMode(.alwaysOriginal)
    static let addDisabledBtn = UIImage(named: "Recent/btn_add/disabled")!.withRenderingMode(.alwaysOriginal)
    static let plusBtn = UIImage(named: "Recent/btn_plus")!.withRenderingMode(.alwaysOriginal)
    static let deleteBtn = UIImage(named: "Recent/btn_delete_create")!.withRenderingMode(.alwaysOriginal)
    static let recentCalendar = UIImage(named: "Recent/ic_calender")!.withRenderingMode(.alwaysOriginal)
    
    // Recommend
    
    static let recommend_star = UIImage(named: "Recommend/ic_circle_s")!.withRenderingMode(.alwaysOriginal)
    static let emotionActive = UIImage(named: "Recommend/ic_emotion_active")!.withRenderingMode(.alwaysOriginal)
    static let emotion = UIImage(named: "Recommend/ic_emotion_default")!.withRenderingMode(.alwaysOriginal)
    static let entertainActive = UIImage(named: "Recommend/ic_entertain_active")!.withRenderingMode(.alwaysOriginal)
    static let entertain = UIImage(named: "Recommend/ic_entertain_default")!.withRenderingMode(.alwaysOriginal)
    static let havitActive = UIImage(named: "Recommend/ic_habit_active")!.withRenderingMode(.alwaysOriginal)
    static let healthActive = UIImage(named: "Recommend/ic_health_active")!.withRenderingMode(.alwaysOriginal)
    static let health = UIImage(named: "Recommend/ic_health_default")!.withRenderingMode(.alwaysOriginal)
    static let shopActive = UIImage(named: "Recommend/ic_shop_active")!.withRenderingMode(.alwaysOriginal)
    static let shop = UIImage(named: "Recommend/ic_shop_default")!.withRenderingMode(.alwaysOriginal)
    static let sleepActive = UIImage(named: "Recommend/ic_sleep_active")!.withRenderingMode(.alwaysOriginal)
    static let sleep = UIImage(named: "Recommend/ic_sleep_default")!.withRenderingMode(.alwaysOriginal)
    static let snsActive = UIImage(named: "Recommend/ic_sns_active")!.withRenderingMode(.alwaysOriginal)
    static let sns = UIImage(named: "Recommend/ic_sns_default")!.withRenderingMode(.alwaysOriginal)
    static let workActive = UIImage(named: "Recommend/ic_work_active")!.withRenderingMode(.alwaysOriginal)
    static let work = UIImage(named: "Recommend/ic_work_default")!.withRenderingMode(.alwaysOriginal)
 
    // Icon
    
    static let addCalendar = UIImage(named: "IC/ic_add_calendar")!.withRenderingMode(.alwaysOriginal)
    static let alarm = UIImage(named: "IC/ic_alarm")!.withRenderingMode(.alwaysOriginal)
    static let anotherDay = UIImage(named: "IC/ic_anotherday")!.withRenderingMode(.alwaysOriginal)
    static let calendar = UIImage(named: "IC/ic_calender")!.withRenderingMode(.alwaysOriginal)
    static let edit = UIImage(named: "IC/ic_edit")!.withRenderingMode(.alwaysOriginal)
    static let guide = UIImage(named: "IC/ic_guide")!.withRenderingMode(.alwaysOriginal)
    static let question = UIImage(named: "IC/ic_question")!.withRenderingMode(.alwaysOriginal)
    static let rank = UIImage(named: "IC/ic_rank")!.withRenderingMode(.alwaysOriginal)
    static let recentSearch = UIImage(named: "IC/ic_recentsearch")!.withRenderingMode(.alwaysOriginal)
    static let recentUse = UIImage(named: "IC/ic_recentuse")!.withRenderingMode(.alwaysOriginal)
    static let icRecommend = UIImage(named: "IC/ic_recommand")!.withRenderingMode(.alwaysOriginal)
    static let trash = UIImage(named: "IC/ic_trash")!.withRenderingMode(.alwaysOriginal)
    static let warning = UIImage(named: "IC/ic_warning")!.withRenderingMode(.alwaysOriginal)
    static let star = UIImage(named: "IC/ic_star")!.withRenderingMode(.alwaysOriginal)
    
    // Calendar
    
    static let headerImage = UIImage(named: "Calendar/Component")!.withRenderingMode(.alwaysOriginal)
    static let calendarLeftArrow = UIImage(named: "Calendar/btn_arrow/_left")!.withRenderingMode(.alwaysOriginal)
    static let calendarRightArrow = UIImage(named: "Calendar/btn_arrow/_right")!.withRenderingMode(.alwaysOriginal)
    static let selectedDateBtn = UIImage(named: "Calendar/btn_selected")!.withRenderingMode(.alwaysOriginal)
    
    // Shape
    
    static let deletePageBtn = UIImage(named: "Other/btn_delete_page")!.withRenderingMode(.alwaysOriginal)
    static let backBtn = UIImage(named: "Other/btn_back")!.withRenderingMode(.alwaysOriginal)
    static let rightArrow = UIImage(named: "Arrow/ic_right_arrow")!.withRenderingMode(.alwaysOriginal)
    static let leftArrow = UIImage(named: "Arrow/ic_left_arrow")!.withRenderingMode(.alwaysOriginal)

    // Graphic
    
    static let graphic1 = UIImage(named: "Graphic/graphic1")!.withRenderingMode(.alwaysOriginal)
    static let graphic3 = UIImage(named: "Graphic/graphic3")!.withRenderingMode(.alwaysOriginal)
    static let graphic4 = UIImage(named: "Graphic/graphic4")!.withRenderingMode(.alwaysOriginal)
    static let heartEmpty = UIImage(named: "Graphic/graphic5")!.withRenderingMode(.alwaysOriginal)
    static let heartFill = UIImage(named: "Graphic/graphic2")!.withRenderingMode(.alwaysOriginal)
    
    // MyInfo
    
    static let login = UIImage(named: "MyInfo/img_login")!.withRenderingMode(.alwaysOriginal)
    static let kakaoLoginButton = UIImage(named: "MyInfo/btn_login_kakao")!.withRenderingMode(.alwaysOriginal)
    static let appleLoginButton = UIImage(named: "MyInfo/btn_login_apple")!.withRenderingMode(.alwaysOriginal)
    static let myInfoBackground = UIImage(named: "MyInfo/img_myInfo")!.withRenderingMode(.alwaysOriginal)
    static let myInfoUser = UIImage(named: "MyInfo/img_myInfoUser")!.withRenderingMode(.alwaysOriginal)
    static let myInfoRightButton = UIImage(named: "MyInfo/btn_right")!.withRenderingMode(.alwaysOriginal)
    static let heartFill2 = UIImage(named: "Graphic/graphic6")!.withRenderingMode(.alwaysOriginal)
    
    // Achieve
    static let rank1 = UIImage(named: "Achieve/rank_1")!.withRenderingMode(.alwaysOriginal)
    static let rank2 = UIImage(named: "Achieve/rank_2")!.withRenderingMode(.alwaysOriginal)
    static let rank3 = UIImage(named: "Achieve/rank_3")!.withRenderingMode(.alwaysOriginal)
    static let rank4 = UIImage(named: "Achieve/rank_4")!.withRenderingMode(.alwaysOriginal)
    static let rank5 = UIImage(named: "Achieve/rank_5")!.withRenderingMode(.alwaysOriginal)
}
