//
//  Article+CoreDataClass.swift
//  NewsApp
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Apple. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject, Codable, Identifiable {
    
    public var id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case title = "title"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case descriptionField = "description"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Article", in: managedObjectContext)
            else {
                fatalError("decode failure")
                
        }
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            author = try values.decodeIfPresent(String.self, forKey: .author)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            url = try values.decodeIfPresent(String.self, forKey: .url)
            urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage)
            publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
            descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        } catch {
            print ("Article  Encoding error")
        }
    }

    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encodeIfPresent(author ?? "", forKey: .author)
            try container.encodeIfPresent(title ?? "", forKey: .title)
            try container.encodeIfPresent(url ?? "", forKey: .url)
            try container.encodeIfPresent(urlToImage ?? "", forKey: .urlToImage)
            try container.encodeIfPresent(publishedAt ?? "" , forKey: .publishedAt)
            try container.encodeIfPresent(descriptionField ?? "" , forKey: .descriptionField)
        } catch {
            print("Article  Encoding error")
        }
    }
}




