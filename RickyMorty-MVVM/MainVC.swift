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
    
    
    //search
    var searchMode = false
    var filteredRickyList = [RickyInfo]()
    
    
    
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
        configureSearchBarButton()
    }
    
    
    func setupViews() {
        view.addSubview(generalCollectionView)
        view.addSubview(indicator)
        setGeneralCollectionViewConstraints()
        
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
       
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
        return searchMode ? filteredRickyList.count : rickyList.count
    }
    
    
    // hücrenin datası
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = generalCollectionView.dequeueReusableCell(withReuseIdentifier: MainListCell.identifier, for: indexPath) as! MainListCell
        
        cell.layer.shadowColor = UIColor.white.cgColor
        cell.layer.shadowOffset = CGSize(width:2, height:3)
        cell.layer.shadowRadius = 2.5
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false
        
        cell.backgroundColor = .black
        cell.layer.cornerRadius = 20
        searchMode ? cell.saveModel(model: filteredRickyList[indexPath.item]) :  cell.saveModel(model: rickyList[indexPath.item])
        
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



extension MainVC {
    
    
    func configureSearchBarButton(){
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                target: self,
                                                                action: #selector(showSearchBar))
            navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc func showSearchBar(){
            searchingFunc(shouldShow: true)
    }
        
    
    @objc func searchingFunc(shouldShow: Bool) {
        if shouldShow {
            // searchBar
            let searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.sizeToFit()
            searchBar.showsCancelButton = true
            searchBar.becomeFirstResponder() // icona tıklayınca searchbar focus
            searchBar.tintColor = .black
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.textColor = .black
            
            navigationItem.rightBarButtonItem = nil
            navigationItem.titleView = searchBar
            
        } else {
            navigationItem.titleView = nil
            configureSearchBarButton()
            searchMode = false
            generalCollectionView.reloadData()
        }
    }
}


//MARK: - SearchBarDelegate
extension MainVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchingFunc(shouldShow: false)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty || searchBar.text == nil {
            searchMode = false
            generalCollectionView.reloadData()
            view.endEditing(true)
        } else {    // search mode ON
            
            
            searchMode = true
            print(searchText)
            filteredRickyList = rickyList.filter({
                $0.name?.lowercased().contains(searchText.lowercased()) as! Bool
                
            })
            
            generalCollectionView.reloadData()
        }
    }
    
}
