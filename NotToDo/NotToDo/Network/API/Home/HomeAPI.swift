//
//  HomeAPI.swift
//  NotToDo
//
//  Created by 강윤서 on 2023/01/12.
//

import Foundation

import Moya

final class HomeAPI {
    
    static let shared: HomeAPI = HomeAPI()
    
    private let mainProvider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    public private(set) var mainData: GeneralResponse<BannerResponse>?
    
    // MARK: - GET
    
    func getMain(completion: @escaping (GeneralResponse<BannerResponse>?) -> ()) {
        mainProvider.request(.banner) { result in
            switch result {
            case .success(let response):
                do {
                    self.mainData = try response.map(GeneralResponse<BannerResponse>?.self)
                    guard let mainData = self.mainData else { return }
                    completion(mainData)
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
