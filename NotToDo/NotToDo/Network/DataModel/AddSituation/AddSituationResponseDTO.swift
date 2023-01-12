//
//  AddSituationResponseDTO.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/12.
//

import Foundation

struct AddSituationResponse: Codable {
    let recommendResponse: [RecommendResponse],
        let recentResponse: [RecentResponse]
}

struct RecommendResponse: Codable {
        let name: String
}

struct RecentResponse: Codable {
        let name: String
}
