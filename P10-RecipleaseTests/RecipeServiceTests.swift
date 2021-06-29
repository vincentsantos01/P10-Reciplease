//
//  RecipeServiceTests.swift
//  P10-RecipleaseTests
//
//  Created by vincent santos on 02/06/2021.
//

import XCTest
@testable import P10_Reciplease

class RecipeServiceTests: XCTestCase { // recipeservicetest

    func testGetData_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipes(ingredientList: "coffee") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipes_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipes(ingredientList: "avocado") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipes method with incorrect response failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipes_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipes(ingredientList: "avocado") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getRecipes method with undecodable data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipes_WhenCorrectDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        let requestService = RecipeService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getRecipes(ingredientList: "avocado") { result in
            guard case .success(let data) = result else {
                XCTFail("Test getRecipes method with correct data failed.")
                return
            }
            XCTAssertTrue(data.hits[0].recipe.label == "Mashed Avocado")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
