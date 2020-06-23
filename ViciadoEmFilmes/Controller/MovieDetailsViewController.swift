//
//  MovieDetailsViewController.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit
import Nuke

class MovieDetailsViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: Attributes
    let favoriteKeychain = FavoriteKeychain()
    
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
    
    // MARK: Attributes
    
    var movie:Movie?
    
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController = self.navigationController else { return false }
        if (navigationController.viewControllers.count > 1) {
            return true;
        }
        return false;
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
            self.favoriteKeychain.removeOfFavorite(with: movie.id)
        }else{
            self.favoriteKeychain.addToFavorite(movie: movie)
        }
    }
    
    func checkFavorite(){
        guard let movie = self.movie else { return }
        var image:UIImage = UIImage()
        if self.favoriteKeychain.getBy(id: movie.id) != nil {
            if #available(iOS 13.0, *) {
                image = UIImage(systemName: "star.fill")!
            } else {
                // Fallback on earlier versions
            }
            self.favoriteButton.setImage(image, for: .normal)
        }else {
            if #available(iOS 13.0, *) {
                image = UIImage(systemName: "star")!
            } else {
                // Fallback on earlier versions
            }
            self.favoriteButton.setImage(image, for: .normal)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
