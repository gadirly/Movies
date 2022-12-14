//
//  HeroHeaderUiView.swift
//  Netflix
//
//  Created by Gadirli on 26.10.22.
//

import UIKit



protocol HeroHeaderUiViewDelegate: AnyObject {
    func heroHeaderUiViewDidTapStart (viewMode: Movie)
}

class HeroHeaderUiView: UIView {
    
    var movieModel: Movie?
    
    weak var delegate: HeroHeaderUiViewDelegate?
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Başlat", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Yüklə", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        

        gradientLayer.frame = bounds
        heroImageView.layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(heroImageView)
        
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
        
        playButton.addTarget(self, action: #selector(performStart(_:)), for: .touchUpInside)
    }
    
    public func configure(with model: Movie) {
        print("Ishleyir")
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.poster_path ?? "")") else {return}
        
        movieModel = model
  
        heroImageView.sd_setImage(with: url, completed: nil)
    }
    
    private func applyConstraints() {
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
        addGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func performStart(_ sender: UIButton) {
    
        guard let movieModel = movieModel else {
            
            return
        }
        
        
        delegate?.heroHeaderUiViewDidTapStart(viewMode: movieModel)
        
    }
}

