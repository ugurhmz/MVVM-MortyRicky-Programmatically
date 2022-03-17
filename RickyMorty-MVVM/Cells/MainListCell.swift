//
//  MainListCell.swift
//  RickyMorty-MVVM
//
//  Created by ugur-pc on 17.03.2022.
//

import UIKit

class MainListCell: UICollectionViewCell {
    
    static var identifier = "MainListCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"morty-smith")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    private let  nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = "Name: Ricky Mortin"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.text = "Species: Human"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not imp")
    }
    
    func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(speciesLabel)
        setImageViewConstraints()
        setNameLabelConstraints()
        setSpeciesLabelConstraints()
    }
    
    
}


//MARK: - Constraints
extension MainListCell {
    
    private func setImageViewConstraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height)
        ])
    }
    
    
    private func  setNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20)
            
        ])
    }
    
    private func setSpeciesLabelConstraints() {
        NSLayoutConstraint.activate([
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            speciesLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20)
            
        ])
    }
    
}

