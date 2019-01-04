//
//  BookmarkModel.swift
//  Ellie
//
//  Created by Mar Basava on 9/10/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import UIKit
import FavIcon

class EllieBookmarkModel : EllieBookmarkDataModel {
    
    var bookmarkViewTitle : String!
    var bookmarkedScreenShot : UIImage?
    var bookmarkURL : String!
    
    init(bookmarkViewTitle: String, bookmarkURL: String, bookmarkedScreenShot : UIImage) {
        super.init()
        self.bookmarkViewTitle = bookmarkViewTitle
        self.bookmarkURL = bookmarkURL
        self.bookmarkedScreenShot = bookmarkedScreenShot
    }
    
}
