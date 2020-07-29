//
//  MovieItemTableViewCell.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit
import Nuke

class MovieItemTableViewCell: UITableViewCell {

    // MARK: @IBOutlet
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: Data
    
    func populateCell(with movie:Movie){
        self.titleLabel.text = movie.title
        self.descriptionLabel.text = movie.text
        if let imageURL:URL = URL(string: ImagemSizeType.small(movie.image).url) {
            let options = ImageLoadingOptions(
                transition: .fadeIn(duration: 0.5)
            )
            Nuke.loadImage(with: imageURL, options: options, into: self.thumbImageView)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
