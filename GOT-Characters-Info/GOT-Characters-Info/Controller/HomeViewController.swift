//
//  HomeViewController.swift
//  GOT-Characters-Info
//
//  Created by Sameer Karoshi on 25/05/23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {
    
    // MARK: - Private Property
    lazy var gotCharactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Game of Throne Characters"
        setupTableView()
        
        // If no server data then hide the tableView
        if ThronesCharacterViewModel.thronesCharacterArray.count == 0 {
            gotCharactersTableView.isHidden = true
            showToastMessage("No Data!")
        } else {
            gotCharactersTableView.isHidden = false
        }
    }

    // MARK: - setup
    
    private func setupTableView() {
        gotCharactersTableView.dataSource = self
        gotCharactersTableView.register(ThronesCharacterCell.self, forCellReuseIdentifier: "reuseIndentifierForCell")
        view.addSubview(gotCharactersTableView)
        view = gotCharactersTableView
    }
    
    // MARK: - Private Helper
    
    private func showToastMessage(_ toastText: String) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 100, y: view.frame.size.height/2 - 100, width: 200, height: 50))
        toastLabel.backgroundColor = UIColor.systemBlue
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 14)
        toastLabel.textAlignment = .center;
        toastLabel.text = toastText
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ThronesCharacterViewModel.thronesCharacterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = gotCharactersTableView.dequeueReusableCell(withIdentifier: "reuseIndentifierForCell") as? ThronesCharacterCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        cell.fullName.text = "FullName: " + ThronesCharacterViewModel.thronesCharacterArray[indexPath.row].fullName
        cell.title.text = "Title: " + ThronesCharacterViewModel.thronesCharacterArray[indexPath.row].title
        cell.family.text = "Family: " + ThronesCharacterViewModel.thronesCharacterArray[indexPath.row].family
        ThronesCharacterViewModel.loadThronesCharacterImageUsingStringURL(ThronesCharacterViewModel.thronesCharacterArray[indexPath.row].imageUrl) { image in
            if let image = image {
                DispatchQueue.main.async {
                    cell.profileImage.image = image
                }
            }
        }
        return cell
    }
}

// MARK: - ThronesCharacterCellDelegate

extension HomeViewController: ThronesCharacterCellDelegate {
    func didTapDownloadButton(sender: ThronesCharacterCell) {
        guard let indexPath = gotCharactersTableView.indexPath(for: sender) else {
            return
        }
        
        ThronesCharacterViewModel.loadThronesCharacterImageUsingStringURL(ThronesCharacterViewModel.thronesCharacterArray[indexPath.row].imageUrl) { image in
            if let image = image {
                DispatchQueue.main.async { [weak self] in
                    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
                    self?.showToastMessage("Saved Image to Photos !")
                }
            }
        }
    }
}



