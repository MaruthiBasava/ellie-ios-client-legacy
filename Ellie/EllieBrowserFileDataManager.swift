//
//  EllieBrowserFileDataManager.swift
//  Ellie
//
//  Created by Mar Basava on 10/14/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import UIKit

class EllieBrowserFileDataManager {
    
    fileprivate var fileData : [EllieBrowserFileDataModel] = []
    
    init () {
        
    }
    
    func add(website: EllieBrowserFileDataModel) {
        fileData.insert(website, at: 0)
    }
    
    func get(index: Int) -> EllieBrowserFileDataModel {
        return fileData[index]
    }
    
    func getSize() -> Int {
        return fileData.count
    }
    
    func print() {
        for i in fileData {
            Swift.print(i.fileURL!)
        }
    }
    
    func receieveDataModelWhenFinished(index: Int, completion: (_ model: EllieBrowserFileDataModel) -> Void ) {

    }
    
}
