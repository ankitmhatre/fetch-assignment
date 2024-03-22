//
//  WebService.swift
//  mealdb
//
//  Created by Ankit Mhatre on 3/21/24.
//

import Foundation






struct MealsResponse: Codable {
    var meals: [Meal]
}




struct Meal: Codable {
    var strMeal: String
    var strMealThumb: URL
    var idMeal: Int
    
    private enum CodingKeys: String, CodingKey {
        case strMeal, strMealThumb, idMeal
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(URL.self, forKey: .strMealThumb)
        
        // Decode idMeal as String and convert it to Int
        if let idMealString = try? container.decode(String.self, forKey: .idMeal),
           let idMealInt = Int(idMealString) {
            idMeal = idMealInt
        } else {
            // If conversion fails, set a default value or throw an error
            // For example, setting a default value of 0
            idMeal = 0
            // Or you can throw an error if conversion fails
            // throw DecodingError.dataCorruptedError(forKey: .idMeal, in: container, debugDescription: "Invalid idMeal value")
        }
    }
}



