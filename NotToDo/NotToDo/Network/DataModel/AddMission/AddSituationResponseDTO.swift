//
//  AddSituationResponseDTO.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/12.
//

struct AddSituationResponse: Codable {
    let recommends: [AddSituationModel]
    let recents: [AddSituationModel]
}

struct RecommendResponse: Codable {
    let name: String
}

struct RecentResponse: Codable {
    let name: String
}
