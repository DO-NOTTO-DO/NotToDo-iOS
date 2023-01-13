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
    
    private let situationStatisticsProvider = MoyaProvider<AchieveService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    public private(set) var situationStatisticsData: GeneralArrayResponse<SituationStatistcsResponse>?
    
    // MARK: - GET
    
    func getSituationStatistics(completion: @escaping (GeneralArrayResponse<SituationStatistcsResponse>?) -> Void) {
        situationStatisticsProvider.request(.situationStatistics) { result in
            switch result {
            case .success(let response):
                do {
                    self.situationStatisticsData = try response.map(GeneralArrayResponse<SituationStatistcsResponse>?.self)
                    guard let situationStatisticsData = self.situationStatisticsData else { return }
                    completion(situationStatisticsData)
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
