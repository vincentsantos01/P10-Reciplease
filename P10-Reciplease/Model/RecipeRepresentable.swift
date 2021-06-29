//
//  RecipeSearchResult.swift
//  P10-Reciplease
//
//  Created by vincent santos on 04/06/2021.
//

import Foundation

struct RecipeRepresentable {
    let name: String
    let imageData: Data?
    let ingredients: [String]
    let url: String
    let score: String
    let totalTime: String
}
