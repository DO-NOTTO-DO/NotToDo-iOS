//
//  MissionModel.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/08.
//

import UIKit

struct DailyMission {
    let title, situation, completionStatus, goal: String
    let actions: [String]
}

extension DailyMission {
    static let DailyMissionModel: [DailyMission] = [
        DailyMission(title: "유튜브 보지 않기", situation: "기상 직후",
                     completionStatus: "FINISH", goal: "캡스톤 PPT 만들기",
                     actions: [
                        "뜨거운 유자차 주문하기",
                        "딸기라떼 주문하기"
                     ]),
        DailyMission(title: "유튜브 보지 않기", situation: "기상 직후",
                     completionStatus: "AMBIGUOUS", goal: "목 건강 지키기",
                     actions: [
                        "뜨거운 유자차 주문하기"
                     ])
    ]
    
}
