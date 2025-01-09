//
//  HeroDetailViewController.swift
//  HeroesWiki
//
//  Created by Álvaro Perera on 19/12/24.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameTextView: UILabel!
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        if let tabBarController = self.tabBarController as? HeroDetailTabBarController {
            hero = tabBarController.hero
        }
        // heroNameTextView.text = hero!.name
        heroImageView.loadFrom(url: hero!.image.url)
    }
}
