//
//  Endpoint.swift
//  Countries App
//
//  Created by Eyup Emre Aygun on 6.08.2022.
//

import Foundation
import Alamofire

protocol Endpoint {
    var apiKey: String { get }
    var httpMethod: String { get }
    var baseURLString: String { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    var url: String {
        return baseURLString + path
    }
}
