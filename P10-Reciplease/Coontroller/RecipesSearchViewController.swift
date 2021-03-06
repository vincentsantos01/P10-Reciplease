//
//  RecipesSearchViewController.swift
//  P10-Reciplease
//
//  Created by vincent on 21/06/2021.
//

import UIKit

class RecipesSearchViewController: UIViewController {
    
/// Outlets
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView! { didSet { ingredientsTableView.tableFooterView = UIView() }}
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
/// Parametres
    
    var recipeService = RecipeService()
    var recipeData: RecipeData?
    var ingredients = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        styles()
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        addIngredient()
        ingredientsTableView.reloadData()
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        ingredients.removeAll()
        ingredientsTableView.reloadData()
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        getRecipes()
    }
    
/// Methode qui permet d'ajouter les ingrédients du textField vers la TableView
    func addIngredient() {
        guard let ingredientName = searchTextField.text else { return }
        if ingredientName.isBlank || ingredientName.isNumeric {
            presentAlert(titre: "oups", message: "Whitespace or digital character is not possible")
        } else {
            ingredients.append(ingredientName)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipesList = segue.destination as? RecipesTableViewController else { return }
        recipesList.recipeData = recipeData
    }
    
/// Methode qui permet d'arrondir les boutons
    func styles() {
        searchButton.layer.cornerRadius = 10
        searchButton.clipsToBounds = true
        addButton.layer.cornerRadius = 10
        addButton.clipsToBounds = true
        clearButton.layer.cornerRadius = 10
        clearButton.clipsToBounds = true
    }
    
/// Methode qui permet de lancer la recherche avec les ingrédients sélectionnés
    func getRecipes() {
        if ingredients.isEmpty {
            presentAlert(titre: "oups", message: "Please enter 1 ingredients at least")
        } else {
            recipeService.getRecipes(ingredientList: ingredients.joined(separator: ",")) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let recipesData):
                        self.recipeData = recipesData
                        self.performSegue(withIdentifier: "segueToListRecipes", sender: nil)
                    case .failure(let error):
                        self.presentAlert(titre: "oups", message: "Service unavailable")
                        print(error)
                    }
                }
            }
        }
    }
}


extension RecipesSearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientsCell = tableView.dequeueReusableCell(withIdentifier: "IngredientsCell", for: indexPath)
        ingredientsCell.textLabel?.text = ingredients[indexPath.row]
        return ingredientsCell
    }
}


extension RecipesSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
/// Methode qui permet de placer un placeholder en cas de liste vide
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some ingredients in the list"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ingredients.isEmpty ? 200 : 0
    }
    
}
