//
//  ViewController.swift
//  HeroesWiki
//
//  Created by Álvaro Perera on 18/12/24.
//

import UIKit

class HeroesListViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var heroListCollectionView: UICollectionView!
    
    var heroList: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heroListCollectionView.dataSource = self
        heroListCollectionView.delegate = self
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
                navigationItem.searchController = searchController
        loadFirstData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HeroCollectionCellViewController
        let hero = heroList[indexPath.item]
        cell.fillCell(hero: hero)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let columns = 3
            let spacing = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
            let screenWidth = collectionView.frame.size.width
            let leftSpace = screenWidth - spacing * CGFloat(columns - 1)
            let width = leftSpace / CGFloat(columns) //some width
            let height = width * 1.33 //ratio
            return CGSize(width: width, height: height)
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            searchHeroBy(name: query)
        } else {
            loadFirstData()
        }
    }
    
    func searchHeroBy(name: String){
        Task {
            do {
                heroList = try await SuperHeroAPIHelper.getHeroesByName(name: name)
                DispatchQueue.main.async {
                    self.heroListCollectionView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
    
    func loadFirstData(){
        Task {
            do {
                heroList = try await SuperHeroAPIHelper.getHeroesByName(name: "A")
                DispatchQueue.main.async {
                    self.heroListCollectionView.reloadData()
                }
            } catch {
                //handle error
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHeroDetail" {
            if let indexPath = heroListCollectionView.indexPathsForSelectedItems?.first {
                let hero = heroList[indexPath.row]
                let destinationVC = segue.destination as? HeroDetailTabBarController
                destinationVC!.hero = hero }
        }
    }
}

/*
 if let tabBarController = segue.destination as? MyTabBarController {
         tabBarController.sharedData = "Datos compartidos para todos los tabs"
     }
 */
