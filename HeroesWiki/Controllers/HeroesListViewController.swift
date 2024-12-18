//
//  ViewController.swift
//  HeroesWiki
//
//  Created by Álvaro Perera on 18/12/24.
//

import UIKit

class HeroesListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    

    @IBOutlet weak var heroListTable: UITableView!
    
    var heroList: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heroListTable.dataSource = self
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
                navigationItem.searchController = searchController
        loadFirstData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HeroTableCellViewController
                let hero = heroList[indexPath.item]
                cell.fillCell(hero: hero)
                return cell
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
                    self.heroListTable.reloadData()
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
                    self.heroListTable.reloadData()
                }
            } catch {
                //handle error
                print(error)
            }
        }
    }
}

