//
//  AddThronesCharacterView.swift
//  GOT-Characters-Info
//
//  Created by Sameer Karoshi on 25/05/23.
//

import UIKit

class AddThronesCharacterView: UIView {
    
    // MARK: - constant
    
    private let addThronesCharacterViewInternalSpacing = 10.0
    private let submitButtonHeight = 40.0
    private let submitButtonWidth = 75.0
    
    // MARK: - Private Properties
    
    private lazy var id: UITextField = {
        let textField = UITextField()
        textField.placeholder = "ID"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var firstName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var lastName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var title: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var family: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Family"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0, alpha: 0.1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - setup
    
    private func setupView() {
        addSubview(id)
        addSubview(firstName)
        addSubview(lastName)
        addSubview(title)
        addSubview(family)
        addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            id.leadingAnchor.constraint(equalTo: leadingAnchor, constant: addThronesCharacterViewInternalSpacing),
            id.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 2 * addThronesCharacterViewInternalSpacing),
            id.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -addThronesCharacterViewInternalSpacing),
            
            firstName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: addThronesCharacterViewInternalSpacing),
            firstName.topAnchor.constraint(equalTo: id.bottomAnchor, constant: 2 * addThronesCharacterViewInternalSpacing),
            firstName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -addThronesCharacterViewInternalSpacing),
            
            lastName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: addThronesCharacterViewInternalSpacing),
            lastName.topAnchor.constraint(equalTo: firstName.bottomAnchor, constant: 2 * addThronesCharacterViewInternalSpacing),
            lastName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -addThronesCharacterViewInternalSpacing),
            
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: addThronesCharacterViewInternalSpacing),
            title.topAnchor.constraint(equalTo: lastName.bottomAnchor, constant: 2 * addThronesCharacterViewInternalSpacing),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -addThronesCharacterViewInternalSpacing),
            
            family.leadingAnchor.constraint(equalTo: leadingAnchor, constant: addThronesCharacterViewInternalSpacing),
            family.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2 * addThronesCharacterViewInternalSpacing),
            family.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -addThronesCharacterViewInternalSpacing),
            
            submitButton.topAnchor.constraint(equalTo: family.bottomAnchor, constant: 2 * addThronesCharacterViewInternalSpacing),
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: submitButtonHeight),
            submitButton.widthAnchor.constraint(equalToConstant: submitButtonWidth)
        ])
    }
    
    // MARK: - Action
    
    @objc private func submitButtonTapped() {
        guard let stringID = id.text,
            let id = Int(stringID),
            let firstName = firstName.text,
            let lastName = lastName.text,
            let title = title.text,
            let family = family.text else {
                return
        }
                
        let object = ThronesCharacter(
            id: id,
            firstName: firstName,
            lastName: lastName,
            fullName: firstName + lastName,
            title: title,
            family: family,
            image: "",
            imageUrl: "")
        ThronesCharacterViewModel.updateThronesCharacterAPI(object){ data in
            DispatchQueue.main.async { [weak self] in
                self?.showToastMessage(data)
            }
        }
    }
    
    // MARK: - Helper
    
    private func showToastMessage(_ toastText: String) {
        let toastLabel = UILabel(frame: CGRect(x: 110, y: 210, width: 150, height: 50))
        toastLabel.backgroundColor = UIColor.systemBlue
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 14)
        toastLabel.textAlignment = .center;
        toastLabel.text = toastText
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = addThronesCharacterViewInternalSpacing
        toastLabel.clipsToBounds  =  true
        addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
