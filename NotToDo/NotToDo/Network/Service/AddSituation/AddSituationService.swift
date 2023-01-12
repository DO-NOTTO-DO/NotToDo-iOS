//
//  AddSituationService.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/12.
//

import Foundation

import Moya

enum AddSituationService {
    case addSituation
}

extension AddSituationService: TargetType {
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .addSituation:
            return URLConstant.addSituation
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addSituation:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .addSituation:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .addSituation:
            return NetworkConstant.hasTokenHeader
        }
    }
}
