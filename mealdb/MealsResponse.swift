//
//  WebService.swift
//  mealdb
//
//  Created by Ankit Mhatre on 3/21/24.
//

import Foundation






struct MealsResponse: Codable {
    let meals: [Meal]
}




struct Meal:  Identifiable , Codable {
    let id: UUID
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    
    init(id: UUID = UUID(), strMeal: String, strMealThumb: String, idMeal:String) {
           self.id = id
           self.strMeal = strMeal
           self.strMealThumb = strMealThumb
        self.idMeal = idMeal
           // Initialize other properties if any
       }
    
}

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}


class WebService: Codable {
    func downloadData<T: Codable>(fromURL: String) async -> T? {
        do {
            guard let url = URL(string: fromURL) else { throw NetworkError.badUrl }
            let (data, response) = try await URLSession.shared.data(from: url)
            print(data)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            print("Helloooooooooooo")
           
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
            return decodedResponse
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
        
        return nil
    }
}
