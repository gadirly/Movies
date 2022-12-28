//
//  BioViewController.swift
//  Netflix
//
//  Created by Gadirli on 28.11.22.
//

import UIKit
import FirebaseAuth

class BioViewController: UIViewController {
    
    private var headerView: BioHeaderView?
    var movie: Movie?
    
    private let bioTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PreviewDetailTableViewCell.self, forCellReuseIdentifier: PreviewDetailTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        configureHeader()
        
        
        view.addSubview(bioTableView)
        
        navigationController?.navigationBar.tintColor = .label
        bioTableView.delegate = self
        bioTableView.dataSource = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bioTableView.frame = view.bounds
    }
    
    public func configure(with model: Movie) {
        self.movie = model
    }
    
    private func configureHeader() {
        
        guard let movie = movie else {
            return
        }
        headerView = BioHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 320))
        headerView?.configure(with: movie)
        headerView?.delegate = self
        bioTableView.tableHeaderView = headerView
    }


}

extension BioViewController: UITableViewDelegate, UITableViewDataSource, BioHeaderViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreviewDetailTableViewCell.identifier, for: indexPath) as? PreviewDetailTableViewCell else {
            return UITableViewCell()
        }
        
        
        guard let movie = movie else {
            return UITableViewCell()
        }
        
        cell.configure(with: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func BioHeaderViewInfoBtnSelected(model: Movie) {
        
       
        DBManager.shared.addToFavorites(movieId: String(model.id)) { isAdded in
            if isAdded == true {
                print("\(model.original_title ?? "") added to favorites")
            }
            else {
                print("Error while adding")
            }
        }
    }
    
    func BioHeaderViewPlayBtnSelected(model: Movie) {
        let vc = PreviewTableViewController()
        guard let movie = movie else {
            return
        }
        vc.configure(with: movie)
        present(vc, animated: true)
    }
}


