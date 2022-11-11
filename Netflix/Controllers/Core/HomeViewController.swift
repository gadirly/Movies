//
//  HomeViewController.swift
//  Netflix
//
//  Created by Gadirli on 24.10.22.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case Toprated = 4
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMovie: Movie?
    private var headerView: HeroHeaderUiView?
    
    private var popularMovies = [Movie]()
    
    let sectionTitles: [String] = [
        "Trend Filmlər",
        "Trend Seriallar",
        "Məhşur Filmlər",
        "Tezliklə",
        "Ən çox izlənilənlər"
    ]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        
        configureNavbar()
        
        headerView = HeroHeaderUiView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView
        
        configureHeroHeaderView()
        
      
    }
    

    
    private func configureHeroHeaderView() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let movie):
                let randomMovie = movie.randomElement()
                self?.randomTrendingMovie = randomMovie
                let viewModel = MovieViewModel(titleName: "", posterUrl: randomMovie?.poster_path ?? "", overView: "")
                
                
               self?.headerView?.configure(with: viewModel)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
 
    
    private func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let listOf):
                self.popularMovies = listOf
                print(self.popularMovies[2].original_title!)
                
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    private func configureNavbar() {
        
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .label
        
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
            }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case.success(let movies):
                    cell.configureMovie(with: movies)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs { result in
                switch result {
                case .success(let tvMovies):
                    cell.configureMovie(with: tvMovies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopularMovies { result in
                switch result {
                case.success(let movies):
                    cell.configureMovie(with: movies)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case.success(let movies):
                    cell.configureMovie(with: movies)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Toprated.rawValue:
            APICaller.shared.getTopRatedMovies { result in
                switch result {
                case.success(let movies):
                    cell.configureMovie(with: movies)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 15, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
    
}


extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewMode: MoviePreviewViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            let vc = MoviePreviewViewController()
            vc.configure(with: viewMode)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
