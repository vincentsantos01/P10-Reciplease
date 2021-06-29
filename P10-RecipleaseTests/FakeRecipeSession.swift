//
//  FakeRecipeSession.swift
//  P10-RecipleaseTests
//
//  Created by vincent on 29/06/2021.
//
@testable import P10_Reciplease
import Foundation
import Alamofire

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class FakeRecipeSession: AlamoSession {
        
   
    private let fakeResponse: FakeResponse
    
   
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(with url: URL, callBack callback: @escaping (AFDataResponse<Any>) -> Void) {
        let dataResponse = AFDataResponse<Any>(request: nil, response: fakeResponse.response, data: fakeResponse.data, metrics: nil, serializationDuration: 0, result: .success("OK"))
        callback(dataResponse)
    }
}
