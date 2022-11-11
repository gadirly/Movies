//
//  MovieTableVIewCell.swift
//  Netflix
//
//  Created by Gadirli on 30.10.22.
//

import UIKit

class MovieTableVIewCell: UITableViewCell {
    
    static let identifier = "MovieTableVIewCell"
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moviePosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(moviePosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
        applyConstraints()
        
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraints() {
        
        let moviePosterImageConstraints = [
            moviePosterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviePosterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            moviePosterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            moviePosterImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: moviePosterImage.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        
        NSLayoutConstraint.activate(moviePosterImageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
        
    }
    
    public func configure(with model: MovieViewModel){
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterUrl)") else {return}

        moviePosterImage.sd_setImage(with: url, completed: nil)
  
        titleLabel.text = model.titleName
        
    }

}
 
