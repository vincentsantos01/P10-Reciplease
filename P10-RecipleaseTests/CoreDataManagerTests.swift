//
//  CoreDataManagerTests.swift
//  P10-RecipleaseTests
//
//  Created by vincent on 30/06/2021.
//

import Foundation
import XCTest
@testable import P10_Reciplease

class CoreDataManagerTests: XCTestCase {

    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        coreDataManager = nil
        coreDataStack = nil
    }
 
    
    func testAddRecipeMethod_WhenEntityIsCreated_ThenShouldedCorrectlySaved() {
        coreDataManager.addToFavoriteList(name: "Pani Puri", ingredients: [""], totalTime: "0", score: "2", recipeUrl: "https://food52.com/recipes/85943-best-pani-puri-recipe", image: Data())
        XCTAssertTrue(!coreDataManager.favoritesRecipe.isEmpty)
        XCTAssertTrue(coreDataManager.favoritesRecipe.count == 1)
        XCTAssertTrue(coreDataManager.favoritesRecipe[0].name! == "Pani Puri")
    }
    
    func testDeleteRecipeFromFavoriteMethod_WhenEntityIsDeleted_ThenShouldedCorrectlyDeleted() {
        coreDataManager.addToFavoriteList(name: "Pani Puri", ingredients: [""], totalTime: "0", score: "2", recipeUrl: "https://food52.com/recipes/85943-best-pani-puri-recipe", image: Data())
        coreDataManager.addToFavoriteList(name: "Blueberry Cocoa Crumble", ingredients: [""], totalTime: "0", score: "0", recipeUrl: "https://food52.com/recipes/85953-best-blueberry-crumble-recipee", image: Data())
        coreDataManager.deleteFromFavoriteList(name: "Pani Puri")
        XCTAssertTrue(!coreDataManager.favoritesRecipe.isEmpty)
        XCTAssertTrue(coreDataManager.favoritesRecipe.count == 1)
        XCTAssertTrue(coreDataManager.favoritesRecipe[0].name! == "Blueberry Cocoa Crumble")
    }
    
    func testRecipeIsAlreadyInFavoritesMethod_WhenEntityAlreadyExists_ThenShouldReturnTrue() {
        coreDataManager.addToFavoriteList(name: "Pani Puri", ingredients: [""], totalTime: "0", score: "2", recipeUrl: "https://food52.com/recipes/85943-best-pani-puri-recipe", image: Data())
        XCTAssertTrue(coreDataManager.recipeIsAlreadyInFavorite(name: "Pani Puri"))
    }
    
}
