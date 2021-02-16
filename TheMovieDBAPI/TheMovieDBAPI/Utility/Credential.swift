//
//  Credential.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import Foundation

class Credential {
    static private(set) var API : String = ""
    static private(set) var BaseURL: String = ""
    static func readValues() {
        if let url = Bundle.main.url(forResource: "Keys", withExtension: "json") {
            do {
                let keysData = try JSONDecoder().decode(Keys.self, from: Data(contentsOf: url))
                API = keysData.Keys.API
                BaseURL = keysData.Keys.BaseURL
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
