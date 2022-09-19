//
//  NetworkManager.swift
//  Cocktail recipes app
//
//  Created by Artem Lugynets on 07.09.2022.
//

import Foundation

protocol NetworkManagerType: AnyObject, Service {
    func fetchCategories(completion: @escaping (_ drinks: Categories) -> Void)
    func fetchIngredients(completion: @escaping (_ drinks: Ingredients) -> Void)
    func fetchDrinkDetails(for id: String, completion: @escaping (_ list: CocktailDetails) -> Void)
    func fetchImage(from url: URL, completion: @escaping (_ data: Data) -> Void) -> URLSessionDataTask?
    func fetchList(for category: String, completion: @escaping (_ list: CocktailsList) -> Void)
    func fetchIngredientList(for ingredient: String, completion: @escaping (_ list: CocktailsList) -> Void)
    func fetchSearchText(for text: String, from url: ApiUrl, completion: @escaping (_ list: CocktailSearch) -> Void)
}

class NetworkManager: NetworkManagerType {
    
private var imageCache = NSCache<NSString, NSData>()

func fetchCategories(completion: @escaping (_ drinks: Categories) -> Void) {
    guard let url = URL(string: ApiUrl.categories.rawValue) else {
        print("No URL")
        return
    }
    fetchModels(from: url, in: completion)
}

func fetchIngredients(completion: @escaping (_ drinks: Ingredients) -> Void) {
    guard let url = URL(string: ApiUrl.ingredients.rawValue) else {
        print("No URL")
        return
    }
    fetchModels(from: url, in: completion)
}

func fetchList(for category: String, completion: @escaping (_ list: CocktailsList) -> Void) {
    let urlString = ApiUrl.list.rawValue + category
    let newUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    guard let url = URL(string: newUrl) else {
        print("No URL")
        return
    }
    fetchModels(from: url, in: completion)
}

func fetchIngredientList(for ingredient: String, completion: @escaping (_ list: CocktailsList) -> Void) {
    let urlString = ApiUrl.listForIngredient.rawValue + ingredient
    let newUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    guard let url = URL(string: newUrl) else {
        print("No URL")
        return
    }
    fetchModels(from: url, in: completion)
}

func fetchDrinkDetails(for id: String, completion: @escaping (_ list: CocktailDetails) -> Void) {
    guard let url = URL(string: ApiUrl.detail.rawValue + id) else {
        print("No detail URL")
        return
    }
    fetchModels(from: url, in: completion)
}

func fetchImage(from url: URL, completion: @escaping (_ data: Data) -> Void) -> URLSessionDataTask? {
    
    var task: URLSessionDataTask?
    task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data else {
            print(error?.localizedDescription ?? "No error description")
            return
        }
        self.imageCache.setObject(NSData(data: data), forKey: url.absoluteString as NSString)
        DispatchQueue.main.async {
            completion(data)
        }
    }
    
    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
        let data = cachedImage as Data
        task = nil
        completion(data)
    } else {
        if let task = task {
            task.resume()
        }
    }
    return task
}

func fetchDrinksByIds(from ids: [Int], completion: @escaping (_ drinks: [CocktailDetails]) -> Void) {
    var details: [CocktailDetails] = []
    for id in ids {
        fetchDrinkDetails(for: String(id)) { detail in
            if details.count == (ids.count - 1) {
                details.append(detail)
                completion(details)
            } else {
                details.append(detail)
            }
        }
    }
}

func fetchSearchText(for text: String, from url: ApiUrl, completion: @escaping (_ list: CocktailSearch) -> Void) {
    guard let url = URL(string: url.rawValue + text) else {
        print("No detail URL")
        return
    }
    fetchModels(from: url, in: completion)
}

private func fetchModels<T: Decodable>(from url: URL, in completion: @escaping ((T) -> Void)) {
    URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data else {
            print(error?.localizedDescription ?? "No description")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)
            DispatchQueue.main.async {
                completion(model)
            }
        }
        catch {
            print("decode error")
        }
    }.resume()
}

    init() {}
}
