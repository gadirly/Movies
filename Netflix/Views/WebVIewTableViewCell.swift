//
//  WebVIewTableViewCell.swift
//  Netflix
//
//  Created by Gadirli on 12.11.22.
//

import UIKit
import WebKit

class WebVIewTableViewCell: UITableViewCell {
    
    static let identifier = "WebVIewTableViewCell"
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    private let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(content)
        contentView.addSubview(webView)
        addConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints () {
        
        let contentConstraints = [
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: content.topAnchor),
            webView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 270),
            webView.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(contentConstraints)
    }
    
    
    public func configure(with model: MoviePreviewViewModel) {
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        
        DispatchQueue.main.async {
            
        
            self.webView.load(URLRequest(url: url))
        }
    }

}
