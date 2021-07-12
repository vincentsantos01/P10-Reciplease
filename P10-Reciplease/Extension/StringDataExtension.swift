//
//  StringDataExtension.swift
//  P10-Reciplease
//
//  Created by vincent on 18/06/2021.
//

import Foundation

extension String {
    
    /// Parametre qui permets de ne pas pouvoir mettre d'espaces dans le textfield
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
    /// Parametre qui permets de ne pas pouvoir mettre de nombres dans le textfield
    var isNumeric: Bool {
        return self.trimmingCharacters(in: .letters) != String() ? true : false
    }
    
    var data: Data? {
        guard let url = URL(string: self) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
