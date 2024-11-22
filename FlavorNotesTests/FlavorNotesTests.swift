//
//  FlavorNotesTests.swift
//  FlavorNotesTests
//
//  Created by 王嵩允 on 11/9/24.
//

import XCTest
@testable import FlavorNotes

class RecipeViewModelTests: XCTestCase {
    
    func testFetchRecipesSuccessful() {
        let viewModel = RecipeViewModel()
        let mockDataCount = 63
        let mockURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
        
        let expectation = self.expectation(description: "Fetch recipes completion")
            
        viewModel.fetchRecipes(mockURL)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertEqual(viewModel.recipes.count, mockDataCount)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchRecipesMalformedData() {
        let viewModel = RecipeViewModel()
        let mockURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        
        let expectation = self.expectation(description: "Fetch recipes completion")
            
        viewModel.fetchRecipes(mockURL)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertEqual(viewModel.errorMessage, "Could not decode recipes!")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}

