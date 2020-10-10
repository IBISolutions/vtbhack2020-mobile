//
//  Mapper.swift
//  Service
//
//  Created by viktor.volkov on 10.10.2020.
//

import Foundation

public final class Mapper<MappingResult: Decodable> {
        
    let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    
    public init(dateStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) {
        self.dateDecodingStrategy = dateStrategy
        self.keyDecodingStrategy = keyDecodingStrategy
    }
    
    func map<MappingResult: Decodable>(data: Data) -> Swift.Result<MappingResult, Error> {
        
        if let data = data as? MappingResult {
            return .success(data)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        return Result { try decoder.decode(MappingResult.self, from: data) }.mapError {
            e in
            
            print(MappingResult.self, e)
            return e
        }
    }
}
