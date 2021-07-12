//
//  RecipeDetailViewController.swift
//  P10-Reciplease
//
//  Created by vincent on 20/06/2021.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!
    @IBOutlet weak var recipeScoreLabel: UILabel!
    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var recipeTableView: UITableView!
    
    
    private var coreDataManager: CoreDataManager?
    var recipeRepresentable: RecipeRepresentable?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        updateRecipe()
        directionsButton.layer.cornerRadius = 20
        recipeImageView.layer.cornerRadius = 40
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if coreDataManager?.recipeIsAlreadyInFavorite(name: recipeRepresentable?.name ?? "") == false { 
            favoriteButton.image = UIImage(named: "favorite")
        } else {
            favoriteButton.image = UIImage(named: "favoriteok")
        }
    }
    
/// Methode qui permet de mettre a jour les informations de l'appel réseau
    func updateRecipe() {
        
        guard let recipeRepresentable = recipeRepresentable else { return }
        recipeTitleLabel.text = recipeRepresentable.name
        
        let times = recipeRepresentable.totalTime
        if times == "0mn" {
            recipeTimeLabel.text = "----"
        } else {
            recipeTimeLabel.text = "\(times)"
        }
        let yields = recipeRepresentable.score
        recipeScoreLabel.text = "\(yields)Yield"
        guard let image = recipeRepresentable.imageData else { return }
        recipeImageView.image = UIImage(data: image)
    }
/// Methode qui permet de passer les valeurs de l'appel réseau dans coreData
    func addRecipeToFavorite() {
        guard let recipeRepresentable = recipeRepresentable else { return }
        coreDataManager?.addToFavoriteList(name: recipeRepresentable.name, ingredients: recipeRepresentable.ingredients, totalTime: recipeRepresentable.totalTime, score: recipeRepresentable.score, recipeUrl: recipeRepresentable.url, image: recipeRepresentable.imageData)
    }
/// Methode qi permet de retirer de coreData la recette suprimée des favoris
    func deleteRecipeFromFavorites() {
        coreDataManager?.deleteFromFavoriteList(name: recipeTitleLabel.text ?? "")
    }
    
    
    @IBAction func getDirectionButton(_ sender: UIButton) {
        guard let url = URL(string: recipeRepresentable?.url ?? "") else {return}
        UIApplication.shared.open(url)
    }
    
    @IBAction func favoriteButton(_ sender: UIBarButtonItem) {
        
        if coreDataManager?.recipeIsAlreadyInFavorite(name: recipeRepresentable?.name ?? "") == true {
            deleteRecipeFromFavorites()
            favoriteButton.image = UIImage(named: "favorite")
            if tabBarController?.selectedIndex == 1 {
                navigationController?.popToRootViewController(animated: true)
            }
        } else {
            addRecipeToFavorite()
            favoriteButton.image = UIImage(named: "favoriteok")
        }
    }
    
    
}

extension RecipeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeRepresentable?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        guard let recipeRepresentable = recipeRepresentable else { return UITableViewCell() }
        let ingredient = recipeRepresentable.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}
