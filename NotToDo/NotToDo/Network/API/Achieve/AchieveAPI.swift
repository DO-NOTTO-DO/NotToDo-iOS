//
//  SituationStatisticsAPI.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/12.
//

import Foundation

import Moya

final class AchieveAPI {
    
    static let shared: AchieveAPI = AchieveAPI()
    
    private let achieveProvider = MoyaProvider<AchieveService>(plugins: [MoyaLoggingPlugin()])

    private init() { }
    
    public private(set) var situationStatisticsData: GeneralArrayResponse<SituationStatistcsResponseDTO>?
    public private(set) var missionStatisticsData: GeneralArrayResponse<MissionStatistcsResponseDTO>?
    public private(set) var achieveCalendarData: GeneralResponse<AchieveCalendarResponseDTO>?

    // MARK: - GET
    
    func getSituationStatistics(completion: @escaping (GeneralArrayResponse<SituationStatistcsResponseDTO>?) -> Void) {
        achieveProvider.request(.situationStatistics) { result in
            switch result {
            case .success(let response):
                do {
                    self.situationStatisticsData = try response.map(GeneralArrayResponse<SituationStatistcsResponseDTO>?.self)
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
    
    // MARK: - GET
    
    func getMissionStatistics(completion: @escaping (GeneralArrayResponse<MissionStatistcsResponseDTO>?) -> Void) {
        achieveProvider.request(.missionStatistics) { result in
            switch result {
            case .success(let response):
                do {
                    self.missionStatisticsData = try response.map(GeneralArrayResponse<MissionStatistcsResponseDTO>?.self)
                    guard let situationStatisticsData = self.missionStatisticsData else { return }
                    completion(self.missionStatisticsData)
                } catch let err {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // MARK: - GET

    func getAchieveCalendar(month: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        achieveProvider.request(.achieveCalendar(month: month)) { response in
            switch response {
            case let .success(response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = NetworkBase.judgeStatus(by: statusCode, data,
                                                            [AchieveCalendarResponseDTO].self)
                completion(networkResult)
            case let .failure(err):
                print(err)
            }
        }
    }

}
