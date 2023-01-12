//
//  SituationStatisticsAPI.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/12.
//

import Foundation

import Moya

final class SituationStatisticsAPI {
    
    static let shared: SituationStatisticsAPI = SituationStatisticsAPI()
    
    private let situationStatisticsProvider = MoyaProvider<RecommendService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    public private(set) var recommendData: GeneralArrayResponse<RecommendElementResponse>?
    
    // MARK: - GET
    
    func getRecommend(completion: @escaping (GeneralArrayResponse<RecommendElementResponse>?) -> ()) {
        situationStatisticsProvider.request(.recommendEnvirionment(id: 1)) { result in
            switch result {
            case .success(let response):
                do {
                    self.recommendData = try response.map(GeneralArrayResponse<RecommendElementResponse>?.self)
                    guard let recommendData = self.recommendData else { return }
                    completion(recommendData)
                } catch (let err) {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
