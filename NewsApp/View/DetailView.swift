//
//  DetailView.swift
//  NewsApp
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI


protocol feedBack: AnyObject{
    
}

struct DetailView: View {
    
    let url: String

    var body: some View {
        WebView(link: url, didFinishLoading: false)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com")
    }
}

