//
//  RecipeModel.swift
//  P10-Reciplease
//
//  Created by vincent santos on 14/06/2021.
//

import Foundation

struct RecipeData: Decodable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}
struct Hit: Decodable {
    let recipe: Recipe
}
struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Double
    let dietLabels, healthLabels: [String]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalWeight: Double
    let totalTime: Int
    let totalNutrients, totalDaily: [String: Total]
}
enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case iu = "IU"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}
struct Ingredient: Decodable {
    let text: String
    let weight: Double
}
struct Total: Decodable {
    let label: String
    let quantity: Double
    let unit: Unit
}
