//
//  RepositorySearchController.swift
//  github app
//
//  Created by Karol Korzeń on 11/12/2020.
//

import UIKit

let reuseIdentifier = "reuseID"

class RepositorySearchController: UITableViewController {

    //MARK: - Properties
    
    let searchController = UISearchController(searchResultsController: nil)
    var viewModel = RepositoryViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 120
        tableView.separatorStyle = .none
        
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search repository"
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
    }
    
}

//MARK: - UITableViewDelegate / DataSource

extension RepositorySearchController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! RepositoryCell
        cell.viewModel = RepositoryCellViewModel(withRepository: viewModel.repositories[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
//        let controller = ProfileController(user: user)
//        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UISearchBarDelegate

extension RepositorySearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchController.searchBar.text else {return}
        print("SEARCHING: \(searchText)")
        viewModel.reset {
            self.tableView.reloadData()
            self.viewModel.search(withPhrase: searchText, completion: {
                self.tableView.reloadData()
            })
        }
        searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.reset {
            self.tableView.reloadData()
        }
    }
}
