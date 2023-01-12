//
//  AddSituationAPI.swift
//  NotToDo
//
//  Created by 김민서 on 2023/01/12.

import Foundation

import Moya

final class AddSituationAPI {
    
    static let shared: AddSituationAPI = AddSituationAPI()
    
    private let addSituationProvider = MoyaProvider<AddMissionService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    public private(set) var addSituationData: GeneralResponse<AddSituationResponse>?
    
    // MARK: - GET
    
    func getAddSituation(completion: @escaping (GeneralResponse<AddSituationResponse>?) -> ()) {
        addSituationProvider.request(.addSituation) { result in
            switch result {
            case .success(let response):
                do {
                    self.addSituationData = try response.map(GeneralResponse<AddSituationResponse>?.self)
                    guard let addSituationData = self.addSituationData else { return }
                    completion(addSituationData)
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
