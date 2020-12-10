//
//  NewTranslateManager.swift
//  TasteApp
//
//  Created by Anna Oksanichenko on 01.12.2020.
//

import Foundation

public enum Language: String {
    case russian = "ru"
    case english = "en"
    case empty = "empty"
}

struct CreatingURLManager {
    
    func createURLComponents(text: String, targetLang: Language, sourseLang: Language) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "translate.googleapis.com"
        urlComponents.path = "/translate_a/single"
        urlComponents.queryItems = [
            URLQueryItem(name: "client", value: "gtx"),
            URLQueryItem(name: "sl", value: sourseLang.rawValue),
            URLQueryItem(name: "tl", value: targetLang.rawValue ),
            URLQueryItem(name: "dt", value: "t"),
            URLQueryItem(name: "q", value: text) ]
        let urlString = urlComponents.url?.absoluteURL
        return urlString
        
    }
}