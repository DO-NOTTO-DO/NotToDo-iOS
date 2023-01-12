//
//  MissionHistoryDTO.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/13.
//

struct MissionHistoryResponse: Codable {
    let title: String
}

typealias MissionHistory = [MissionHistoryModel]
