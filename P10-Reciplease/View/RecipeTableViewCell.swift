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
            //recipeIngredients.text = recipe?.recipe.ingredients[0].text
            cookingTimeLabel.text = recipe?.recipe.totalTime.timeFormater()
            let score = recipe?.recipe.yield
            if score == 0 {
                yieldLabel.text = "?"
            } else {
                yieldLabel.text = "\(score ?? 0) people"
            }
        }
    }
    
    var favoriteRecipe: FavoritesList? {
        didSet {
            guard let image = favoriteRecipe?.image else { return }
            recipeImageView.image = UIImage(data: image)
            recipeTitle.text = favoriteRecipe?.name
            //guard let ingredient = favoriteRecipe?.ingredients?.joined(separator: ",") else { return }
            //recipeIngredients.text = "\(ingredient)"
            guard let time = Int(favoriteRecipe?.totalTime ?? "") else { return }
            cookingTimeLabel.text = "\(time.timeFormater())"
            guard let score = favoriteRecipe?.score else { return }
            yieldLabel.text = "\(score)"
        }
    }
    
}
