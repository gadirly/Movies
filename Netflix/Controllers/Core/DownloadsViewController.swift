//
//  DownloadsViewController.swift
//  Netflix
//
//  Created by Gadirli on 24.10.22.
//

import UIKit

class DownloadsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        DBManager.shared.getFavouriteMovies { data in
            for d in data {
                
                guard let movieId = d.value as? String else {
                    return
                }
                        
                APICaller.shared.getMovieById(movie: movieId) { result in
                    switch result {
                    case .success(let movie):
                        print(movie)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    



}
