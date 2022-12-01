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
       
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private let moviePosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 1.0
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(moviePosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
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
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -20)
        ]
        
        let overviewLabelConstraint = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            overviewLabel.leadingAnchor.constraint(equalTo: moviePosterImage.trailingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -20),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ]
        
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 30),
            playButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        
        NSLayoutConstraint.activate(moviePosterImageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraint)
        NSLayoutConstraint.activate(playButtonConstraints)
        
    }
    
    public func configure(with model: MovieViewModel){
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterUrl)") else {return}

        moviePosterImage.sd_setImage(with: url, completed: nil)
  
        titleLabel.text = model.titleName
        overviewLabel.text = model.overView
        
    }

}
 
