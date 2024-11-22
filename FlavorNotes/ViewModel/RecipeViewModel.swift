//
//  RecipeViewModel.swift
//  FlavorNotes
//
//  Created by 王嵩允 on 11/21/24.
//

import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var searchText = ""
    @Published var errorMessage: String?
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func fetchRecipes(_ urlStr: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") {
        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received!"
                }
                return
            }
            
            do {
                let decodedWrapper = try JSONDecoder().decode(RecipeWrapper.self, from: data)
                DispatchQueue.main.async {
                    self.recipes = decodedWrapper.recipes
                    self.errorMessage = nil
                }
            } catch {
                DispatchQueue.main.async {
                    self.recipes = []
                    self.errorMessage = "Could not decode recipes!"
                }
            }
        }.resume()
    }
}
