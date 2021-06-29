//
//  EncoderUrl.swift
//  P10-Reciplease
//
//  Created by vincent on 22/06/2021.
//

import Foundation

protocol EncoderUrl {
    func encode(baseUrl: URL, parameters: [(String, String)]) -> URL
}


extension EncoderUrl {
    func encode(baseUrl: URL, parameters: [(String, String)]) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else { return baseUrl }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: value)
            urlComponents.queryItems?.append(queryItem)
        }
        guard let url = urlComponents.url else { return baseUrl }
        return url
    }
}
