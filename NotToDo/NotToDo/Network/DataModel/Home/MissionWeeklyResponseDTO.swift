//
//  MissionWeeklyResponseDTO.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/13.
//

import Foundation

struct MissionWeeklyResponseDTO: Codable {
    let data: [WeekMission]
}

struct WeekMission: Codable {
    let actionDate: String
    let percentage: Float
}
