//
//  RAWGAPI.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 09/11/23.
//

import RxSwift
import Alamofire

protocol RAWGAPIDataSourceProtocol {
    
    func getGameListRx() -> Observable<RAWGGameListModel>
    
    func getGameDetailRx(gameID: String) -> Observable<RAWGGameDetailModel>
    
    func getGameList(completionHandler: @escaping (Result<RAWGGameListModel, AFError>) -> Void)
    
    func getGameDetail(gameID: String, completionHandler: @escaping (Result<RAWGGameDetailModel, AFError>) -> Void)
}

class RAWGAPIDataSource: RAWGAPIDataSourceProtocol {

    var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "RAWG", ofType: "plist") else {

            guard Bundle.main.path(forResource: "RAWG-Sample", ofType: "plist") != nil else {
                fatalError("Couldn't find any file RAWG-Sample")
            }

            fatalError("Change the RAWG-Sample.plist to RAWG.plist and set the value with [APIKey:\"TheKey\"], to get \"TheKey\" go to https://rawg.io/apidocs")
        }

        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "APIKey") as? String else {
            fatalError("Couldn't find key 'APIKey' in 'RAWG.plist'.")
        }
        return value
    }
    
    func getGameListRx() -> Observable<RAWGGameListModel> {
        return Observable<RAWGGameListModel>.create { observer in
            let gameListURL = "https://api.rawg.io/api/games?page_size=50&key=\(self.apiKey)"
            AF.request(gameListURL).responseDecodable(of: RAWGGameListModel.self) { response in
                switch response.result {
                case .success(let success):
                    observer.onNext(success)
                    observer.onCompleted()
                case .failure(let failure):
                    observer.onError(failure)
                }
            }
            return Disposables.create()
        }
    }
    
    func getGameDetailRx(gameID: String) -> Observable<RAWGGameDetailModel> {
        return Observable<RAWGGameDetailModel>.create { observer in
            let gameDetailURL = "https://api.rawg.io/api/games/\(gameID)?key=\(self.apiKey)"

            AF.request(gameDetailURL).responseDecodable(of: RAWGGameDetailModel.self) { response in
                switch response.result {
                case .success(let success):
                    observer.onNext(success)
                    observer.onCompleted()
                case .failure(let failure):
                    observer.onError(failure)
                }
            }
            return Disposables.create()
        }
    }

    func getGameList(completionHandler: @escaping (Result<RAWGGameListModel, AFError>) -> Void) {
        let gameListURL = "https://api.rawg.io/api/games?page_size=50&key=\(apiKey)"
        AF.request(gameListURL).responseDecodable(of: RAWGGameListModel.self) { response in
            completionHandler(response.result)
        }
    }

    func getGameDetail(gameID: String, completionHandler: @escaping (Result<RAWGGameDetailModel, AFError>) -> Void) {
        let gameDetailURL = "https://api.rawg.io/api/games/\(gameID)?key=\(apiKey)"

        AF.request(gameDetailURL).responseDecodable(of: RAWGGameDetailModel.self) { response in
            completionHandler(response.result)
        }
    }
}
