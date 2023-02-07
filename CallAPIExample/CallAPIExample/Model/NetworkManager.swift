//
//  NetworkManager.swift
//  CallAPIExample
//
//  Created by imac-2437 on 2023/2/3.
//

import Foundation

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    func requestData<D: Decodable>(offset: Int = 0,
                                   limit: Int ,
                                   finish: @escaping (ResponseResult<D>) -> Void) {
        
        //https://data.epa.gov.tw/api/v2/aqx_p_432?offset=0&limit=10&api_key=d31a4d5a-5c93-4b33-a25e-6495541e889e
        let path = NetworkConstants.baseUrl + NetworkConstants.APIpath.aqi.rawValue
        let apiKey = NetworkConstants.apiKey
        guard let url = URL(string: path + "?offset=\(offset)" + "&limit=\(limit)" + "&api_key=" + apiKey) else {
            finish(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                finish(.failure(.unknownError(error!)))
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                finish(.failure(.invalidResponse))
                return
            }
            let decoder = JSONDecoder()
            guard let data = data,
                  let results = try? decoder.decode(D.self, from: data) else {
                finish(.failure(.jsonDecordeFailed))
                return
            }
            finish(.success(results))
        }.resume()
    }
}


