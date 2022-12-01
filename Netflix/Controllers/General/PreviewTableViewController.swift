//
//  PreviewTableViewController.swift
//  Netflix
//
//  Created by Gadirli on 12.11.22.
//

import UIKit

class PreviewTableViewController: UIViewController {

    private var movie: Movie?
    private var video: VideoElement?

    private var previewTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(WebVIewTableViewCell.self, forCellReuseIdentifier: WebVIewTableViewCell.identifier)
        table.register(PreviewDetailTableViewCell.self, forCellReuseIdentifier: PreviewDetailTableViewCell.identifier)
        table.separatorStyle = .none
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(previewTable)
        previewTable.dataSource = self
        previewTable.delegate = self
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewTable.frame = view.bounds
    }

    func configure(with model: Movie) {
        self.movie = model
    }



}

extension PreviewTableViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WebVIewTableViewCell.identifier) as? WebVIewTableViewCell else {return UITableViewCell()}

            guard let movie = movie else {
                return UITableViewCell()
            }

            APICaller.shared.getMovie(with: "\(movie.original_title ?? "") trailer") { result in
                switch result {
                case .success(let video):
                    
                    cell.configure(with: movie, video: video)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }

            return cell
        }

        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PreviewDetailTableViewCell.identifier) as? PreviewDetailTableViewCell else {
                print("defaulttu 1")
                return UITableViewCell()
            }

            guard let movie = movie else {
                print("defaulttu 2")
                return UITableViewCell()
            }

            cell.configure(with: movie)

            return cell
        }



        return UITableViewCell()
    }


}
