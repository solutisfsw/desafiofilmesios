//
//  Genre.swift
//  desafiofilmesios
//
//  Created by JR on 04/06/20.
//  Copyright © 2020 JR. All rights reserved.
//

import Foundation

class Genre: Codable {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
