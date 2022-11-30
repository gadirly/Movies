//
//  PreviewDetailTableViewCell.swift
//  Netflix
//
//  Created by Gadirli on 12.11.22.
//

import UIKit

class PreviewDetailTableViewCell: UITableViewCell {
    
    static let identifier: String = "PreviewDetailTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "N/A"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,weight: .regular)
        label.numberOfLines = 0
        label.text = "N/A"
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Yadda saxla", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 9
        button.layer.masksToBounds = true
        return button
    }()
    
    private let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(content)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(downloadButton)
        contentView.backgroundColor = .systemBackground
       
        addConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        let contentConstraints = [
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: 10)
          
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            overviewLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 10),
            overviewLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor,constant: -20)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 30),
            downloadButton.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 200),
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
            downloadButton.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(contentConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    public func configure(with model: Movie) {
        
       
        
        self.titleLabel.text = model.original_title
        self.overviewLabel.text = model.overview
    }
    
    

}
