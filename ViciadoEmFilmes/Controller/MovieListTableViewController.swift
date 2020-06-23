//
//  MovieListTableViewController.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, MovieDetailsViewControllerDelegate {
    
    // MARK: Attributes
    
    var entryPoint:EntryPointType?
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50));
    var movies:Array<Movie> = []
    
    // MARK: LiveCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator()
        self.registratorCell()
        self.updateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: MovieDetailsViewControllerDelegate
    
    func removeMovie(id: Int) {
        if let index = self.movies.firstIndex(where: { (movie) -> Bool in
            return movie.id == id
        }) {
            self.movies.remove(at: index)
        }
    }
    
    // MARK: UI
    
    func registratorCell(){
        let nib = UINib(nibName: "MovieItemTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieItemTableViewCell")
    }
    
    func activityIndicator() {
        self.indicator.center = self.view.center
        self.indicator.hidesWhenStopped = true
        self.tableView.backgroundView = self.indicator
    }
    
    // MARK: UpdateData
    
    func updateData(){
        self.indicator.startAnimating()
        self.checkEntryPoint { (movies) in
            self.movies = movies
            self.tableView.reloadData()
            self.indicator.stopAnimating()
        }
    }
    
    func checkEntryPoint(_ completion: @escaping (_ movies:[Movie]) -> Void){
        let movieAPI = MovieAPI()
        switch self.entryPoint {
        case .mostRecent:
            movieAPI.getMostRecentMovies(completion)
            break
        case .popular:
            movieAPI.getPopularMovies(completion)
            break
        case .topRated:
            movieAPI.getTopRatedMovies(completion)
            break
        case .favorites:
            completion(FavoriteKeychain().restoreData())
        default:
            completion([])
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemTableViewCell", for: indexPath) as! MovieItemTableViewCell
        let movie = self.movies[indexPath.row]
        cell.populateCell(with: movie)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController:MovieDetailsViewController = storyboard.instantiateViewController(withIdentifier: "movieDetails") as! MovieDetailsViewController
        
        detailsViewController.movie = self.movies[indexPath.row]
        detailsViewController.delegate = self
        detailsViewController.title = "Detalhes"
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}
