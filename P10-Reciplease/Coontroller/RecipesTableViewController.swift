//
//  RecipesTableViewController.swift
//  P10-Reciplease
//
//  Created by vincent on 22/06/2021.
//

import Foundation
import UIKit

class RecipesTableViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var recipeDetail: Recipe?
    var recipeData: RecipeData?
    var recipeRepresentable: RecipeRepresentable?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeVC = segue.destination as? RecipeDetailViewController else { return }
        recipeVC.recipeRepresentable = recipeRepresentable
    }
}

extension RecipesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeData?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            fatalError("Cell can't be loaded")
        }
        cell.recipe = recipeData?.hits[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeDetail = recipeData?.hits[indexPath.row].recipe
        recipeRepresentable = RecipeRepresentable(name: recipeDetail?.label ?? "", imageData: recipeDetail?.image.data, ingredients: recipeDetail?.ingredientLines ?? [], url: recipeDetail?.url ?? "", score: recipeDetail?.yield.formatUsingAbbrevation() ?? "", totalTime: recipeDetail?.totalTime.convertTime ?? "")
        performSegue(withIdentifier: "segueToRecipeDetail", sender: self)
    }
}


extension RecipesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
}
