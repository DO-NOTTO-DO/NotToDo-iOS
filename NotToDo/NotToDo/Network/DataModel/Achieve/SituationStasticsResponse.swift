//
//  SituationStasticsResponse.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/12.
//

import Foundation

// MARK: - SituationStatistcsResponseElement
struct SituationStatistcsResponse: Codable {
    let id, count: Int
    let name: String
    let missions: [SituationMissions]
    
//    public func convert() -> [String] {
//        var result: [String] = []
//        for mission in missions {
//            result.append(mission.title)
//        }
//        return result
//    }
//    static func dummy() -> [SituationStatistcsResponse] {
//        return []
//    }
}

// MARK: - Mission
struct SituationMissions: Codable {
    let count: Int
    let title: String
}



