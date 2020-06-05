//
//  PopularMoviesViewController.swift
//  desafiofilmesios
//
//  Created by JR on 25/05/20.
//  Copyright © 2020 JR. All rights reserved.
//

import UIKit
import SDWebImage

class PopularMoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - ATTRIBUTES
    var movies: [Movie] = Array<Movie>()
    let client = MovieClient()
    
    //  MARK: - IBOUTLETS
    @IBOutlet weak var popularTableView: UITableView?
    
    // MARK: - VIEW LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        popularTableView?.dataSource = self
        popularTableView?.delegate = self
        
        client.getPopularMovies() { (result: [Movie]) in
            self.movies.append(contentsOf: result)
            self.popularTableView?.reloadData()
        }
    }
    
    // MARK: - TABLE VIEW METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMoviesTableViewCell", for: indexPath) as! PopularMoviesTableViewCell
        
        let movie = movies[indexPath.row]
        
        cell.movieTitleLabel?.text = movie.title
        cell.movieDescriptionLabel?.text = movie.overview
        if let posterPath = movie.posterPath {
             cell.imageView?.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
             cell.imageView?.sd_setImage(with: URL(string: "\(self.client.imageUrl)\(posterPath)"), placeholderImage: UIImage(named: posterPath))
             cell.imageView?.contentMode = .scaleToFill
             
         }
               
        cell.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(showDetails(_:))))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176
    
    }
    
    @objc func showDetails(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .began {
            let cell = gesture.view as! UITableViewCell
            
            guard let indexPath = popularTableView?.indexPath(for: cell) else { return }
            
            let movieId = movies[indexPath.row].id
            
            showFavView(String(movieId))
        }
    }
    
    @objc func showFavView(_ movieId: String){
        let favView  = FavoriteMoviesViewController(movieId: movieId)
        navigationController?.pushViewController(favView, animated: true)
    }
}
