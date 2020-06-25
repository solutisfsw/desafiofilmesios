//
//  Movie.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit


class Movie: NSCoding {
    let id:Int
    let title:String
    let text:String
    let image:String
    let releaseDate:Date
    let genres:Array<Genre>
    
    enum MovieSerialize: String {
        case id = "id"
        case title = "title"
        case text = "text"
        case image = "image"
        case releaseDate = "releaseDate"
        case genres = "genres"
    }
    
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
        coder.encode(self.id, forKey: Movie.self.MovieSerialize.id.rawValue)
        coder.encode(self.title, forKey: Movie.self.MovieSerialize.title.rawValue)
        coder.encode(self.text, forKey: Movie.self.MovieSerialize.text.rawValue)
        coder.encode(self.image, forKey: Movie.self.MovieSerialize.image.rawValue)
        coder.encode(self.releaseDate, forKey: Movie.self.MovieSerialize.releaseDate.rawValue)
        coder.encode(self.genres, forKey: Movie.self.MovieSerialize.genres.rawValue)
    }
    
    required init?(coder: NSCoder) {
        self.id = coder.decodeInteger(forKey: Movie.self.MovieSerialize.id.rawValue)
        self.title = coder.decodeObject(forKey: Movie.self.MovieSerialize.title.rawValue) as! String
        self.text = coder.decodeObject(forKey: Movie.self.MovieSerialize.text.rawValue) as! String
        self.image = coder.decodeObject(forKey: Movie.self.MovieSerialize.image.rawValue) as! String
        self.releaseDate = coder.decodeObject(forKey: Movie.self.MovieSerialize.releaseDate.rawValue) as! Date
        self.genres = coder.decodeObject(forKey: Movie.self.MovieSerialize.genres.rawValue) as! Array<Genre>
    }
}
