//
//  ViewController.swift
//  HeroesWiki
//
//  Created by Álvaro Perera on 18/12/24.
//

import UIKit

class HeroesListViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegate {
    
    @IBOutlet weak var heroListCollectionView: UICollectionView!
    
    var heroList: [Hero] = []
    let numberOfColumns: CGFloat = 4 // Número de columnas
    let cellSpacing: CGFloat = 10 // Espaciado entre celdas
    
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
            let columns = 2
            let spacing = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
            let screenWidth = collectionView.frame.size.width
            let leftSpace = screenWidth - spacing * CGFloat(columns - 1)
            let width = leftSpace / CGFloat(columns) //some width
            let height = width * 1.33 //ratio
            return CGSize(width: width, height: height)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
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
                let destinationVC = segue.destination as! HeroDetailViewController
                destinationVC.hero = hero }
        }
    }
}

