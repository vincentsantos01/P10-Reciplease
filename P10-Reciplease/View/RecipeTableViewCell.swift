//
//  RecipeTableViewCell.swift
//  P10-Reciplease
//
//  Created by vincent santos on 11/06/2021.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    
    
    var recipe: Hit? {
        didSet {
            guard let url = URL(string: recipe?.recipe.image ?? "recipe picture") else {return}
            recipeImageView.load(url: url)
            recipeTitle.text = recipe?.recipe.label
            let times = recipe?.recipe.totalTime.convertTime
            if times == "0mn" {
                cookingTimeLabel.text = "----"
            } else {
                cookingTimeLabel.text = "\(times ?? "----")"
            }
            self.yieldLabel.text = "\(Int(recipe!.recipe.yield).formatUsingAbbrevation())Yield"
        }
    }
    
    var favoriteRecipe: FavoritesList? {
        didSet {
            guard let image = favoriteRecipe?.image else { return }
            recipeImageView.image = UIImage(data: image)
            recipeTitle.text = favoriteRecipe?.name
            let times = favoriteRecipe?.totalTime ?? "0"
            cookingTimeLabel.text = "\(times)"
            let score = favoriteRecipe?.score ?? "0"
            yieldLabel.text = "\(score)Yield"
        }
    }
    
}
