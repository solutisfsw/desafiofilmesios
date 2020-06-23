//
//  MovieListTableViewController.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    var entryPoint:EntryPointType?
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50));
    var movies:[Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        self.activityIndicator()
        self.registratorCell()
        self.updateData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: UI
    
    func layout(){
         self.navigationController?.navigationBar.topItem?.title = "Viciados em filmes"
    }
    
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
    
    func checkEntryPoint(_ completion:@escaping (_ movies:[Movie]) -> Void){
        let movieAPI = MovieAPI()
        switch entryPoint {
        case .mostRecent:
            movieAPI.getMostRecentMovies(completion)
            break
        case .popular:
            movieAPI.getPopularMovies(completion)
            break
        case .topRated:
            movieAPI.getTopRatedMovies(completion)
            break
        default:
            completion([])
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
