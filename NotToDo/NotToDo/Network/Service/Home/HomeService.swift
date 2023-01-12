//
//  HomeService.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/12.
//

import Foundation

import Moya

enum HomeService {
    case banner
    case dailyMission(date: String)
    case updateMissionStatus(id: Int, status: String)
}

extension HomeService: TargetType {
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .banner:
            return URLConstant.homeBanner
        case .dailyMission(let date):
            return URLConstant.dailyMission + "/\(date)"
        case .updateMissionStatus(let id, _):
            return URLConstant.updateMissionStatus + "/\(id)" + "/check"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .banner, .dailyMission:
            return .get
        case .updateMissionStatus:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .banner, .dailyMission:
            return .requestPlain
        case .updateMissionStatus(_, let status):
            return .requestParameters(parameters: ["completionStatus": status],
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .banner, .dailyMission, .updateMissionStatus:
            return NetworkConstant.hasTokenHeader
        }
    }
}
