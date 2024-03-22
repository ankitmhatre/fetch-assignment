//
//  MealDetailsView.swift
//  mealdb
//
//  Created by Ankit Mhatre on 3/21/24.
//

import SwiftUI

struct MealDetailsView: View {
    let meal: Meal
    @State private var mealDetails: MealDetails?
    @State private var isLoading: Bool = false
    let numbers = Array(1...20)
    
    func openBrowser(sourceUrl: String) {
          guard let url = URL(string: sourceUrl) else { return }
          UIApplication.shared.open(url)
      }
    
    
    var body: some View {
        
        ScrollView {
         
                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    
                    
                   
                
                  
                    if let mealDetails = mealDetails {
                    
                    AsyncImage(url: meal.strMealThumb) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    VStack(alignment: .center){
                        Text(meal.strMeal)
                            .font(.largeTitle)
                           
                        Text(mealDetails.strCategory ?? "")
                            .font(.subheadline)
                            
                       
                    }
                    
                    // Display other details about the meal as needed
                   
                        Text("Instructions: \(mealDetails.strInstructions)")
                        Text("Ingredients:")
                                             .font(.headline)
                                             .padding(.bottom, 4)
                        VStack{
                        
                            ForEach(numbers, id: \.self) { i in
                                HStack{
                                    Text(mealDetails.ingredientAndMeasure(for: i)?.0 ?? "")
                                    Text(mealDetails.ingredientAndMeasure(for: i)?.1 ?? "")
                                }
                            }
                            
                            
                            
                        }
                        
                        // Display other details as needed
                        if mealDetails.strSource != nil{
                            Text("Source")
                                .font(.caption)
                                .onTapGesture {
                                    openBrowser(sourceUrl: mealDetails.strSource!)
                                }
                        }
                    }
                    
                 
                   
                
            }
        }
        .padding()
      
    
        .onAppear {
            fetchMealDetails()
        }
    }
    
    func fetchMealDetails() {
        isLoading = true
        
        let url :String  = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(meal.idMeal)";
        print(url)
        guard let url = URL(string:  url) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error: \(String(describing: error))")
                return
            }
            
            do {
                let mealDetailsResponse = try JSONDecoder().decode(MealsDetailsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.mealDetails = mealDetailsResponse.meals.first
                    self.isLoading = false
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

