//
//  FavoritesTableViewController.swift
//  P10-Reciplease
//
//  Created by vincent on 24/06/2021.
//

import UIKit

class FavoritesTableViewController: UIViewController {
    
    
    @IBOutlet weak var favoriteTableView: UITableView! { didSet { favoriteTableView.tableFooterView = UIView() }}
    
    
    
    var coreDataManager: CoreDataManager?
    var recipeDetail: Recipe?
    var favoriteRecipe: FavoritesList?
    var recipeRepresentable: RecipeRepresentable?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeVC = segue.destination as? RecipeDetailViewController else { return }
        recipeVC.recipeRepresentable = recipeRepresentable
    }
    
}


extension FavoritesTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coreDataManager?.favoritesRecipe.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        favoriteCell.favoriteRecipe = coreDataManager?.favoritesRecipe[indexPath.row]
        return favoriteCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteRecipe = coreDataManager?.favoritesRecipe[indexPath.row]
        recipeRepresentable = RecipeRepresentable(name: favoriteRecipe?.name ?? "", imageData: favoriteRecipe?.image, ingredients: ((favoriteRecipe?.ingredients ?? [])), url: favoriteRecipe?.recipeUrl ?? "", score: favoriteRecipe?.score ?? "", totalTime: favoriteRecipe?.totalTime ?? "")
        performSegue(withIdentifier: "segueToRecipeDetail", sender: self)
    }
}


extension FavoritesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            guard let recipe = coreDataManager?.favoritesRecipe[indexPath.row].name else { return }
            coreDataManager?.deleteFromFavoriteList(name: recipe)
            favoriteTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some recipe in your Favorites"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.favoritesRecipe.isEmpty ?? true ? 200 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
