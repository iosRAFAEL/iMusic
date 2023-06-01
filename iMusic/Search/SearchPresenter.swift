//
//  SearchPresenter.swift
//  iMusic
//
//  Created by RAFAEL on 02.06.2023.
//  Copyright (c) 2023 RAFAEL. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
  func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
  weak var viewController: SearchDisplayLogic?
  
  func presentData(response: Search.Model.Response.ResponseType) {
  
  }
  
}
