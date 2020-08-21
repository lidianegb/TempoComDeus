//
//  HTTP.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation

enum HTTP {
    
    case get
    
       func request(url: URL?, header: [String: String] =
                        ["Content-Type": "application/json",
                         "Authentication": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlR1ZSBBdWcgMTggMjAyMCAxMzoxMzo1OCBHTVQrMDAwMC5saWRpYW5lZ29tZXNAYWx1LnVmYy5iciIsImlhdCI6MTU5Nzc1NjQzOH0.Txl9Q4BXGXoDDCuo1RVRJwMkdMQoMnUT2CRL3jB53ZM"],
                    body: [String: Any] = [:],
                    completion: @escaping (Data?, HTTPURLResponse?, String?) -> Void = { data, response, error in }) {
            
                guard let url = url else {
                    completion(nil, nil, "URL Invalida")
                    return
                }
            
                switch self {
                case .get:
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        completion(data, response as? HTTPURLResponse, error?.localizedDescription)
                    }.resume()
                    
            }
    }
    
}
