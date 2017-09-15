//
//  ViewController.swift
//  searchview_demo_ios
//
//  Created by Etukeni E. Ndecha O. on 15/09/2017.
//  Copyright © 2017 BEET Solutions AB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let nameList:[Name] = [
        Name(name:"Etukeni"),
        Name(name:"Nadesh"),
        Name(name:"Justin"),
        Name(name:"Jacob"),
        Name(name:"Susan"),
        Name(name:"Ndecha"),
        Name(name:"Obase"),
        Name(name:"John"),
        Name(name:"Jane"),
        Name(name:"Eric")
    ]
    
    var filteredNames = [Name]()
    
    let dataSearchResult:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredNames.count
        }
        
        return nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let name: Name
        if isFiltering() {
            name = filteredNames[indexPath.row]
        } else {
            name = nameList[indexPath.row]
        }
        cell.textLabel!.text = name.name
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private instance methods
    func filterContentForSearchText(_ searchText: String) {
        filteredNames = nameList.filter({( name : Name) -> Bool in
            return name.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
}

extension ViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension ViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


