//
//  CollectionViewTableViewCell.swift
//  Netflix
//
//  Created by Gadirli on 24.10.22.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewMode: MoviePreviewViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    

    static let identifier = "CollectionViewTableViewCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    private var movies: [Movie] = [Movie]()

    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configureMovie (with movies: [Movie]){
        self.movies = movies
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
    }
    

    

}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        
    
        guard let movie = movies[indexPath.row].poster_path else {return UICollectionViewCell()}
        cell.configure(with: movie)
        
      
        
        
        return cell
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieTitle = movies[indexPath.row].original_title else {
            return
        }
        
        
        
        APICaller.shared.getMovie(with: "\(movieTitle) trailer") { [weak self] result in
            print("\(movieTitle) trailer")
            switch result {
            case .success(let video):
                let movie = self?.movies[indexPath.row]
                guard let movieOverview = movie?.overview else {
                    return
                }
                
                guard let strongSelf = self else {
                    return
                }
            

                    let viewModel = MoviePreviewViewModel(title: movieTitle, youtubeView: video, movieOverview: movieOverview)
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewMode: viewModel)
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
