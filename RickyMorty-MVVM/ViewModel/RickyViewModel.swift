//
//  RickyViewModel.swift
//  RickyMorty-MVVM
//
//  Created by ugur-pc on 18.03.2022.
//

import Foundation



protocol RickyViewModelProtocol {
    func  fetchItems()
    func  changeLoading()
    
    
    var rickyCharacters: [RickyInfo] { get set}     // API Datam
    var rickyWebService: RickyWebService { get }    // WebService'teki protocol
    var rickyOutPut: RickyOutputProtocol? { get }
    
    
    func setDelegate(output: RickyOutputProtocol)
    
}


final class RickyViewModel: RickyViewModelProtocol {
    
    private var isLoading = false
    
    // protocol props
    var rickyCharacters: [RickyInfo] = []
    var rickyWebService: RickyWebService
    var rickyOutPut: RickyOutputProtocol?
    
    
    func setDelegate(output: RickyOutputProtocol) {
        rickyOutPut = output
    }
    
    
    init(){
        rickyWebService = RickyWebService()
    }
    
    
    func fetchItems() {
        changeLoading()
        
        rickyWebService.fetchDatas { [weak self] (response) in
            self?.changeLoading()
            
            self?.rickyCharacters = response ?? []  //Response'tan dönen datayı, benim yukardaki boş dizime(API'deki Modelin Tipiyle Tanımlı olan)
            
            self?.rickyOutPut?.saveDatas(rickyList: self?.rickyCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickyOutPut?.changeLoading(isLoad: isLoading)
    }
    
}
