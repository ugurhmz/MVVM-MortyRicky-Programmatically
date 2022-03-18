//
//  ViewController.swift
//  RickyMorty-MVVM
//
//  Created by ugur-pc on 17.03.2022.
//

import UIKit


protocol RickyOutputProtocol {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [RickyInfo])      //ViewModelden geliyor.
}



class MainVC: UIViewController {

    
    private lazy var rickyList: [RickyInfo] = []
    lazy var viewModel = RickyViewModel()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
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
        
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
    
    func setupViews() {
        view.addSubview(generalCollectionView)
        view.addSubview(indicator)
        setGeneralCollectionViewConstraints()
        
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
        
        navigationItem.searchController = searchController
        indicator.startAnimating()
    }

    
    

}


//MARK: -
extension MainVC: RickyOutputProtocol {
    
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(values: [RickyInfo]) {
        rickyList = values
        generalCollectionView.reloadData()
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




//MARK: -  Delegate, DataSource
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // kaç tane hücre olacağı
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return rickyList.count
    }
    
    
    // hücrenin datası
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: MainListCell.identifier, for: indexPath) as! MainListCell
        
        cell.backgroundColor = .systemOrange
        cell.layer.cornerRadius = 20
        cell.saveModel(model: rickyList[indexPath.item])
        
        return cell
    }
    
    
}



//MARK: - ViewDelegateFlowLayout
extension MainVC: UICollectionViewDelegateFlowLayout {
    
    
    // cell w,h
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width - 30,
                      height: collectionView.frame.width - 280)
    }
    
    
    
    // dikeyde hücreler arası boşluk
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(15)
    }
    
    
    // Cell Outside
       func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           insetForSectionAt section: Int) -> UIEdgeInsets {

           return UIEdgeInsets(top: 10, left: 15 , bottom: 10, right: 15)
    }
    
}



