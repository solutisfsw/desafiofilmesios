//
//  MovieDetailsViewController.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit
import Nuke

protocol MovieDetailsViewControllerDelegate {
    func removeMovie(id:Int)
}

class MovieDetailsViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: Attributes
    
    let favoriteKeychain = FavoriteKeychain()
    var delegate:MovieDetailsViewControllerDelegate?
    var movie:Movie?
    
    // MARK: @IBOutlet
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: @IBAction
    
    @IBAction func favoriteButtonTouch(_ sender: Any) {
        self.toggleFavorite()
        self.checkFavorite()
    }
    
    @IBAction func backButtonTouch(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: LiveCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        self.populateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.layout()
    }
    
    // MARK: UI
    
    func layout(){
        self.checkFavorite()
    }
    
    // MARK: Data
    
    func populateData(){
        guard let movie = self.movie else { return }
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy"
        self.titleLabel.text = movie.title
        self.releaseDateLabel.text = formatterDate.string(from: movie.releaseDate)
        self.descriptionTextView.text = movie.text
        let genresArr = movie.genres.map { (genre) -> String in
            return genre.name
        }
        self.genresLabel.text = genresArr.joined(separator: ", ")
        if let imageURL:URL = URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2\(movie.image)") {
            let options = ImageLoadingOptions(
                transition: .fadeIn(duration: 0.5)
            )
            Nuke.loadImage(with: imageURL, options: options, into: self.thumbImageView)
        }
    }
    
    func toggleFavorite(){
        guard let movie = self.movie else { return }
        if self.favoriteKeychain.getBy(id: movie.id) != nil {
            if(self.favoriteKeychain.removeOfFavorite(with: movie.id)) {
                self.delegate?.removeMovie(id: movie.id)
            }
        }else{
            self.favoriteKeychain.addToFavorite(movie: movie)
        }
    }
    
    func checkFavorite(){
        guard let movie = self.movie else { return }
        if self.favoriteKeychain.getBy(id: movie.id) != nil {
            guard let image = UIImage(named: "star.fill") else { return }
            self.favoriteButton.setImage(image, for: .normal)
        }else {
            guard let image = UIImage(named: "star") else { return }
            self.favoriteButton.setImage(image, for: .normal)
        }
    }

}
