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
    
    private let homeProvider = MoyaProvider<HomeService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    public private(set) var bannerData: GeneralResponse<BannerResponse>?
    
    // MARK: - GET
    
    func getBanner(completion: @escaping (GeneralResponse<BannerResponse>?) -> ()) {
        homeProvider.request(.banner) { result in
            switch result {
            case .success(let response):
                do {
                    self.bannerData = try response.map(GeneralResponse<BannerResponse>?.self)
                    guard let bannerData = self.bannerData else { return }
                    completion(bannerData)
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
