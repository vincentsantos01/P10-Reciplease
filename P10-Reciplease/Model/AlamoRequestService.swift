//
//  AlamoRequestService.swift
//  P10-Reciplease
//
//  Created by vincent santos on 04/06/2021.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callBack: @escaping (AFDataResponse<Any>) -> Void)
}

final class RecipeSession: AlamoSession {
    func request(with url: URL, callBack: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { responseData in
            callBack(responseData)
        }
    }
}
