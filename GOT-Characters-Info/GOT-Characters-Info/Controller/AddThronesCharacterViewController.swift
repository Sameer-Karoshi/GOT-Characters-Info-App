//
//  AddNewGOTCharacterViewController.swift
//  GOT-Characters-Info
//
//  Created by Sameer Karoshi on 25/05/23.
//

import UIKit

class AddThronesCharacterViewController: UIViewController {
    
    // MARK: - Private Property
    
    private lazy var addThronesCharacterView: UIView = {
        let view = AddThronesCharacterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Game of Throne Character"
        view.backgroundColor = UIColor.white
        view.addSubview(addThronesCharacterView)
        
        NSLayoutConstraint.activate([
            addThronesCharacterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addThronesCharacterView.topAnchor.constraint(equalTo: view.topAnchor),
            addThronesCharacterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addThronesCharacterView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
}
