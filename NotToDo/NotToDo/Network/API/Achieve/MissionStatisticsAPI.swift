//
//  MissionStatisticsAPI.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/12.
//

import Foundation

import Moya

final class MissionStatisticsAPI {
    
    static let shared: MissionStatisticsAPI = MissionStatisticsAPI()
    
    private let missionStatisticsProvider = MoyaProvider<AchieveService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    public private(set) var missionStatisticsData: GeneralArrayResponse<MissionStatistcsResponse>?
    
    // MARK: - GET
    
    func getMissionStatistics(completion: @escaping (GeneralArrayResponse<MissionStatistcsResponse>?) -> Void) {
        missionStatisticsProvider.request(.missionStatistics) { result in
            switch result {
            case .success(let response):
                do {
                    self.missionStatisticsData = try response.map(GeneralArrayResponse<MissionStatistcsResponse>?.self)
                    guard let situationStatisticsData = self.missionStatisticsData else { return }
                    completion(self.missionStatisticsData)
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
