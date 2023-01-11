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
}

extension HomeService: TargetType {
    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .banner:
            return URLConstant.homeBanner
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .banner:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .banner:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .banner:
            return NetworkConstant.hasTokenHeader
        }
    }
}
