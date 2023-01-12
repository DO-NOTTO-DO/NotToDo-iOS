//
//  HomeAPI.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/12.
//

import Moya
import Foundation

final class HomeAPI {
    
    static let shared: HomeAPI = HomeAPI()
    
    var homeProvider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }

    // MARK: - GET
        
    func getBanner(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.banner) { response in
            switch response {
            case let .success(response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = NetworkBase.judgeStatus(by: statusCode, data, BannerResponse.self)
                completion(networkResult)
            case let .failure(err):
                print(err)
            }
        }
    }
}
