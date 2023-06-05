//
//  NetworkService.swift
//  iMusic
//
//  Created by RAFAEL on 01.06.2023.
//

import UIKit
import Alamofire

class NetworkService {
    
    func fetchTracks(searchText: String, completion: @escaping(SearchResponse?) -> Void) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term":"\(searchText)",
                          "limit":"30", "media":"music"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
                print("objects: ", objects)
                completion(objects)
                
            } catch let jsonError{
                print("Failed to decode JSON", jsonError)
                completion(nil)
            }
            //        let someString = String(data: data, encoding: .utf8)
            //            print(someString ?? "")
            //
        }
    }
    
}
