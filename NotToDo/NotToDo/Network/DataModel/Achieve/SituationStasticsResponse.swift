//
//  SituationStasticsResponse.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/12.
//

import Foundation

// MARK: - SituationStatistcsResponseElement
struct SituationStatistcsResponseElement: Codable {
    let id, count: Int
    let name: String
    let missions: [SituationMissions]
}

// MARK: - Mission
struct SituationMissions: Codable {
    let count: Int
    let title: String
}

typealias SituationStatistcsResponse = [SituationStatistcsResponseElement]
