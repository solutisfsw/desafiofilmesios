import Foundation
import Alamofire
import AlamofireSpinner
import CoreData

class MovieClient: NSObject {
    
    private let url = "https://api.themoviedb.org/3/movie"
    private let urlParameters = "?api_key=60e59035b921b9adb603ca91e01652e6&language=pt-BR"
    let imageUrl = "https://image.tmdb.org/t/p/w500"
    
    func getPopularMovies (completion: @escaping (_ result: [Movie]) -> Void) {
        guard let popularUrl = URL(string: "\(url)/popular\(urlParameters)") else {
            return
        }
        
        getMoviesList(popularUrl){ (result: [Movie]) in
            completion(result)
        }
    }
    
    func getBestMovies (completion: @escaping (_ result: [Movie]) -> Void) {
        guard let bestUrl = URL(string: "\(url)/top_rated\(urlParameters)") else {
            return
        }
        
        getMoviesList(bestUrl){ (result: [Movie]) in
            completion(result)
        }
    }
    
    func getMostRecentMovies (completion: @escaping (_ result: [Movie]) -> Void) {
        guard let mostRecentUrl = URL(string: "\(url)/upcoming\(urlParameters)") else {
            return
        }
        
        getMoviesList(mostRecentUrl){ (result: [Movie]) in
            completion(result)
        }
    }
    
    func getMovieDetail (_ movieId: String, completion: @escaping (_ result: Movie?) -> Void) {
        guard let movieDetailURL = URL(string: "\(url)/\(movieId)\(urlParameters)") else {
            return
        }
        
        getMovieDetail(movieDetailURL){ (result: Movie?) in
            completion(result)
        }
    }
    
    private func getMoviesList<Movie:Decodable>(_ url: URL, completion: @escaping (_ result: [Movie]) -> Void) {
        var moviesList = Array<Movie>()
        
        Alamofire.request(url, method: .get).validate().spin().responseJSON() { (response) -> Void in
            switch response.result {
                case .success:
                    if let responseValue = response.result.value as? Dictionary<String, Any> {
                        guard let moviesDict = responseValue["results"] as? Array<Dictionary<String, Any>> else { return }
                        do {
                            let moviesJSON = try JSONSerialization.data(withJSONObject: moviesDict)
                            let resultsList = try JSONDecoder().decode([Movie].self, from: moviesJSON)
                            
                            moviesList.append(contentsOf: resultsList)
                            completion(moviesList)
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
                    break
                
                case .failure:
                    print("Ops! algo deu errado")
                    break
            
            }
        }
    }
    
    private func getMovieDetail (_ url: URL, completion: @escaping (_ result: Movie?) -> Void) {
        var movieDetail: Movie? = nil
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            switch response.result {
                case .success:
                    if let responseValue = response.result.value as? Dictionary<String, Any> {
                        
                        do {
                            let movieJSON = try JSONSerialization.data(withJSONObject: responseValue, options: .prettyPrinted)
                            movieDetail = try JSONDecoder().decode(Movie.self, from: movieJSON)
                            completion(movieDetail)
                        }
                        catch {
                            print("Ops! algo deu errado")
                        }
                    }
                    break
                
                case .failure:
                    print("Ops! algo deu errado")
                    break
                }
        }
    }
}
