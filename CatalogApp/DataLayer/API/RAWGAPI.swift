//
//  RAWGAPI.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 09/11/23.
//

import Alamofire

class RAWGAPI {

    static var apiKey: String {
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

    static func getGameList(key apiKey: String, completionHandler: @escaping (Result<RAWGGameListModel, AFError>) -> Void) {
        let gameListURL = "https://api.rawg.io/api/games?page_size=50&key=\(apiKey)"
        AF.request(gameListURL).responseDecodable(of: RAWGGameListModel.self) { response in
            completionHandler(response.result)
        }
    }

    static func getGameDetail(key apiKey: String, id gameID: String, completionHandler: @escaping (Result<RAWGGameDetailModel, AFError>) -> Void) {
        let gameDetailURL = "https://api.rawg.io/api/games/\(gameID)?key=\(apiKey)"

        AF.request(gameDetailURL).responseDecodable(of: RAWGGameDetailModel.self) { response in
            completionHandler(response.result)
        }
    }
}
