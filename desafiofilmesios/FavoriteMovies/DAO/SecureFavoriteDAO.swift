//
//  SecureFavoriteDAO.swift
//  desafiofilmesios
//
//  Created by JR on 04/06/20.
//  Copyright © 2020 JR. All rights reserved.
//

import Foundation
import KeychainSwift

class SecureFavoriteDAO {
    let secureChain:KeychainSwift
    
    init() {
        self.secureChain = KeychainSwift()
        self.secureChain.accessGroup = "(AppIdentifierPrefix)home.desafiofilmesios"
    }
    
    func secureSaveMovie(movieID: String) {
        secureChain.set(movieID, forKey: "movieID")
        
    }
    
    func secureGetMovie() -> String? {
        if let movieID = secureChain.get("movieID"){
            return movieID
        }
        return nil
    }
    
    func secureRemoveMovie() -> Bool {
        return secureChain.delete("movieID")
    }
}
