//
//  MissionHistoryAPI.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/13.
//

import Foundation

import Moya

final class MissionHistoryAPI {
    
    static let shared: MissionHistoryAPI = MissionHistoryAPI()
    
    private let missionHistoryProvider = MoyaProvider<AddMissionService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    public private(set) var missionHistoryData: GeneralArrayResponse<MissionHistoryModel>?
    
    // MARK: - GET
    
    func getMissionHistory(completion: @escaping (GeneralArrayResponse<MissionHistoryModel>?) -> Void) {
        missionHistoryProvider.request(.missionHistory) { result in
            switch result {
            case .success(let response):
                do {
                    self.missionHistoryData = try
                    response.map(GeneralArrayResponse<MissionHistoryModel>?.self)
                    guard let missionHistoryData = self.missionHistoryData else { return }
                    completion(missionHistoryData)
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
