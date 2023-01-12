//
//  AchieveService.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/12.
//

import Foundation

import Moya

enum AchieveService {
    case missionStatistics
    case situationStatistics
}

extension AchieveService: TargetType {
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .missionStatistics:
            return URLConstant.missionStatistics
        case .situationStatistics:
            return URLConstant.situationStatistics
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .missionStatistics, .situationStatistics:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .missionStatistics, .situationStatistics:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .missionStatistics, .situationStatistics:
            return NetworkConstant.hasTokenHeader
        }
    }
}
