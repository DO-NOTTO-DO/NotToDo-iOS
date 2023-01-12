//
//  AddSituationResponseDTO.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/12.
//

//import Foundation
//
//struct AddSituationResponse: Codable {
//    let recommends, recents: [Keyword]
//}
//
//struct Keyword: Codable {
//    let name: String
//
////    func convertToAddSituation() -> AddSituationModel {
////        return AddSituationModel(keyword: self.name)
////    }
//}

struct AddSituationResponse: Codable {
    let recommends: [RecommendResponse]
    let recents: [RecentResponse]
}

struct RecommendResponse: Codable {
    let name: String
//        func convertToRecommend() -> AddSituationModel {
//            return AddSituationModel(keyword: self.name)
//        }
}

struct RecentResponse: Codable {
    let name: String
//        func convertToRecent() -> AddSituationModel {
//            return AddSituationModel(keyword: self.name)
//        }
}
