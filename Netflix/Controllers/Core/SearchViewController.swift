//
//  SearchViewController.swift
//  Netflix
//
//  Created by Gadirli on 24.10.22.
//

import UIKit


class SearchViewController: UIViewController {
    
    private var upcomingMovies: [Movie] = [Movie]()
    
    private let discoverTableView: UITableView = {
        let table = UITableView()
        table.register(MovieTableVIewCell.self, forCellReuseIdentifier: MovieTableVIewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Film axtar"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Axtar"
        view.addSubview(discoverTableView)
        navigationItem.searchController = searchController
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .white
        
        discoverTableView.dataSource = self
        discoverTableView.delegate = self
        searchController.searchResultsUpdater = self
        fetchMovies()
        view.addSubview(discoverTableView)
        
        DispatchQueue.main.async {
            self.discoverTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        discoverTableView.frame = view.bounds
    }
    
    private func fetchMovies() {
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
            case.success(let movies):
                self?.upcomingMovies = movies
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingMovies.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableVIewCell.identifier) as? MovieTableVIewCell else {return UITableViewCell()}
        
        let movie = upcomingMovies[indexPath.row]
        cell.configure(with: MovieViewModel(titleName: movie.original_title ?? "", posterUrl: movie.poster_path ?? "", overView: upcomingMovies[indexPath.row].overview ?? ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 2,
              let resultController = searchController.searchResultsController as? SearchResultViewController else {return}
        
        APICaller.shared.searchMovies(with: query) { result in
            
            
            
            DispatchQueue.main.async {
                
                
                switch result{
                case.success(let result):
                    resultController.movie = result
                    
                    resultController.searchResultsCollectionView.reloadData()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        }
    
    
    
        
    }

