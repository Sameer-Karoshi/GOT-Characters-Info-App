//
//  ThronesCharacterCell.swift
//  GOT-Characters-Info
//
//  Created by Sameer Karoshi on 24/05/23.
//

import UIKit

protocol ThronesCharacterCellDelegate: AnyObject {
    func didTapDownloadButton(sender: ThronesCharacterCell)
}

class ThronesCharacterCell: UITableViewCell {
    
    // MARK: - Constant
    
    private let thronesCharacterCellInternalSpacing = 10.0
    private let thronesCharacterImageHeight = 60.0
    private let thronesCharacterImageWidth = 100.0
    
    weak var delegate: ThronesCharacterCellDelegate?
    
    //MARK: - lazy Properties
    
    lazy var fullName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh + 1, for: NSLayoutConstraint.Axis.vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var family: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var saveImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(didTapDownloadButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setup
    
    private func setupView() {
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubview(profileImage)
        contentView.addSubview(fullName)
        contentView.addSubview(title)
        contentView.addSubview(family)
        contentView.addSubview(saveImageButton)
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: thronesCharacterCellInternalSpacing),
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: thronesCharacterCellInternalSpacing),
            profileImage.heightAnchor.constraint(equalToConstant: thronesCharacterImageHeight),
            profileImage.widthAnchor.constraint(equalToConstant: thronesCharacterImageWidth),
            
            saveImageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: thronesCharacterCellInternalSpacing * 2),
            saveImageButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: thronesCharacterCellInternalSpacing / 2),
            saveImageButton.heightAnchor.constraint(equalToConstant: thronesCharacterCellInternalSpacing * 2),
            saveImageButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -thronesCharacterCellInternalSpacing / 2),
            
            fullName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: thronesCharacterCellInternalSpacing),
            fullName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: thronesCharacterCellInternalSpacing),
            fullName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -thronesCharacterCellInternalSpacing),
            
            title.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: thronesCharacterCellInternalSpacing),
            title.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: thronesCharacterCellInternalSpacing),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -thronesCharacterCellInternalSpacing),
            
            family.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: thronesCharacterCellInternalSpacing),
            family.topAnchor.constraint(equalTo: title.bottomAnchor, constant: thronesCharacterCellInternalSpacing),
            family.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -thronesCharacterCellInternalSpacing)
        ])
    }
    
    // MARK: - Action
    
    @objc private func didTapDownloadButton() {
        delegate?.didTapDownloadButton(sender: self)
    }
}
