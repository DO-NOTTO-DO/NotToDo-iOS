//
//  RecommendAPI.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/12.
//

import Foundation

import Moya

final class RecommendAPI {
    
    static let shared: RecommendAPI = RecommendAPI()
    
    private let recommendProvider = MoyaProvider<RecommendService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    public private(set) var recommendData: GeneralArrayResponse<RecommendElementResponseDTO>?
    
    // MARK: - GET
    
    func getRecommend(index: Int, completion: @escaping (GeneralArrayResponse<RecommendElementResponseDTO>?) -> Void) {
        recommendProvider.request(.recommendEnvirionment(id: index )) { result in
            switch result {
            case .success(let response):
                do {
                    self.recommendData = try response.map(GeneralArrayResponse<RecommendElementResponseDTO>?.self)
                    guard let recommendData = self.recommendData else { return }
                    completion(recommendData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
