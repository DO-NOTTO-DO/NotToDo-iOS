//
//  AddMission.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/13.
//

import Foundation

import Moya

final class AddMissionAPI {
    
    static let shared: AddMissionAPI = AddMissionAPI()
    
    private let addMissionProvider = MoyaProvider<AddMissionService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    // MARK: - POST
    
    func postAddMission(newMission: AddMissionRequest, completion: @escaping (GeneralResponse<AddMissionResponse>?) -> Void) {
        addMissionProvider.request(.addMission(newMission)) { result in
            switch result {
            case .success(let response):
                do {
                    guard let addMissionData = try response.map(GeneralResponse<AddMissionResponse>?.self) else { return }
                    completion(addMissionData)
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
