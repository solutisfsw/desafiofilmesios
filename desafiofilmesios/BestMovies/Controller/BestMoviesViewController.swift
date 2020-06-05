//
//  BestMoviesViewController.swift
//  desafiofilmesios
//
//  Created by JR on 25/05/20.
//  Copyright © 2020 JR. All rights reserved.
//

import UIKit
import SDWebImage

class BestMoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - ATTRIBUTES
    var movies: [Movie] = Array<Movie>()
    let client = MovieClient()
    
    //  MARK: - IBOUTLETS
    @IBOutlet weak var BestMoviesTableView: UITableView?
    
    // MARK: - VIEW LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        BestMoviesTableView?.dataSource = self
        BestMoviesTableView?.delegate = self
        
        client.getBestMovies(){ (result: [Movie]) in
            self.movies.append(contentsOf: result)
            self.BestMoviesTableView?.reloadData()
        }
    }
    
    // MARK: - TABLE VIEW METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestMoviesTableViewCell", for: indexPath) as! BestMoviesTableViewCell
        
        let movie = movies[indexPath.row]
        
        if let posterPath = movie.posterPath {
            cell.imageView?.contentMode = .scaleAspectFit
            cell.imageView?.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.imageView?.sd_setImage(with: URL(string: "\(self.client.imageUrl)\(posterPath)"), placeholderImage: UIImage(named: posterPath))
            
        }
        
        cell.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(showDetails(_:))))
        
        cell.titleLabel?.text = movie.title
        cell.descriptionLabel?.text = movie.overview
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176
    }
    
    @objc func showDetails(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .began {
            let cell = gesture.view as! UITableViewCell
            
            guard let indexPath = BestMoviesTableView?.indexPath(for: cell) else { return }
            
            let movieId = movies[indexPath.row].id
            
            showFavView(String(movieId))
        }
    }
    
    @objc func showFavView(_ movieId: String){
        let favView  = FavoriteMoviesViewController(movieId: movieId)
        navigationController?.pushViewController(favView, animated: true)
    }
}
