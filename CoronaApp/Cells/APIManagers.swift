//
//  APIManagers.swift
//  CoronaApp
//
//  Created by Igor Parnadjiev on 10/29/20.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    init() {}
    
    func showContinents(completion: @escaping(_ continents: Continents?, _ error: Error?) -> ()) {
        
        AF.request(url, headers: headers).responseDecodable(of: Continents.self) { response in
            if let error = response.error {
                completion(nil, error)
                print(error.localizedDescription)
            }
            if let continents = response.value {
                completion(continents, nil)
                //print(continents)
            }
        }
    }
    
    func showCountries(completion: @escaping(_ countries: Regions?, _ error: Error?) -> ()) {
        
        AF.request(url, headers: headers).responseDecodable(of: Regions.self) { response in
            if let error = response.error {
                completion(nil, error)
                print(error.localizedDescription)
            }
            if let countries = response.value {
                completion(countries, nil)
                //print(countries)
            }
        }
    }
    
    func showDetails(completion: @escaping(_ details: Regions?, _ error: Error?) -> ()) {
        
        AF.request(url, headers: headers).responseDecodable(of: Regions.self) { response in
            if let error = response.error {
                completion(nil, error)
                print(error.localizedDescription)
            }
            if let details = response.value {
                completion(details, nil)
                //print(countries)
            }
        }
    }

    
//    func getInfoForCountry(completion: @escaping (_ sets: [String: Any]?, _ error: Error?) -> Void) {
//            
//        AF.request(url, headers: headers).responseJSON { response in
//            if let error = response.error {
//                completion(nil, error)
//            }
//            if let jsonData = response.value, let json = jsonData as? [String: Any] {
//                completion(json, nil)
//            }
//        }
//    }
    
    

    
    let url = "https://covid-193.p.rapidapi.com/statistics/"
    let headers: HTTPHeaders = ["x-rapidapi-host": "covid-193.p.rapidapi.com", "x-rapidapi-key": "c32afa15eamsh75b3373929a4fa4p161416jsn6c7f6292a741"]
    
}
