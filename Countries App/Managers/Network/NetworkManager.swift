//
//  NetworkManager.swift
//  Countries App
//
//  Created by Eyup Emre Aygun on 6.08.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    public func request<T: Codable>(from endPoint: Endpoint, completionHandler: @escaping (Result<T, Error>) -> Void) {
        // MARK: URL
        let urlString = endPoint.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString ?? "")!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(NetworkConstants.apiKey, forHTTPHeaderField: NetworkConstants.apiHeader)
        
        // MARK: HTTP Method
        urlRequest.httpMethod = endPoint.httpMethod
        
        AF.request(urlRequest).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    completionHandler(.success(data))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
