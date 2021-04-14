//
//  APIManager.swift
//  CoronaClass
//
//  Created by Igor Parnadjiev on 7.4.21.
//

import Foundation
import Alamofire

class APIManager {
    
    typealias CountriesResultsCompletion = ((Result<[Country], Error>) -> Void)
    typealias GlobalInfoCompletion = ((Result<Global, Error>) -> Void)

    let url = "https://api.covid19api.com/countries"
    
    static let shared = APIManager()
    private init() {}
 
    func getAllCountries(completion: @escaping CountriesResultsCompletion) {
        AF.request(url).responseDecodable(of: [Country].self) { response  in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let countries):
                completion(.success(countries))
            }
        }
    }
    
    func getGlobalInfo(completion: @escaping GlobalInfoCompletion) {
        AF.request("https://api.covid19api.com/summary").responseDecodable(of: GlobalResponse.self) { response  in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let global):
                completion(.success(global.global))
            }
        }
    }
}
