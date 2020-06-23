//
//  Genre.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit

enum GenreSerialize: String{
    case id = "id"
    case name = "name"
}

class Genre:NSObject, NSCoding {
    let id: Int
    let name: String
    
    init(id:Int, name:String){
        self.id = id
        self.name = name
    }
    
    // MARK: NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: GenreSerialize.id.rawValue)
        coder.encode(self.name, forKey: GenreSerialize.name.rawValue)
        
    }
    
    required init?(coder: NSCoder) {
        self.id = coder.decodeObject(forKey: GenreSerialize.id.rawValue) as! Int
        self.name = coder.decodeObject(forKey: GenreSerialize.name.rawValue) as! String
    }
}
