//
//  EllieBookmarkDataManager.swift
//  Ellie
//
//  Created by Mar Basava on 9/10/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import UIKit

class EllieBookmarkDataManager  {
    
    fileprivate var bookmarkData : [[EllieBookmarkDataModel]] = []
    
    init() {
        setupPredata()
    }
    
    func setupPredata() {
        
        var secondRow = [EllieBookmarkDataModel]()
        secondRow.append(EllieBookmarkHeaderModel(bookmarkHeaderTitle: "BOOKMARKED"))
      
        bookmarkData.append(secondRow)
        
    }
    
    func add(bookmark: EllieBookmarkDataModel) {
        bookmarkData[0].append(bookmark)
    }
    
    func addToSection(section: Int, bookmark: EllieBookmarkModel) {
        bookmarkData[section].append(bookmark)
    }
    
    func insertIntoSection(section: Int, bookmark: EllieBookmarkModel, at: Int) {
        bookmarkData[section].insert(bookmark, at: at)
    }
    
    func getSectionHeader(of section: Int) -> EllieBookmarkDataModel {
        return bookmarkData[section][0]
    }
    
    func getAllSectionBookmarks(of section: Int) -> [EllieBookmarkDataModel] {
        return Array(bookmarkData[section].dropFirst())
    }
    
    func getBookmarkFromSection( section: Int, index: Int ) -> EllieBookmarkModel {
        return getAllSectionBookmarks(of: section)[index-1] as! EllieBookmarkModel
    }
    
    func getSize() -> Int {
        return bookmarkData.count
    }
    
    func getSectionSize(section: Int) -> Int {
        return bookmarkData[section].count
    }
    
    func removeAtSection(section: Int, index: Int) {
        bookmarkData[section].remove(at: index)
    }
    
}
