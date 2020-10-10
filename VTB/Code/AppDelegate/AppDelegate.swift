//
//  AppDelegate.swift
//  VTB
//
//  Created by viktor.volkov on 09.10.2020.
//

import UIKit
import Service

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var rootViewController = UINavigationController()
    private lazy var appCoordinator = self.makeAppCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        //apiCalculatorGetSettings()
        //apiCarLoan("if1242@yandex.ru", 140000, "+79811034016", "Иван", "Федоров", "Романович", "1994-11-29", "г. Санкт-Петербург", "Nissan", 300000, 3, 440000, 10.7)
        //apiCalculatorPaymentsGraph(10.1, 26.94, 1000000, 50000, 3)
        //apiCalculatorCalculate(400000, 150000, 5, true, true, true)
        //apiMarketplaceLoad()
//        apiCarRecognitionCarRecignize()
		appCoordinator.start()
        return true
    }
	
	private func makeAppCoordinator() -> Coordinator {
        let router = RouterImp(rootController: rootViewController)
        return AppCoordinator(router: router,
                              coordinatorFactory: CoordinatorFactory(),
                              moduleFactory: ModuleFactory(router: router))
    }
    
    private func apiCalculatorGetSettings() {
        let headers = [
          "x-ibm-client-id": "424d8a3ed155851f325f7090c7049df6",
          "accept": "application/json"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://gw.hackathon.vtb.ru/vtb/hackathon/settings?name=Haval&language=ru-RU")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
            print(data)
            guard let data = data else {
                return
            }
            let str = String(data: data, encoding: .utf8)
            print(str)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            do {
                let settings = try decoder.decode(Settings.self, from: data)
                print(settings)
            } catch let e {
                print(e)
            }
          }
        })
        
        dataTask.resume()
    }
    
    private func apiCarLoan(_ email: String,
                            _ incomeAmount: Int,
                            _ phone: String,
                            _ firstName: String,
                            _ familyName: String,
                            _ middleName: String,
                            _ birthDateTime: String,
                            _ birthPlace: String,
                            _ tradeMark: String,
                            _ requestedAmount: Int,
                            _ requestedTerm: Int,
                            _ vehicleCost: Int,
                            _ interestRate: Double) {
        let headers = [
          "x-ibm-client-id": "424d8a3ed155851f325f7090c7049df6",
          "content-type": "application/json",
          "accept": "application/json"
        ]
        let parameters = [
          "comment": "Комментарий",
          "customer_party": [
            "email": "\(email)",
            "income_amount": incomeAmount,
            "person": [
              "birth_date_time": "\(birthDateTime)",
              "birth_place": "\(birthPlace)",
              "family_name": "\(familyName)",
              "first_name": "\(firstName)",
              "gender": "unknown",
              "middle_name": "\(middleName)",
              "nationality_country_code": "RU"
            ],
            "phone": "\(phone)"
          ],
          "datetime": "2020-10-10T08:15:47Z",
          "interest_rate": interestRate,
          "requested_amount": requestedAmount,
          "requested_term": requestedTerm,
          "trade_mark": "\(tradeMark)",
          "vehicle_cost": vehicleCost
        ] as [String : Any]

        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        let request = NSMutableURLRequest(url: NSURL(string: "https://gw.hackathon.vtb.ru/vtb/hackathon/carloan")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
            
            guard let data = data else {
                return
            }
            let str = String(data: data, encoding: .utf8)
            print(str)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decisionReport = try decoder.decode(CarLoan.self, from: data)
                print(decisionReport)
            } catch let e {
                print(e)
            }
        })
        
        dataTask.resume()
    }
    
    
//    private func apiCalculatorPaymentsGraph(_ contractRate: Double,
//                                            _ lastPayment: Double,
//                                            _ loanAmount: Double,
//                                            _ payment: Double,
//                                            _ term: Int) {
//        let headers = [
//          "x-ibm-client-id": "424d8a3ed155851f325f7090c7049df6",
//          "content-type": "application/json",
//          "accept": "application/json"
//        ]
//        let parameters = [
//          "contractRate": contractRate,
//          "lastPayment": lastPayment,
//          "loanAmount": loanAmount,
//          "payment": payment,
//          "term": term
//        ] as [String : Any]
//
//        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://gw.hackathon.vtb.ru/vtb/hackathon/payments-graph")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
//        request.httpBody = postData
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//          if (error != nil) {
//            print(error)
//          } else {
//            let httpResponse = response as? HTTPURLResponse
//            print(httpResponse)
//          }
//          guard let data = data else {
//            return
//          }
//          let str = String(data: data, encoding: .utf8)
//          print(str)
//          let decoder = JSONDecoder()
//          decoder.keyDecodingStrategy = .useDefaultKeys
//          do {
//            let paymentsGraph = try decoder.decode(PaymentsGraph.self, from: data)
//            print(paymentsGraph)
//          } catch let e {
//            print(e)
//          }
//        })
//
//        dataTask.resume()
//    }
    
    private func apiCalculatorCalculate(_ cost: Double,
                                        _ initialFee: Double,
                                        _ term: Int,
                                        _ kascoSelected: Bool,
                                        _ fullDocPackageSelected: Bool,
                                        _ lifeCareSelected: Bool) {
        let headers = [
          "x-ibm-client-id": "424d8a3ed155851f325f7090c7049df6",
          "content-type": "application/json",
          "accept": "application/json"
        ]
        let parameters = [
          "clientTypes": [],
          "cost": cost,
          "initialFee": initialFee,
          "kaskoValue": cost * 0.15, //значение Каско берем 15% от полной стоимости
          "language": "ru-RU",
          "residualPayment": cost * 0.15 + cost - initialFee, //остаточный платеж = стоимость каско + полная стоимость - первоначальный взнос
          "settingsName": "Haval",
          "specialConditions": ["57ba0183-5988-4137-86a6-3d30a4ed8dc9", "b907b476-5a26-4b25-b9c0-8091e9d5c65f", "cbfc4ef3-af70-4182-8cf6-e73f361d1e68"],
          "term": term
        ] as [String : Any]

        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        let request = NSMutableURLRequest(url: NSURL(string: "https://gw.hackathon.vtb.ru/vtb/hackathon/calculate")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
          }
          guard let data = data else {
            return
          }
          let str = String(data: data, encoding: .utf8)
          print(str)
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .useDefaultKeys
          do {
            let calculateResult = try decoder.decode(Calculate.self, from: data)
            print(calculateResult)
          } catch let e {
            print(e)
          }
        })

        dataTask.resume()
        
    }
    
    private func apiMarketplaceLoad() {
        let headers = [
          "x-ibm-client-id": "424d8a3ed155851f325f7090c7049df6",
          "accept": "application/json"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://gw.hackathon.vtb.ru/vtb/hackathon/marketplace")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
            print(data)
            guard let data = data else {
                return
            }
            let str = String(data: data, encoding: .utf8)
            print(str)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            do {
                let marketplace = try decoder.decode(Marketplace.self, from: data)
                print(marketplace)
            } catch let e {
                print(e)
            }
          }
        })

        dataTask.resume()
    }
    
    private let service = NetworkService()
    
}

