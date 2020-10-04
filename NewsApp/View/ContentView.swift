//
//  ContentView.swift
//  NewsApp
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    //MARK: Properties
    
    // viewModel:  Handle News Business Logic via News View Model.
    @ObservedObject var viewModel = NewsViewModel()
    
    // searchText: Search Text in the Search bar and filter the List.
    @State var searchText: String = ""
    
    // Sort:- Sort articles in the order of descending & ascending.
    @State var sort: SortType = .descending
    
    //articles:-  articles from the Web-service.
    @State var articles: [Article] = [Article]()
    
    //body
    var body: some View {
        
        
        NavigationView {
            VStack{
                // Search  bar o for searching the filter in the list.
                SearchBarView(searchText: self.$searchText, placeHolder: "Search by author/publisher")
                    .padding([.leading, .trailing], 10)
                // List
                // show filter and and search text.
                List(self.viewModel.filteredArticles(self.searchText, sort: sort) ?? [Article]()) { article in
                    
                    NavigationLink(destination: DetailView(url: article.url ?? "")) {
                        ArticleCell(article: article)
                    }
                }
            }
            .navigationBarTitle("News App")
            .navigationBarItems(trailing: sortArticle)
        }
            
            
        .onAppear(perform: {
            DispatchQueue.main.async {
                // to check internet Connectivity
                guard Reachability.isConnectedToNetwork() == true else{
                    // load article list from the local storage with the specific author
                    self.articles = self.viewModel.fetchDataFromLocal(self.searchText, sort: self.sort) ?? [Article]()
                    return
                }
                // load Article from the  web Service.
                self.viewModel.fetchNewsData({ (articles) in
                    self.articles = articles
                })
            }
        })
    }
    
    // sortArticle
    var sortArticle: some View {
        Button(action: {
            self.sort = self.sort == .ascending ? .descending : .ascending
            self.articles =  self.viewModel.filteredArticles(self.searchText, sort: self.sort) ?? [Article]()
        }) {
            Image(systemName: "arrow.up.arrow.down.square.fill")
                .resizable()
                .frame(width: 32, height: 32)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

