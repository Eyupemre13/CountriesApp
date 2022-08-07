//
//  EndpointCases.swift
//  Countries App
//
//  Created by Eyup Emre Aygun on 6.08.2022.
//

import Foundation
import Alamofire

enum EndpointCases: Endpoint {
    case getCountries(offset: Int)
    case getCountryDetail(countryCode: String)
    
    var apiKey: String {
        return NetworkConstants.apiKey
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    var baseURLString: String {
        return NetworkConstants.apiURL
    }
    
    var path: String {
        switch self {

        case .getCountries(let offset):
            return "/?limit=10&offset=\(String(offset))"
        case .getCountryDetail(let countryCode):
            return "/" + countryCode
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var body: [String : Any]? {
        switch self {
        case .getCountries:
            return [:]
        case .getCountryDetail:
            return [:]
        }
    }
}
