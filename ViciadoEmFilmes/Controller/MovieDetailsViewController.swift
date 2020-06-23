//
//  MovieDetailsViewController.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit
import Nuke

class MovieDetailsViewController: UIViewController {

    
    // MARK: @IBOutlet
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: Attributes
    
    var movie:Movie?
    
    // MARK: LiveCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateData()
        self.layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.layout()
    }
    
    // MARK: UI
    
    func layout(){
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: Data
    
    func populateData(){
        guard let movie = self.movie else { return }
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy"
        self.titleLabel.text = movie.title
        self.releaseDateLabel.text = formatterDate.string(from: movie.releaseDate)
        self.descriptionTextView.text = movie.description
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
