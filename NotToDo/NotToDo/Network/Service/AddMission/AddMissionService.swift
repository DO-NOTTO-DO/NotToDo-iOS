//
//  AddSituationService.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/12.
//

import Foundation

import Moya

enum AddMissionService {
    case addSituation
    case missionHistory
}

extension AddMissionService: TargetType {
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .addSituation:
            return URLConstant.addSituation
        case .missionHistory:
            return URLConstant.missionhistory
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addSituation, .missionHistory:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .addSituation, .missionHistory:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .addSituation, .missionHistory:
            return NetworkConstant.hasTokenHeader
        }
    }
}
