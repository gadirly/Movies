//
//  SearchResultViewController.swift
//  Netflix
//
//  Created by Gadirli on 01.11.22.
//

import UIKit




class SearchResultViewController: UIViewController {
    
    public var movie: [Movie] = [Movie]()
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        return collectionview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.delegate = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    


}

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        
        
        
        cell.configure(with: movie[indexPath.row].poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let vc = PreviewTableViewController()
        let selectedMovie = movie[indexPath.row]
        
        guard let originalTitle = selectedMovie.original_title, let overview = selectedMovie.overview else {
            return
        }
        
        
            APICaller.shared.getMovie(with: "\(originalTitle) trailer") { [weak self ]result in
                
                switch result {
                case.success(let video):
                    DispatchQueue.main.async {
                        vc.configure(with: MoviePreviewViewModel(title: originalTitle, youtubeView: video, movieOverview: overview))
                        self?.present(vc, animated: true)
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        
    }
    
    
}

