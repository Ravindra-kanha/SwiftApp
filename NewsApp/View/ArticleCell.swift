//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct ArticleCell: View {

    //MARK: Properties
    
    // article:- show article in the list.
    var article: Article?
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 12){
            ///Load image from the image url
            RemoteImageView(urlString: article?.urlToImage ?? "", width: 70)
                .clipShape(Circle())
                .shadow(color: .gray, radius: 2, x: 1, y: 0)
            // show the name of the author and title of article.
            VStack(alignment: .leading, spacing: 8) {
                Text(article?.author ?? "").bold()
                Text(article?.title ?? "").font(.system(.footnote))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCell()
    }
}




