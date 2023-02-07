//
//  NetworkConstants.swift
//  CallAPIExample
//
//  Created by imac-2437 on 2023/2/3.
//

import Foundation

struct NetworkConstants {
    
    static let apiKey = "d31a4d5a-5c93-4b33-a25e-6495541e889e"
    
    static let baseUrl = "https://"
    
    enum APIpath: String {
        
        case aqi = "data.epa.gov.tw/api/v2/aqx_p_432"
    }
    
    enum Requestrror: Error {
        
        case invalidURL
        
        case unknownError(Error)
        
        case invalidResponse
        
        case jsonDecordeFailed
    }
}

typealias ResponseResult<D: Decodable> = Result<D, NetworkConstants.Requestrror>
