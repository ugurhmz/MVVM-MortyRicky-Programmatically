//
//  WebService.swift
//  RickyMorty-MVVM
//
//  Created by ugur-pc on 18.03.2022.
//

import Foundation
import Alamofire


enum RickyEndPoints: String {
    
    case BASE_URL = "https://rickandmortyapi.com/api"
    case characterPath = "/character"
    
    static func characterEndPoint() -> String{
        return "\(BASE_URL.rawValue)\(characterPath.rawValue)"
    }
}


protocol RickyProtocol {
    func fetchDatas(response: @escaping ([RickyInfo]?)-> Void)
}



struct RickyWebService: RickyProtocol {
    
    
    func fetchDatas(response: @escaping ([RickyInfo]?) -> Void) {
        AF.request(RickyEndPoints.characterEndPoint()).responseDecodable(of: RickyGeneralModel.self) { (model) in
            
            
            guard let data = model.value else {
                response(nil)
                return
            }
            
            response(data.results)
            
        }
        
    }
    
    
}
