//
//  Genre.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit

class Genre: NSObject {
    let id: Int
    let name: String
    
    init(id:Int, name:String){
        self.id = id
        self.name = name
    }
}
