//
//  StringExtension+DateConvertable.swift
//  NewsApp
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

// String: Extension to perform Operation on the String.
extension String {
    
    //convertStringToDate:- Convert String into Date and return a date.
    func convertStringToDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter.date(from: self) ?? Date()
    }
}
