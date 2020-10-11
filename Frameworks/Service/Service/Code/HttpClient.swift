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
        static let ourUrl = "http://130.193.51.57:5000/api"
        static let timeoutInterval: TimeInterval = 30
    }
    
    private let session = URLSession.shared
    
    func load<Data: Codable>(useOurs: Bool = false,
                             method: HTTPMethod,
              endpoint: String,
              parameters: [String: Any]? = nil,
              mapper: Mapper<Data>,
              result: @escaping (Result<Data, Error>) -> Void) {
        
        let baseUrl = useOurs ? Constants.ourUrl : Constants.url
        guard let url = URL(string: baseUrl + endpoint) else {
            return
        }
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: Constants.timeoutInterval)
        request.httpMethod = method.rawValue
        var headers = [
            "content-type": "application/json",
            "accept": "application/json",
        ]
        if !useOurs {
            headers["x-ibm-client-id"] = "424d8a3ed155851f325f7090c7049df6"
        }
        request.allHTTPHeaderFields = headers
        
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
                let str = String(data: data, encoding: .utf8)
                print(str)
                DispatchQueue.main.async {
                    result(mapper.map(data: data))
                }
            }
        }
        dataTask.resume()
    }
}
