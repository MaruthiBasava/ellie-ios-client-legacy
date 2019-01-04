//
//  EllieBrowserFileDataModel.swift
//  Ellie
//
//  Created by Mar Basava on 10/12/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit

enum EllieFileType {
    case loading,
    image,
    audio,
    video,
    file,
    website
    
    var headerType : String {
        switch self {
        case .website: return "WEBSITE"
        case .image:   return "PICTURE"
        case .audio:   return "AUDIO"
        case .video:   return "VIDEO"
        case .file:    return "FILE"
        case .loading: return "LOADING"
        }
    }
    
    var bannerBackgroundColor: UIColor {
        switch self {
        case .website: return UIColor.EllieColors.websiteMaterialBlue
        case .image: return UIColor.EllieColors.pictureMaterialGreen
        case .audio: return UIColor.EllieColors.audioMaterialYellow
        case .video: return UIColor.EllieColors.videoMaterialRed
        case .file: return UIColor.EllieColors.fileMaterialBlue
        case .loading: return UIColor.EllieColors.flatGray
        }
    }
    
}


class EllieBrowserFileDataModel {
    
    var screenshot : UIImage?
    
    var fileLocation : URL?
    
    var finishedLoading : Bool = false {
        didSet {
            NotificationCenter.default.post(name: EllieBrowserUtilities.finishedLoading,
                                            object: nil)
        }
    }
    
    var fileName : String?
    var fileType : EllieFileType? = .loading {
        didSet {
            finishedLoading = true
        }
    }
    
    var contentType: String?
    
    var rendered = false
    
    var fileURL : String?
    
    var fileExtension : String?
    
    init ( fileURL: String ) {
        self.fileURL = fileURL
        
        initialize()
    }
    
    func initialize() {
        EllieBrowserUtilities.downloadFileFrom(fileDataModel: self)
    }
    
}

