//
//  FavoriteMoviesViewController.swift
//  desafiofilmesios
//
//  Created by JR on 25/05/20.
//  Copyright © 2020 JR. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteMoviesViewController: UIViewController {

    // MARK: - ATRIBUTES
    let client = MovieClient()
    let favoritesSecureDAO = SecureFavoriteDAO()
    var movieId = 0
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var posterImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var yearLabel: UILabel?
    @IBOutlet weak var favImageView: UIImageView?
    @IBOutlet weak var genLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    // MARK: - VIEW LIFE CYCLE
    init(movieId: String) {
        super.init(nibName:"FavoriteMoviesView", bundle: nil)
        
        client.getMovieDetail(movieId) { (result: Movie?) in
            if let movie = result {
                self.movieId = movie.id
                
                self.titleLabel?.text = movie.title
                
                let format = DateFormatter()
                format.dateFormat = "YYYY-MM-dd"
                if let date = format.date(from: movie.releaseDate){
                    format.dateFormat = "YYYY"
                    self.yearLabel?.text = format.string(from: date)
                }
                
                if let genres = movie.genres, let lastGen = genres.last {
                    var genreLabel = ""
                    for genre in genres {
                        if(genre.id == lastGen.id){
                            genreLabel += "\(genre.name)"
                            
                        }
                        else {
                            genreLabel += "\(genre.name) - "
                        }
                    }
                    self.genLabel?.text = genreLabel
                }
                
                self.descriptionLabel?.text = movie.overview
                
                self.favImageView?.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(self.setFavMovie(_:))))
                
                if let posterPath = movie.posterPath {
                    self.posterImageView?.contentMode = .scaleAspectFit
                    self.posterImageView?.sd_setImage(with: URL(string: "\(self.client.imageUrl)\(posterPath)"), placeholderImage: UIImage(named: posterPath))
                    
                }
                
                if self.favoritesSecureDAO.secureGetMovie() == String(movie.id) {
                    self.loadStarImage(true)
                }
                else {
                    self.loadStarImage(false)
                }
            }
            else {
                self.showAlert(title: "Erro", message: "Ocorreu um erro ao tentar obter o filme.")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - ACTIONS
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func setFavMovie(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .began {
            
            if let secureId = favoritesSecureDAO.secureGetMovie() {
                if(String(self.movieId) == secureId) {
                    loadStarImage(false)
                    favoritesSecureDAO.secureRemoveMovie()
                    showAlert(title: "Info", message: "Filme favorito removido.")
                }
            }
            else {
                favoritesSecureDAO.secureSaveMovie(movieID: String(self.movieId))
                loadStarImage(true)
                showAlert(title: "Info", message: "Filme favorito adicionado.")
            }
        }
    }
    
    private func loadStarImage(_ fav: Bool){
        if fav {
            self.favImageView?.sd_setImage(with: nil, placeholderImage: UIImage(named: "star_filled"))
        }
        else {
            self.favImageView?.sd_setImage(with: nil, placeholderImage: UIImage(contentsOfFile: "star"))
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
