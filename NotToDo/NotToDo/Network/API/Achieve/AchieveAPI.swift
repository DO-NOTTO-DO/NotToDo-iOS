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
    
    public private(set) var situationStatisticsData: GeneralArrayResponse<SituationStatistcsResponse>?
    public private(set) var missionStatisticsData: GeneralArrayResponse<MissionStatistcsResponse>?
    public private(set) var achieveCalendarData: GeneralArrayResponse<AchieveCalendarResponse>?

    // MARK: - GET
    
    func getSituationStatistics(completion: @escaping (GeneralArrayResponse<SituationStatistcsResponse>?) -> Void) {
        achieveProvider.request(.situationStatistics) { result in
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
    
    // MARK: - GET
    
    func getMissionStatistics(completion: @escaping (GeneralArrayResponse<MissionStatistcsResponse>?) -> Void) {
        achieveProvider.request(.missionStatistics) { result in
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
    
    // MARK: - GET
    
    func getAchieveCalendar(month: String, completion: @escaping (GeneralArrayResponse<AchieveCalendarResponse>?) -> Void) {
        achieveProvider.request(.achieveCalendar(month: month)) { result in
            switch result {
            case .success(let response):
                do {
                    self.achieveCalendarData = try response.map(GeneralArrayResponse<AchieveCalendarResponse>?.self)
                    guard let situationStatisticsData = self.achieveCalendarData else { return }
                    completion(self.achieveCalendarData)
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
