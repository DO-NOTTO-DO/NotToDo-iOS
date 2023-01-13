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
    
    public private(set) var missionDailyData: GeneralArrayResponse<DailyMissionResponseDTO>?
    public private(set) var updateMissionStatus: GeneralResponse<UpdateMissionResponseDTO>?
    public private(set) var addAnotherDay: GeneralResponse<AddAnotherDayResponseDTO>?
    public private(set) var missionWeekly: GeneralResponse<WeekMissionResponseDTO>?

    // MARK: - GET
        
    func getBanner(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.banner) { response in
            switch response {
            case let .success(response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = NetworkBase.judgeStatus(by: statusCode, data, BannerResponseDTO.self)
                completion(networkResult)
            case let .failure(err):
                print(err)
            }
        }
    }
    
    func getDailyMission(date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.dailyMission(date: date)) { response in
            switch response {
            case let .success(response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = NetworkBase.judgeStatus(by: statusCode, data, [DailyMissionResponseDTO].self)
                completion(networkResult)
            case let .failure(err):
                print(err)
            }
        }
    }

    func getWeeklyMissoin(startDate: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.missionWeekly(startDate: startDate)) { response in
            switch response {
            case let .success(response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = NetworkBase.judgeStatus(by: statusCode, data,
                                                            [WeekMissionResponseDTO].self)
                completion(networkResult)
            case let .failure(err):
                print(err)
            }
        }
    }
    
    // MARK: - Patch
    
    func patchUpdateMissionStatus(id: Int, status: String, completion: @escaping (GeneralResponse<UpdateMissionResponseDTO>?) -> Void) {
        homeProvider.request(.updateMissionStatus(id: id, status: status)) { result in
            switch result {
            case .success(let response):
                do {
                    self.updateMissionStatus = try response.map(GeneralResponse<UpdateMissionResponseDTO>?.self)
                    guard let updateMissionStatus = self.updateMissionStatus else { return }
                    completion(self.updateMissionStatus)
                } catch (let err) {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // MARK: - Delete
    
    func deleteMission(id: Int, completion: @escaping (GeneralResponse<VoidType>?) -> Void) {
        homeProvider.request(.deleteMission(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let data = try response.map(GeneralResponse<VoidType>.self)
                    completion(data)
                } catch (let err) {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // MARK: - Post
    
    func postAnotherDay(id: Int, dates: [String], completion: @escaping (GeneralResponse<AddAnotherDayResponseDTO>?) -> Void) {
        homeProvider.request(.addAnotherDay(id: id, dates: dates)) { result in
            switch result {
            case .success(let response):
                do {
                    self.addAnotherDay = try response.map(GeneralResponse<AddAnotherDayResponseDTO>?.self)
                    guard let addAnotherDay = self.addAnotherDay else { return }
                    completion(addAnotherDay)
                } catch(let err) {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
