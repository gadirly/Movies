//
//  BioHeaderView.swift
//  Netflix
//
//  Created by Gadirli on 28.11.22.
//

import UIKit

protocol BioHeaderViewDelegate: AnyObject {
    func BioHeaderViewInfoBtnSelected(model: Movie)
    func BioHeaderViewPlayBtnSelected(model: Movie)
}

class BioHeaderView: UIView {
    
    var movie: Movie?
    weak var delegate: BioHeaderViewDelegate?
    
    private var movieImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.image = UIImage(named: "heroHeaderImg")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let profilePic: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1.0
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.image = UIImage(named: "heroHeaderImg")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.tintColor = .gray
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.opacity = 0.5
        return button
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .gray
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.opacity = 0.5
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(movieImageView)
        
        addSubview(profilePic)
        addSubview(infoButton)
        addSubview(playButton)
        addConstraints()
        
        infoButton.addTarget(self, action: #selector(infoTapped(_:)), for: .touchUpInside)
        
        playButton.addTarget(self, action: #selector(playTapped(_:)), for: .touchUpInside)
    }
    
    @objc func infoTapped(_ sender: UIButton) {
        guard let movie = movie else {
            return
        }
        delegate?.BioHeaderViewInfoBtnSelected(model: movie)
    }
    
    @objc func playTapped(_ sender: UIButton) {
        guard let movie = movie else {
            return
        }
        delegate?.BioHeaderViewPlayBtnSelected(model: movie)
    }
    
    private func addConstraints() {
        
        let profilePicConstraints = [
            profilePic.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -90),
            profilePic.centerXAnchor.constraint(equalTo: movieImageView.centerXAnchor),
            profilePic.heightAnchor.constraint(equalToConstant: 180),
            profilePic.widthAnchor.constraint(equalToConstant: 130)
        ]
        
        let imageViewConstraints = [
            movieImageView.topAnchor.constraint(equalTo: self.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        let infoButtonConstraints = [
            infoButton.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 35),
            infoButton.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 30),
            infoButton.heightAnchor.constraint(equalToConstant: 60),
            infoButton.widthAnchor.constraint(equalToConstant: 60)
        ]
        
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: profilePic.leadingAnchor, constant: -35),
            playButton.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 30),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.widthAnchor.constraint(equalToConstant: 60)
        ]
        
        NSLayoutConstraint.activate(profilePicConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(infoButtonConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
    }
    
    public func configure(with model: Movie) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.poster_path ?? "")") else {return}
        
        self.movie = model
        movieImageView.sd_setImage(with: url, completed: nil)
        profilePic.sd_setImage(with: url, completed: nil)
    }
    
    
    private func addGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = movieImageView.bounds
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        movieImageView.layer.addSublayer(gradient)
        print("Test2")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradient()
    }
    
}
