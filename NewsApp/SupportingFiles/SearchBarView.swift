//
//  SearchBarView.swift
//  NewsApp
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Apple. All rights reserved.
//


import SwiftUI

//MARK: SearchBar:- Implementing Search Bar for fill data from  list  and show on the Screen.
struct SearchBarView: UIViewRepresentable{
    
    //MARK: Properties
    
    ///searchText:-  capture  a text from the search  textfield and filter list data on the basis of Text.
    @Binding var searchText: String
    
    var returnKeyAction: ((_ keyType: UIReturnKeyType) -> Void)?

    let returnKeyType: UIReturnKeyType? = .search

    ///placeHolder:- when nothing happen on the SearchField  or when it show first time a place holder is occupies to understanding about the search.
    var placeHolder: String
    
    //Coordinator:- it contains method of Searching and filtration Delegate from the content List.
    //Extend NSObject to utilise the method of Object and Event Of object.
    //UISearchBarDelegate: to implement method of Search Delegate & utilise native features of Search bar.
    class Coordinator: NSObject, UISearchBarDelegate{
        
        //text: it store searched data when something is add and update on the search field.
        @Binding var text: String
        
        //Initialising:- Using the property Wrapper ans update searched value using Binding property.
        
        // Initialising
        /// - Parameter text: capture  a text from the search  textfield and filter list data on the basis of Text.
        init(text: Binding<String>) {
            _text = text
        }
        
        //MARK: searchBar
        /// - Parameters:
        ///   - searchBar: Delegate method of search bar when something is changed on the search field.
        ///   - searchText:  capture  a text from the search  textfield and filter list data on the basis of Text.
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            
            text = ""
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }
       
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }
        
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            self.returnKeyAction?(searchBar.returnKeyType)
    }
        
    

        
    }
    
    //makeCoordinator:-  cordinator to cordinate the data from the list and filter list according to the text entered in search field through the properties Wrapper and return the  searched Text for matching in the data list.
    
    func makeCoordinator() -> SearchBarView.Coordinator {
        return Coordinator(text: $searchText)
    }
    
    //makeUIView:- Search bar UI representation using the context, how it will show on the UX or in the side the scree.
    // used properties place holder to show place holder on the serach TextField.
    //Stop the auto captilization type from the Keyboard.
    // Implement Search Bar bar Style, how to represent on the Screen.
    // return search bar
    
    
    // makeUIView
    /// - Parameter context: Search bar UI representation using the context, how it will show on the UX or in the side the screen.
    /// used properties place holder to show place holder on the serach TextField.
    ///Stop the auto captilization type from the Keyboard.
    /// Implement Search Bar bar Style, how to represent on the Screen.
    /// return search bar
    func makeUIView(context: UIViewRepresentableContext<SearchBarView>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeHolder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.returnKeyType = returnKeyType ?? UIReturnKeyType.search
        return searchBar
    }
    
    // updateUIView
    /// - Parameters:
    ///   - uiView: Representation of the Search Bar on the Scree when screen apears  and the position of the search bar .
    ///   - context: Search bar UI representation using the context, how it will show on the UX or in the side the screen.
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBarView>) {
        uiView.text = searchText
    }
}
