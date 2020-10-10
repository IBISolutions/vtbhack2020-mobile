//
//  NetworkService.swift
//  Service
//
//  Created by viktor.volkov on 10.10.2020.
//

import Foundation

public protocol NetworkServiceProtocol {
    
    func recognize(base64image: String, result: @escaping ((Result<CarRecognition, Error>) -> Void))
}

public class NetworkService: NetworkServiceProtocol {
    
    private enum Constants {
        enum Endpoints {
            static let recognize = "/car-recognize"
        }
    }
    
    private let client = HttpClient()
    
    public init() { }
    
    public func recognize(base64image: String, result: @escaping ((Result<CarRecognition, Error>) -> Void)) {
        let parameters = [
            "content": base64image,
        ] as [String : Any]
        client.load(method: .post,
                    endpoint: Constants.Endpoints.recognize,
                    parameters: parameters,
                    mapper: Mapper(keyDecodingStrategy: .useDefaultKeys), result: result)
    }
}
