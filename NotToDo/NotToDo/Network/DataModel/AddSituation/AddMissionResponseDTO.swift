//
//  AddMissionResponseDTO.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/13.
//

import Foundation

struct AddMissionResponse: Codable {
    let id: Int
    let title, goal: String
    let situation: String
    let actions: [Situation]
    let actionDate: String
}

struct Situation: Codable {
    let name: String
}
