//
//  SideListViewController.swift
//  Netflix
//
//  Created by Gadirli on 19.11.22.
//

import UIKit
import FirebaseAuth

protocol SideListViewControllerDelegate: AnyObject {
    func SideListViewControllerDidTapLogout()
}

class SideListViewController: UIViewController {
    
    weak var delegate: SideListViewControllerDelegate?
    
    private var profilePicture: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "profilepic")
        image.layer.borderWidth = 2.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.red.cgColor
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Babek Gadirli"
        return label
    }()

    
    private var sideTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.alwaysBounceVertical = false
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        sideTable.dataSource = self
        sideTable.delegate = self
        
        navigationController?.navigationBar.isHidden = true
        
        DispatchQueue.main.async {
            self.configureUserInformation()
        }
        
        
        profilePicture.clipsToBounds = true
        view.addSubview(profilePicture)
        view.addSubview(titleLabel)
        view.addSubview(sideTable)
        addConstraints()
        
    }
    
    private func configureUserInformation() {
        DBManager.shared.getUserInformation { [weak self] user in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.titleLabel.text = user
        }
        
        StorageManager.shared.getProfilePicutre { [weak self] url in
            guard let strongSelf = self else {
                return
            }
            
            guard let url = URL(string: url) else {
                return
            }
            strongSelf.profilePicture.sd_setImage(with: url, completed: nil)
        }
    }
    

    private func addConstraints() {
        let profilePictureConstraints = [
            profilePicture.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            profilePicture.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profilePicture.widthAnchor.constraint(equalToConstant: 70),
            profilePicture.heightAnchor.constraint(equalToConstant: 70)
        ]
        
        let sideTableConstraints = [
            sideTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            sideTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sideTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sideTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(profilePictureConstraints)
        NSLayoutConstraint.activate(sideTableConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2
    }

}

extension SideListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell()
        
        let index = indexPath.row
        
        switch index {
            
        case 0:
            cell.textLabel?.text = "Hesabım"
        case 1:
            cell.textLabel?.text = "Çıxış"
            
        default:
            return cell
        }
        cell.textLabel?.textAlignment = NSTextAlignment.right
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            print("Profile")
        case 1:
           do {
               try FirebaseAuth.Auth.auth().signOut()
               self.dismiss(animated: true)
               delegate?.SideListViewControllerDidTapLogout()

         }

          catch {
             print("Error while sign out")
         }
            
            
           
        default:
            print("Default")
        }
    }
    
    
}
