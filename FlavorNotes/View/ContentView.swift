//
//  ContentView.swift
//  FlavorNotes
//
//  Created by 王嵩允 on 11/9/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $viewModel.searchText)
                
                List {
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.headline)
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else if viewModel.filteredRecipes.isEmpty {
                        Text("Recipe is Empty...")
                            .font(.title)
                            .foregroundStyle(.gray)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    } else {
                        ForEach(viewModel.filteredRecipes) { recipe in
                            RecipeRow(recipe: recipe)
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .refreshable {
                viewModel.fetchRecipes()
            }
        }
        .onAppear {
            viewModel.fetchRecipes()
        }
    }
}


struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        TextField("Search recipes...", text: $searchText)
            .padding(6)
            .background(Color(.systemGray5))
            .cornerRadius(4)
            .overlay(
                HStack {
                    Spacer()
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal)
    }
}


struct RecipeRow: View {
    let recipe: Recipe
    @State private var showActionSheet = false
    
    private func openExternalLink(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    var body: some View {
        HStack {
            if let smallPhoto = recipe.photoURLSmall {
                KFImage(URL(string: smallPhoto))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
                    .padding(.trailing)
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 8)
            
            Spacer()
            
            Button {
                showActionSheet = true
            } label: {
                Text("...")
                    .foregroundStyle(.gray)
            }
            .confirmationDialog("Choose an option", isPresented: $showActionSheet) {
                if let youtubeURL = recipe.youtubeURL, !youtubeURL.isEmpty {
                    Button("Watch on Youtube") {
                        openExternalLink(URL(string: youtubeURL)!)
                    }
                }
                
                if let sourceURL = recipe.sourceURL, !sourceURL.isEmpty {
                    Button("Visit on source page") {
                        openExternalLink(URL(string: sourceURL)!)
                    }
                }
                
                Button("Cancel", role: .cancel) {}
            }

        }
    }
}


#Preview {
    ContentView()
}
