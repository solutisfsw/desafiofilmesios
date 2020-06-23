//
//  FavoriteKeychain.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 23/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit
import KeychainSwift

class FavoriteKeychain {
    static private let keychain = KeychainSwift()
    static private var favorites:Array<Movie> = []
    let key = "favorites"
    
    func addToFavorite(movie:Movie) -> Bool{
        FavoriteKeychain.favorites = self.restoreData()
        FavoriteKeychain.favorites.append(movie)
        return self.save()
    }
    
    func removeOfFavorite(with id:Int) -> Bool{
        FavoriteKeychain.favorites = self.restoreData()
        if let index = FavoriteKeychain.favorites.firstIndex(where: { (movie) -> Bool in
            return movie.id == id
        }) {
            FavoriteKeychain.favorites.remove(at: index)
            return self.save()
        }
        return false
    }
    
    func getBy(id: Int) -> Movie? {
        FavoriteKeychain.favorites = self.restoreData()
        return FavoriteKeychain.favorites.first { (movie) -> Bool in
            return movie.id == id
        }
    }
    
    func restoreData() -> Array<Movie>{
        //        if (FavoriteKeychain.favorites.count > 0){
        //            return FavoriteKeychain.favorites
        //        }
        guard let datas = FavoriteKeychain.keychain.getData(self.key) else {
            print("Não foi possível recuperar os dados")
            return []
        }
        do{
            guard let data:Array<Movie> = try NSKeyedUnarchiver.unarchiveObject(with: datas) as? Array<Movie> else {
                print("Não foi possível converter os dados")
                return []
            }
            return data
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    private func save() -> Bool{
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: FavoriteKeychain.favorites)
            return FavoriteKeychain.keychain.set(data, forKey: self.key)
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
}
