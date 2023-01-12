//
//  SituationStatisticsService.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/12.
//
//
import Foundation

import Moya

enum SituationStatisticsService {
    case recommendEnvirionment(id: Int)
}

extension SituationStatisticsService: TargetType {
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .recommendEnvirionment(id: let id):
            return URLConstant.recommendEnvirionment+"/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .recommendEnvirionment:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .recommendEnvirionment:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .recommendEnvirionment:
            return NetworkConstant.hasTokenHeader
        }
    }
}
