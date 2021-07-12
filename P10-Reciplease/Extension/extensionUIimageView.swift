//
//  extensionUIimageView.swift
//  P10-Reciplease
//
//  Created by vincent santos on 18/06/2021.
//

import Foundation
import UIKit

/// Methode qui permets de transformer une image en data
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
