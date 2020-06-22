//
//  Movie.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit

class Movie {
    let id:Int
    let title:String
    let description:String
    let image:String
    let releaseDate:String
    let genres:[Genre]
    
    init(id:Int, title:String, description:String, image:String, releaseDate:String, genres:[Genre]){
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.genres = genres
        self.releaseDate = releaseDate
    }
}
