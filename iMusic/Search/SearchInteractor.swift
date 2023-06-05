//
//  SearchInteractor.swift
//  iMusic
//
//  Created by RAFAEL on 02.06.2023.
//  Copyright (c) 2023 RAFAEL. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request.RequestType)
}
var networkService = NetworkService()
class SearchInteractor: SearchBusinessLogic {
    
    var presenter: SearchPresentationLogic?
    var service: SearchService?
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        if service == nil {
            service = SearchService()
        }
        
        switch request {
        case .getTracks(let searchTerm):
            presenter?.presentData(response: Search.Model.Response.ResponseType.presentFooterView)
            print("interactor .getTracks")
            networkService.fetchTracks(searchText: searchTerm) { [weak self] (searchResponse) in
                self?.presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks(searchResponse: searchResponse))
            }
        }
    }
    
}
