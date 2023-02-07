//
//  AQI.swift
//  CallAPIExample
//
//  Created by imac-2437 on 2023/2/3.
//

import Foundation

struct AQIResponse: Decodable {
        
    let records: [Records]
    
    struct Records: Decodable {
        
        let county: String
        
        let sitename: String
        
        let aqi: String
        
        let status: String
    }

}


