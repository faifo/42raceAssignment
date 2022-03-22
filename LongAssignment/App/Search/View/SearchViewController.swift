//
//  SearchViewController.swift
//  LongAssignment
//
//  Created by Solo on 20/03/2022.
//

import Foundation
import UIKit
enum ViewControllerState {
    case loading
    case error
    case success
}

final class SearchViewController : UIViewController {
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        return searchBar
    }()
    
    @IBOutlet weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    
    var viewModel:  SearchViewModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupRefreshControl()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        viewModel.loadData()
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func reloadData(state: ViewControllerState) {
        switch state {
            case .loading:
                // TODO: show loading hud
                print("is loading")
            case .error:
                // TODO: Error handling UI
                print("got error")
            case .success:
                self.tableView.reloadData()
        }
    }
}

private extension SearchViewController {
//    @objc func refresh(_ sender: AnyObject) {
//        viewModel.loadData()
//    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh")
//        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.register(UINib(nibName: BusinessViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: BusinessViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupNavigationBar() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BusinessViewCell.identifier) as? BusinessViewCell else {
            assertionFailure("Cell Registation Problem")
            return UITableViewCell()
        }
        
        let viewData = viewModel.businesses[indexPath.row]
        cell.configure(with: viewData)
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    

}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        viewModel.loadData(term: searchText)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
