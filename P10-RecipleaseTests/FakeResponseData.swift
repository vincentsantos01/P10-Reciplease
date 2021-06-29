//
//  FakeResponseData.swift
//  P10-RecipleaseTests
//
//  Created by vincent on 28/06/2021.
//

import Foundation

final class FakeResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http://www.apple.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://www.apple.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RecipeDataFake", withExtension: "json")
        guard let data = try? Data(contentsOf: url!) else {
            fatalError("RecipeDataFake introuvable")
        }
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!
}
