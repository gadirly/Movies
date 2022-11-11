//
//  DetailedViewController.swift
//  Netflix
//
//  Created by Gadirli on 31.10.22.
//

import UIKit

class DetailedViewController: UIViewController {
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        applyConstraints()
        
       
        
    }
    
    
    
    public func configure(model: MovieViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterUrl)") else {return}

        posterImageView.sd_setImage(with: url, completed: nil)
        overviewLabel.text = model.overView
        titleLabel.text = model.titleName
    }
    
    private func applyConstraints() {
        
        let posterImageViewConstraints = [
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            posterImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -240),
            posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 260)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
    }
    

}
