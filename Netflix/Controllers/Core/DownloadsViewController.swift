//
//  DownloadsViewController.swift
//  Netflix
//
//  Created by Gadirli on 24.10.22.
//

import UIKit

class DownloadsViewController: UIViewController {
    let refreshControl = UIRefreshControl()
    var favMovies: [Movie] = [Movie]()
    var movieIdList: [String: String] = [String: String]()
    private var favoriteMoviesTable: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableVIewCell.self, forCellReuseIdentifier: MovieTableVIewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(favoriteMoviesTable)
        favoriteMoviesTable.dataSource = self
        favoriteMoviesTable.delegate = self
        
        
        fetchMovies()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        favoriteMoviesTable.addSubview(refreshControl)
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favoriteMoviesTable.frame = view.bounds
    }
    
    private func fetchMovies(){
        DBManager.shared.getFavouriteMovies { [weak self] data in
            
            self?.movieIdList = data
            
            for d in data {

                let movieId = d.value

                APICaller.shared.getMovieById(movie: movieId) { [weak self] result in
                    switch result {
                    case .success(let movie):
                        DispatchQueue.main.async {
                            
                            self?.favoriteMoviesTable.reloadData()
                        }
                        self?.favMovies.append(movie)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        favMovies = []
        favoriteMoviesTable.reloadData()
        fetchMovies()
        refreshControl.endRefreshing()
    }

}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableVIewCell.identifier) as? MovieTableVIewCell else {
            return UITableViewCell()
        }
        
        let movie = favMovies[indexPath.row]
        
        
        cell.configure(with: MovieViewModel(titleName: movie.original_title ?? "", posterUrl: movie.poster_path ?? "", overView: movie.overview ?? ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 570
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = BioViewController()
        

        let movie = favMovies[indexPath.row]
        
        
        vc.configure(with: movie)
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
}
