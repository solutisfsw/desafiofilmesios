//
//  Movie.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit

enum MovieSerialize: String {
    case id = "id"
    case title = "title"
    case text = "text"
    case image = "image"
    case releaseDate = "releaseDate"
    case genres = "genres"
}

class Movie:NSObject, NSCoding {
    let id:Int
    let title:String
    let text:String
    let image:String
    let releaseDate:Date
    let genres:Array<Genre>
    
    init(id:Int, title:String, text:String, image:String, releaseDate:Date, genres:Array<Genre>){
        self.id = id
        self.title = title
        self.text = text
        self.image = image
        self.genres = genres
        self.releaseDate = releaseDate
    }
    
    // MARK: NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: MovieSerialize.id.rawValue)
        coder.encode(self.title, forKey: MovieSerialize.title.rawValue)
        coder.encode(self.text, forKey: MovieSerialize.text.rawValue)
        coder.encode(self.image, forKey: MovieSerialize.image.rawValue)
        coder.encode(self.releaseDate, forKey: MovieSerialize.releaseDate.rawValue)
        coder.encode(self.genres, forKey: MovieSerialize.genres.rawValue)
    }
    
    required init?(coder: NSCoder) {       
        self.id = coder.decodeObject(forKey: MovieSerialize.id.rawValue) as! Int
        self.title = coder.decodeObject(forKey: MovieSerialize.title.rawValue) as! String
        self.text = coder.decodeObject(forKey: MovieSerialize.text.rawValue) as! String
        self.image = coder.decodeObject(forKey: MovieSerialize.image.rawValue) as! String
        self.releaseDate = coder.decodeObject(forKey: MovieSerialize.releaseDate.rawValue) as! Date
        self.genres = coder.decodeObject(forKey: MovieSerialize.genres.rawValue) as! Array<Genre>
    }
}
