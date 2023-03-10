//
//  URLConstant.swift
//  NotToDo
//
//  Created by 강윤서 on 2022/12/27.
//

import Foundation

struct URLConstant {
    
    // MARK: - base URL
    
    static let baseURL = "http://43.201.125.166:3000/api"
    
    // MARK: - Home
    
    static let homeBanner = "/banner"
    static let dailyMission = "/mission/daily"
    static let mission = "/mission"
    static let missionWeekly = "/mission/week"
    
    // MARK: - Recommend
    
    static let recommendEnvirionment = "/environment"
    
    // MARK: - Achieve
    
    static let achieveCalendar = "/mission/month"
    static let situationStatistics = "/mission/stat/situation"
    static let missionStatistics = "/mission/stat/notTodo"

    // MARK: - AddMission
    static let addMission = "/mission"
    static let addSituation = "/situation"
    static let missionhistory = "/mission/recent"
}
