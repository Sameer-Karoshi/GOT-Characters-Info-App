//
//  GOTCharactersViewModel.swift
//  GOT-Characters-Info
//
//  Created by Sameer Karoshi on 25/05/23.
//

import Foundation
import UIKit

class ThronesCharacterViewModel {
    
    // MARK: - Constant
    
    public static var thronesCharacterArray: [ThronesCharacter] = []
    
    // MARK: - Networking
    
    public static func fetchThronesCharacterUsingJSON(completion: @escaping (_ data: String) -> Void) {
        guard let urlString = URL(string: "https://thronesapi.com/api/v2/Characters") else {
            completion("Error!")
            print("Failed to get URL!")
            return
        }
        
        let request = URLRequest(url: urlString)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.global(qos: .background).async {
                if error != nil {
                    completion("Error!")
                    print("Error!")
                    return
                }
                guard let data = data else {
                    completion("Error!")
                    print("Failed to get the data!")
                    return
                }
                
                do {
                    thronesCharacterArray = try JSONDecoder().decode([ThronesCharacter].self, from: data)
                    completion("Success!")
                    print("Success!")
                } catch {
                    print("Error!")
                    return
                }
            }
        }.resume()
    }
    
    public static func loadThronesCharacterImageUsingStringURL(_ urlString: String, completion: ((_ image: UIImage?) -> ())?) {
        guard let url = URL(string: urlString) else {
            completion?(nil)
            print("Failed to get URL!")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response,error) in
            DispatchQueue.global(qos: .background).async {
                if error != nil {
                    completion?(nil)
                    print("Error!")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    completion?(image)
                    print("Success!")
                }
                print("Failed to get data!")
                completion?(nil)
                return
            }
        }.resume()
    }
    
    public static func updateThronesCharacterAPI(_ thronesCharacterObject: ThronesCharacter, completion: @escaping (_ data: String) -> Void) {
        guard let urlString = URL(string: "https://thronesapi.com/api/v2/Characters") else {
            completion("Error!")
            print("Failed to get URL!")
            return
        }
        
        do {
            var request = URLRequest(url: urlString)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(thronesCharacterObject)
            
            URLSession.shared.dataTask(with: request) { data, response,_ in
                DispatchQueue.global(qos: .background).async {
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        return
                    }
                    completion("Success!")
                    print("Success!")
                }
            }.resume()
        } catch {
            print("Error!")
            completion("Error!")
            return
        }
    }
}
