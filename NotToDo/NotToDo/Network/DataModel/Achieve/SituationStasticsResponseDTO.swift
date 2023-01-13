//
//  SituationStasticsResponse.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/12.
//

import Foundation

struct SituationStatistcsResponseDTO: Codable {
    let id, count: Int
    let name: String
    let missions: [SituationMissions]
}

struct SituationMissions: Codable {
    let count: Int
    let title: String
}
