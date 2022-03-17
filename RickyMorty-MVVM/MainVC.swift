//
//  ViewController.swift
//  RickyMorty-MVVM
//
//  Created by ugur-pc on 17.03.2022.
//

import UIKit

class MainVC: UIViewController {

    
    // General Layout
    private let generalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        // register ListCell
        cv.register(MainListCell.self,
                    forCellWithReuseIdentifier: MainListCell.identifier)
        return cv
    }()
    
    
    // searchBar
    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.tintColor = .black
        sc.hidesNavigationBarDuringPresentation = false
        return sc
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    func setupViews() {
        view.addSubview(generalCollectionView)
        setGeneralCollectionViewConstraints()
        
        navigationItem.searchController = searchController
    }


}


//MARK: - Constraints
extension MainVC {
    
    private func setGeneralCollectionViewConstraints(){
        NSLayoutConstraint.activate([
            generalCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            generalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            generalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            generalCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

