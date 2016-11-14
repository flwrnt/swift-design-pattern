//
//  Request.swift
//  design-pattern
//
//  Created by Flwrnt on 10/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import Foundation

enum Method: String {
    case POST
    case GET
    case PUT
    case DELETE
}

typealias HttpHeaders = [String: String]
typealias Parameters = [String: String]

struct Request {
    private var path: String
    private var method: Method
    
    var description: String {
        return "Path: \(path)\nMethod: \(method)"
    }
    
    init(path: String, method: Method = .POST) {
        self.path = path
        self.method = method
    }
    
    func createUrlRequest(headers: HttpHeaders = [:], params: Parameters = [:]) -> URLRequest {
        // build url & request
        let url = URL(string: path)
        var request = URLRequest(url: url!)
        
        // set request config
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        // prepare & set request body
        var body = ""
        for param in params {
            body += "\(param.key)=\(param.value)&"
        }
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        return request
    }
    
    static func send(urlReq: URLRequest, completion: @escaping (Result<Data>, URLResponse?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: urlReq) { data, response, error in
            guard error == nil else { completion(.fail(.network("error: \(error!)")), response); return }
            
            completion(.success(data!), response!)
        }.resume()
    }
    
    static func send(url: String, method: Method = .POST, headers: HttpHeaders = [:], params: Parameters = [:], completion: @escaping (Result<Data>, URLResponse?) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = self.init(path: url, method: method)
        let urlRequest = request.createUrlRequest(headers: headers, params: params)
        
        session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else { completion(.fail(.network("error: \(error!)")), response); return }
            
            completion(.success(data!), response!)
        }.resume()
    }
    
}
