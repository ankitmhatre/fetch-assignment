import SwiftUI

struct ContentView: View {
    @State private var meals: [Meal] = []
    
    
    var body: some View {
        NavigationView {
            List($meals, id: \.idMeal) { meal in
                VStack(alignment: .leading) {
                    Text(meal.strMeal.wrappedValue)
                        .font(.headline)
                 
                   
                        AsyncImage(url: meal.strMealThumb.wrappedValue)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    
                }
            }
            .navigationTitle("Meals")
        }
        .onAppear {
            fetchMeals( categoryName: "Dessert")
        }
    }
    
    func fetchMeals(categoryName :String) {
        var request = URLRequest(url: URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=" + categoryName)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error: \(String(describing: error))")
                return
            }
            
            do {
                let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.meals = mealsResponse.meals
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
