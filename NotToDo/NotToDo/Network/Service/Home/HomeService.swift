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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .banner, .dailyMission:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .banner, .dailyMission:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .banner, .dailyMission:
            return NetworkConstant.hasTokenHeader
        }
    }
}
