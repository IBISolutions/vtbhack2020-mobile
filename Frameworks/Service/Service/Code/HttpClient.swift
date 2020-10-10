//
//  HttpClient.swift
//  Service
//
//  Created by viktor.volkov on 10.10.2020.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

public class HttpClient {
    
    private enum Constants {
        static let url = "https://gw.hackathon.vtb.ru/vtb/hackathon"
        static let timeoutInterval: TimeInterval = 30
    }
    
    private let session = URLSession.shared
    
    func load<Data: Codable>(method: HTTPMethod,
              endpoint: String,
              parameters: [String: Any]? = nil,
              mapper: Mapper<Data>,
              result: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: Constants.url + endpoint) else {
            return
        }
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: Constants.timeoutInterval)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = [
            "x-ibm-client-id": "424d8a3ed155851f325f7090c7049df6",
            "content-type": "application/json",
            "accept": "application/json",
        ]
        if let parameters = parameters,
           let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = data
        }
        
        let dataTask = session.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if let error = error {
                result(.failure(error))
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    result(mapper.map(data: data))
                }
            }
        }
        dataTask.resume()
    }
}
