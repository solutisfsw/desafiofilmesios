//
//  Genre.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit

class Genre:NSObject, NSCoding {
    let id: Int
    let name: String
    
    enum GenreSerialize: String{
        case id = "id"
        case name = "name"
    }
    
    init(id:Int, name:String){
        self.id = id
        self.name = name
    }
    
    // MARK: NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: Genre.self.GenreSerialize.id.rawValue)
        coder.encode(self.name, forKey: Genre.self.GenreSerialize.name.rawValue)
        
    }
    
    required init?(coder: NSCoder) {
        self.id = coder.decodeInteger(forKey: Genre.self.GenreSerialize.id.rawValue)
        self.name = coder.decodeObject(forKey: Genre.self.GenreSerialize.name.rawValue) as! String
    }
}
