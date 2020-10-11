//
//  NetworkService.swift
//  Service
//
//  Created by viktor.volkov on 10.10.2020.
//

import Foundation

public protocol NetworkServiceProtocol {
    
    func marketplace(result: @escaping ((Result<Marketplace, Error>) -> Void))
    func recognize(base64image: String, result: @escaping ((Result<CarRecognition, Error>) -> Void))
    func recognizeOur(base64image: String, result: @escaping ((Result<CarRecognitionOur, Error>) -> Void))
    func calculate(using parameters: CalculateParameters, result: @escaping ((Result<Calculate, Error>) -> Void))
    func paymentGraph(using parameters: PaymentGraphParameters, result: @escaping ((Result<PaymentsGraph, Error>) -> Void))
    func loan(using parameters: LoanParameters, result: @escaping ((Result<CarLoan, Error>) -> Void))
    func settings(result: @escaping ((Result<Settings, Error>) -> Void))
}

public class NetworkService: NetworkServiceProtocol {
    
    enum Endpoints {
        static let marketplace = "/marketplace"
        static let recognize = "/car-recognize"
        static let recognizeOur = "/car-recognize/"
        static let calculate = "/calculate"
        static let paymentGraph = "/payments-graph"
        static let loan = "/carloan"
        static let settings = "/settings?name=Haval&language=ru-RU"
    }
    
    private let client = HttpClient()
    
    public init() { }
    
    public func marketplace(result: @escaping ((Result<Marketplace, Error>) -> Void)) {
        client.load(method: .get, endpoint: Endpoints.marketplace, mapper: Mapper(), result: result)
    }
    
    public func recognize(base64image: String, result: @escaping ((Result<CarRecognition, Error>) -> Void)) {
        let parameters = [
            "content": base64image,
        ] as [String : Any]
        client.load(method: .post,
                    endpoint: Endpoints.recognize,
                    parameters: parameters,
                    mapper: Mapper(keyDecodingStrategy: .useDefaultKeys), result: result)
    }
    
    public func recognizeOur(base64image: String, result: @escaping ((Result<CarRecognitionOur, Error>) -> Void)) {
        let parameters = [
            "content": base64image,
        ] as [String : Any]
        client.load(useOurs: true,
                    method: .post,
                    endpoint: Endpoints.recognizeOur,
                    parameters: parameters,
                    mapper: Mapper(keyDecodingStrategy: .useDefaultKeys), result: result)
    }
    
    public func calculate(using parameters: CalculateParameters,
                          result: @escaping ((Result<Calculate, Error>) -> Void)) {
        
        let kaskoValue = parameters.cost * 0.15
        let residalPayment = kaskoValue + parameters.cost - parameters.initialFee
        let parameters = [
            "clientTypes": [],
            "cost": parameters.cost,
            "initialFee": parameters.initialFee,
            "kaskoValue": Int(kaskoValue), //значение Каско берем 15% от полной стоимости
            "language": "ru-RU",
            "residualPayment": residalPayment, //остаточный платеж = стоимость каско + полная стоимость - первоначальный взнос
            "settingsName": "Haval",
            "specialConditions": parameters.selectedConditions,
            "term": parameters.term
        ] as [String : Any]
        client.load(method: .post,
                    endpoint: Endpoints.calculate,
                    parameters: parameters,
                    mapper: Mapper(keyDecodingStrategy: .useDefaultKeys),
                    result: result)
    }
    
    public func paymentGraph(using parameters: PaymentGraphParameters, result: @escaping ((Result<PaymentsGraph, Error>) -> Void)) {
        let parameters = [
            "contractRate": parameters.contractRate,
            "lastPayment": parameters.lastPayment,
            "loanAmount": parameters.loanAmount,
            "payment": parameters.payment,
            "term": parameters.term
        ] as [String : Any]
        
        client.load(method: .post,
                    endpoint: Endpoints.paymentGraph,
                    parameters: parameters,
                    mapper: Mapper(),
                    result: result)
    }
    
    public func loan(using parameters: LoanParameters, result: @escaping ((Result<CarLoan, Error>) -> Void)) {
        let parameters = [
          "comment": "Комментарий",
          "customer_party": [
            "email": parameters.email,
            "income_amount": parameters.incomeAmount,
            "person": [
                "birth_date_time": parameters.birthDateTime,
                "birth_place": parameters.birthPlace,
                "family_name": parameters.familyName,
                "first_name": parameters.firstName,
              "gender": "unknown",
                "middle_name": parameters.middleName,
              "nationality_country_code": "RU"
            ],
            "phone": parameters.phone
          ],
          "datetime": "2020-10-10T08:15:47Z",
            "interest_rate": parameters.interestRate,
            "requested_amount": parameters.requestedAmount,
            "requested_term": parameters.requestedTerm,
            "trade_mark": parameters.tradeMark,
            "vehicle_cost": parameters.vehicleCost
        ] as [String : Any]
        client.load(method: .post,
                    endpoint: Endpoints.loan,
                    parameters: parameters,
                    mapper: Mapper(),
                    result: result)
    }
    
    public func settings(result: @escaping ((Result<Settings, Error>) -> Void)) {
        client.load(method: .get, endpoint: Endpoints.settings, mapper: Mapper(), result: result)
    }
}
