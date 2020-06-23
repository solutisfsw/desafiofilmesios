//
//  MovieAPI.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit
import Alamofire

enum EntryPointType {
    case details(Int)
    case popular, topRated, mostRecent, genre, favorites
    
    var value: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .mostRecent:
            return "/movie/upcoming"
        case .genre:
            return "/genre/movie/list"
        case .details(let id):
            return "/movie/\(String(id))"
        default:
            return ""
        }
    }
}


class MovieAPI {
    
    // MARK: Attributes
    
    let apiURL:String = "https://api.themoviedb.org/3"
    let parameters: Parameters = [
        "api_key": "75ed1e7aae9c47fa45678043bba275c3",
        "language": "pt-BR"
    ]
    private static var genres:[Genre] = []
    
    init(){
        self.getGenres()
    }
    
    // MARK: Methods
    
    private func getGenres(){
        if MovieAPI.genres.count == 0 {
            self.requestAPI(urlType: EntryPointType.genre) { (data: Dictionary<String, Any>?) in
                guard let dic = data, let genresDic = dic["genres"] as? Array<Dictionary<String, Any>> else { return }
                for genreDic in genresDic {
                    if let genre = self.populateGenre(genreDic: genreDic) {
                        MovieAPI.genres.append(genre)
                    }
                }
            }
        }
    }
    
    // MARK: API Request Methods
    
    func getPopularMovies(_ completion: @escaping (_ movies: [Movie]) -> Void ){
        self.getListMovies(entryPoint: EntryPointType.popular, completion: completion)
    }
    
    func getTopRatedMovies(_ completion: @escaping (_ movies: [Movie]) -> Void ){
        self.getListMovies(entryPoint: EntryPointType.topRated, completion: completion)
    }
    
    func getMostRecentMovies(_ completion: @escaping (_ movies: [Movie]) -> Void ){
        self.getListMovies(entryPoint: EntryPointType.mostRecent, completion: completion)
    }

    func getDetailsMovie(id:Int, _ completion: @escaping (_ movies: Movie?) -> Void ){
        self.requestAPI(urlType: EntryPointType.details(id)) { (data) in
            var movie:Movie?
            guard let dic = data else { completion(movie); return }
            movie = self.populateMovie(movieDic: dic)
            completion(movie)
        }
    }
    
    
    // MARK: Populate Data
    
    private func populateMovie(movieDic: Dictionary<String, Any>) -> Movie? {
        guard let genresId = movieDic["genre_ids"] as? Array<Int> else { return nil }
        let genres = MovieAPI.genres.filter { (genre) -> Bool in
            return genresId.contains(genre.id)
        }
        guard let id = movieDic["id"] as? Int else { return nil }
        guard let title = movieDic["title"] as? String else { return nil }
        guard let overview = movieDic["overview"] as? String else { return nil }
        guard let release_date = movieDic["release_date"] as? String else { return nil }
        guard let poster_path = movieDic["poster_path"] as? String else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return Movie(
            id: id,
            title: title,
            text: overview,
            image: poster_path,
            releaseDate: formatter.date(from: release_date)!,
            genres: genres
        )
    }
    
    private func populateGenre(genreDic:Dictionary<String, Any>) -> Genre? {
        guard let id = genreDic["id"] as? Int else { return nil }
        guard let name = genreDic["name"] as? String else { return nil }
        return Genre(id: id, name: name)
    }
    
    // MARK: API Request Generic
    
    private func getListMovies(entryPoint:EntryPointType, completion: @escaping ([Movie])->Void) {
        self.getArrayOfResults(urlType: entryPoint) { (dataArr) in
            var movies:[Movie] = []
            for movieDic in dataArr {
                if let movie = self.populateMovie(movieDic: movieDic){
                    movies.append(movie)
                }
            }
            completion(movies)
        }
    }
    
    private func getArrayOfResults(urlType: EntryPointType, _ completion: @escaping (_ dataArr:Array<Dictionary<String, Any>>) -> Void) -> Void{
        self.requestAPI(urlType: urlType) { (response) in
            guard let dataDic = response, let dataArr = dataDic["results"] as?  Array<Dictionary<String, Any>> else { completion([]); return; }
            completion(dataArr)
        }
    }
    
    private func requestAPI(urlType: EntryPointType, completion: @escaping (Dictionary<String, Any>?) -> Void){
        guard let url:URL = URL(string: "\(self.apiURL)\(urlType.value)") else {
            completion(nil)
            return
        }
        
        Alamofire.request(url, method: .get, parameters: parameters).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.result.value as? Dictionary<String, Any>{
                    completion(data)
                }else{
                    completion(nil)
                }
                break
            case .failure:
                if let error = response.error {
                    debugPrint(error)
                }
                completion(nil)
                break
            }
        }
    }
    
}
