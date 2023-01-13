//
//  RecommendDTO.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/12.
//
import Foundation

// MARK: - RecommendElement
struct RecommendElementResponseDTO: Codable, Hashable {
    let title: String
    let recommendActions: [RecommendAction]
}

// MARK: - RecommendAction
struct RecommendAction: Codable, Hashable {
    let name: String
}
