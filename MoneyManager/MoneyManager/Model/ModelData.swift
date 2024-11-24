//
//  ModelData.swift
//  MoneyManager
//
//  Created by Иван Кретов on 23.11.2024.
//

import Foundation


class ModelData: ObservableObject {
    @Published var categories: [Category] = load("CategoryData.json")
    
    var totalIncome: Int {
        categories.reduce(0) { $0 + $1.income }
    }
        
    var totalExpenses: Int {
        categories.reduce(0) { $0 + $1.expenses }
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
