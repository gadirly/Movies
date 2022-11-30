//
//  UpcomingViewController.swift
//  Netflix
//
//  Created by Gadirli on 24.10.22.
//

import UIKit


class UpcomingViewController: UIViewController {
    
    private var upcomingMovies: [Movie] = [Movie]()
    
    private let upcomingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableVIewCell.self, forCellReuseIdentifier: MovieTableVIewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        title = "Tezliklə"
        view.addSubview(upcomingTableView)
    
        fetchMovies()
        DispatchQueue.main.async {
        
            self.upcomingTableView.reloadData()
        }
        
    }
    

    
    override func viewDidLayoutSubviews() {
        upcomingTableView.frame = view.bounds
    }
    
    
    private func fetchMovies() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case.success(let movies):
                self?.upcomingMovies = movies
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

   
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = BioViewController()
        

        let movie = upcomingMovies[indexPath.row]
        
        
        vc.configure(with: movie)
        
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
 
    
    
}
