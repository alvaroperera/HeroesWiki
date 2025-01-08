//
//  HeroTableCellViewController.swift
//  HeroesWiki
//
//  Created by Álvaro Perera on 18/12/24.
//

import UIKit

class HeroCollectionCellViewController: UICollectionViewCell {

    @IBOutlet weak var heroImgView: UIImageView!
    
    @IBOutlet weak var heroNameView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillCell(hero: Hero) {
        heroNameView.text = hero.name
        heroImgView.loadFrom(url: hero.image.url)
    }
}
