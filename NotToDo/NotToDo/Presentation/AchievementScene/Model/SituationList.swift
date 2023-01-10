//
//  SituationList.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/10.
//

import Foundation

// MARK: - Datum
struct Situation: Codable {
    let id, count: Int
    let name: String
    let missions: [Mission]
    
    public func convert() -> [String] {
        var result: [String] = []
        for mission in missions {
            result.append(mission.title)
        }
        return result
    }
    
    static func dummy() -> [Situation] {
        return [
            Situation(id: 0, count: 2, name: "딸기", missions: [Mission(count: 2, title: "유튜브 보지 않기"), Mission(count: 2, title: "유튜브 보기")]),
//            Situation(id: 0, count: 2, name: "딸기", missions: [Mission(count: 2, title: "유튜브 보지 않기"), Mission(count: 2, title: "유튜브 보기")]),
//            Situation(id: 0, count: 2, name: "딸기", missions: [Mission(count: 2, title: "유튜브 보지 않기"), Mission(count: 2, title: "유튜브 보기")])
        ]
    }
}

// MARK: - Mission
struct Mission: Codable {
    let count: Int
    let title: String
}
