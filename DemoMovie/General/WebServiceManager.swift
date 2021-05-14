//
//  WebServiceManager.swift
//  DemoMovie
//
//  Created by Gabriel Castillo on 5/13/21.
//

import Foundation

class WebServiceManager {
    
    @discardableResult
    class func get(urlString: String, completion: @escaping (Result<Data,Error>) -> Void) -> URLSessionTask {
        
        let session = URLSession.shared
        var request = URLRequest.init(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,
               let data = data,
               response.statusCode == 200 {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } else if let error = error as NSError?, error.code != -999 {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }
        
        task.resume()
        return task
        
    }
    
}
