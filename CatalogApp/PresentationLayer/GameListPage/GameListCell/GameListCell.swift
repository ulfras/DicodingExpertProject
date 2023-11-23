//
//  GameListCell.swift
//  CatalogApp
//
//  Created by Maulana Frasha on 08/11/23.
//

import UIKit

class GameListCell: UITableViewCell {

    @IBOutlet weak var gameImageViewOutlet: UIImageView!
    @IBOutlet weak var gameNameLabelOutlet: UILabel!
    @IBOutlet weak var releaseDataLabelOutlet: UILabel!
    @IBOutlet weak var gameRatingLabelOutlet: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        gameImageViewOutlet.layer.cornerRadius = 15
        gameImageViewOutlet.layer.borderWidth = 1
        gameImageViewOutlet.layer.borderColor = UIColor.black.cgColor
    }

    // Inside GameListCell class
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageViewOutlet.image = nil
    }

}
