//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation


/// NewsViewModel:-
//
class NewsViewModel: CoreDataManager, ObservableObject {
    
    @Published var articles: [Article] = [Article]()
    
    
    /// fetchNewsData:- fetch article Data from the Web service
    /// - Parameter articles: return call back of article to load the list.
    func fetchNewsData(_ articles: @escaping ([Article]) -> Void?) {
        if let url = URL(string: BaseUrl.newsApp.rawValue + APIEndPoints.articles.rawValue) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    
                    if let safeData = data {
                        do {
                            let NewsResponse = try? JSONSerialization.jsonObject(with: safeData, options: .mutableLeaves) as? [String: Any]
                            
                            if let articleList = NewsResponse?["articles"] {
                                if let articleData = try? JSONSerialization.data(withJSONObject: articleList, options: []){
                                    
                                    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context else {
                                        fatalError("Failed to retrieve managed object context")
                                    }
                                    let managedObjectContext = CoreDataManager.shared.manageObjectContext
                                    let decoder = JSONDecoder()
                                    decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                                    
                                    let results  = try decoder.decode([Article].self, from: articleData)
                                    
                                    DispatchQueue.main.async {
                                        self.articles = results
                                        articles(results)
                                    }
                                    try managedObjectContext.save()
                                }
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    
    /// filteredArticles: - filter the article when the search author name from the article and show list in specific order.
    /// - Parameters:
    ///   - searchText: search Text in the article list with the string.
    ///   - sort: sort article in the ascending and descending order.
    /// - Returns: return array of the articles.
    func filteredArticles(_ searchText: String, sort: SortType) -> [Article]?{
        return searchText.isEmpty ? self.sortArticles(articles, sort: sort) : self.sortArticles( articles.filter{ $0.author?.localizedCaseInsensitiveContains(searchText) ?? false }, sort: sort)
    }
    
    
    
    /// sortArticles:- filter the article when the  with the order and sort type.
    /// - Parameters:
    ///   - articlesToSort: on the sort array of the list and filter.
    ///   - sort: sort article in the ascending and descending order.
    /// - Returns: return array of the articles.
    func sortArticles(_ articlesToSort: [Article] , sort: SortType) -> [Article]?{
        
        return  articlesToSort.sorted(by: { (articleFirst, articleSecond) -> Bool in
            guard let firstPublish = articleFirst.publishedAt, let secondPublish = articleSecond.publishedAt else {
                
                return false
            }
            if sort == .ascending{
                
                return  firstPublish.convertStringToDate() < secondPublish.convertStringToDate()
            }else {
                return firstPublish.convertStringToDate() > secondPublish.convertStringToDate()
            }
        })
    }
    
    /// filteredLocalArticles:- filter the article when the search author name from the article and show list in specific order.
    /// - Parameters:
    ///   - articles: on the sort array of the list and filter.
    ///   - searchText: search Text in the article list with the string.
    ///   - sort: sort article in the ascending and descending order.
    /// - Returns: return array of the articles.
    func filteredLocalArticles(_ articles: [Article], _ searchText: String, sort: SortType) -> [Article]?{
        return searchText.isEmpty ? self.sortArticles(articles, sort: sort) : self.sortArticles( articles.filter{ $0.author?.localizedCaseInsensitiveContains(searchText) ?? false }, sort: sort)
    }
    
    
    
    /// fetchDataFromLocal:- Load Article from the local.
    /// - Parameters:
    ///   - searchText: search Text in the article list with the string.
    ///   - sort: sort article in the ascending and descending order.
    /// - Returns: return array of the articles.
    func fetchDataFromLocal(_ searchText: String, sort: SortType) -> [Article]? {
        
        guard let articles =  query(Article.self, search: nil, sort: nil, multiSort: nil) else { return  [Article]() }
        self.articles =  articles
        return self.filteredLocalArticles(articles, searchText, sort: sort)
    }
}


