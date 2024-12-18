//
//  HeroTableCellViewController.swift
//  HeroesWiki
//
//  Created by Álvaro Perera on 18/12/24.
//

import UIKit

class HeroTableCellViewController: UITableViewCell {

    @IBOutlet weak var heroImgView: UIImageView!
    
    @IBOutlet weak var heroNameView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func fillCell(hero: Hero) {
        heroNameView.text = hero.name
        heroImgView.loadFrom(url: hero.image.url)
    }
}
