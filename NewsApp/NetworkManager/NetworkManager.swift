//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

// BaseUrl:- To point out the server url to retrieve and Send Information on the Server
public enum BaseUrl: String{
   case newsApp = "https://moedemo-93e2e.firebaseapp.com/assignment/NewsApp/"
}


//APIEndPoints:- End Point of the api to access Specific Information.
public enum APIEndPoints: String{
    case articles                        = "articles.json"
    
}
