//
//  ViewController.swift
//  desafiofilmesios
//
//  Created by JR on 25/05/20.
//  Copyright © 2020 JR. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
    let secureFavoriteDAO = SecureFavoriteDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions
    @IBAction func favorites(_ sender: Any) {
        if let movieID = secureFavoriteDAO.secureGetMovie() {
            let favView = FavoriteMoviesViewController(movieId: movieID)
            navigationController?.pushViewController(favView, animated: true)
        
        } else {
            let alert = UIAlertController(title: "Info", message: "Não exite filme favorito.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}

