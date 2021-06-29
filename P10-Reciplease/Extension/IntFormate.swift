//
//  IntFormate.swift
//  P10-Reciplease
//
//  Created by vincent on 17/06/2021.
//

import Foundation

extension Int {
    

    func timeFormater() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = .minute
        guard let formattedSring = formatter.string(from: TimeInterval(self)) else { return "" }
        return formattedSring
    }
}
