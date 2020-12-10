//
//  NetworkManager.swift
//  TasteApp
//
//  Created by Anna Oksanichenko on 24.11.2020.
//

import Foundation

struct GoogleTranslateAPIManager {
    
    enum GoogleTranslateAPIError: Error {
            case noData
            case cantCreateURL
            case unknownError(Error)
        }
    
    var createdUrl = CreatingURLManager()
    
    func translate(text: String, targetLang: Language, sourceLang: Language, completionHandler: @escaping (Result<Translation, GoogleTranslateAPIError>) -> Void ) {
        
        guard let url = createdUrl.createURLComponents(text: text, targetLang: targetLang, sourseLang: sourceLang) else { return }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            do {
                let responseModel = try JSONDecoder().decode(Translation.self, from: data)
                completionHandler(.success(responseModel))
                
            } catch {
                print("can't find a translation, error: \(error)")
                completionHandler(.failure(.unknownError(error)))
            }
        }
        task.resume()
    }
}