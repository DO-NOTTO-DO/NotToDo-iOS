//
//  AddSituationService.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/12.
//

import Foundation

import Moya

enum AddMissionService {
    case addMission(AddMissionRequest)
    case addSituation
    case missionHistory
}

extension AddMissionService: TargetType {
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .addMission:
            return URLConstant.addMission
        case .addSituation:
            return URLConstant.addSituation
        case .missionHistory:
            return URLConstant.missionhistory
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addMission:
            return .post
        case .addSituation, .missionHistory:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .addMission(let newMission):
            return .requestParameters(
                parameters: newMission.toDictionary,
                encoding: JSONEncoding.default)
        case .addSituation, .missionHistory:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .addMission, .addSituation, .missionHistory:
            return NetworkConstant.hasTokenHeader
        }
    }
}

extension Encodable {
  var toDictionary: [String: Any] {
    guard let object = try? JSONEncoder().encode(self) else { fatalError() }
    guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String: Any] else { fatalError() }
    return dictionary
  }
}
