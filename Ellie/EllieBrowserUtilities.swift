//
//  EllieBrowserUtilities.swift
//  Ellie
//
//  Created by Mar Basava on 9/11/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import WebKit

class EllieBrowserUtilities {

    static var finishedLoading = Notification.Name(rawValue: "io.9978.ellie.finishedLoading")

    fileprivate static var websiteContentType = ["text/html" : ".html"]
    fileprivate static var videoContentType = ["video/quicktime": ".move", "video/mp4" : ".mp4", "video/mpeg": ".mp4","video/webm": ".webm"]
    fileprivate static var audioContentType = ["audio/mpeg": ".mp3"]
    fileprivate static var pictureContentType = ["image/gif" : ".gif", "image/jpeg" : ".jpg", "image/png" : ".png"]
    fileprivate static var fileContentType = ["application/msword" : ".doc",
                                              "application/pdf" : ".pdf",
                                              "application/vnd.openxmlformats-officedocument.wordprocessingml.document" : ".docx",
                                              "application/vnd.openxmlformats-officedocument.wordprocessingml.template" : ".dotx",
                                              "application/vnd.ms-word.document.macroEnabled.12" : ".docm",
                                              "application/vnd.ms-word.template.macroEnabled.12" : ".dotm",
                                              "application/vnd.ms-excel": ".xls",
                                              "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" : ".xlsx",
                                              "application/vnd.openxmlformats-officedocument.spreadsheetml.template": ".xltx",
                                              "application/vnd.ms-excel.sheet.macroEnabled.12" : ".xlsm",
                                              "application/vnd.ms-excel.template.macroEnabled.12" : ".xltm",
                                              "application/vnd.ms-excel.addin.macroEnabled.12" : ".xlam",
                                              "application/vnd.ms-excel.sheet.binary.macroEnabled.12" : ".xlsb",
                                              "application/vnd.ms-powerpoint" : ".ppt",
                                              "application/vnd.openxmlformats-officedocument.presentationml.presentation" : ".pptx",
                                              "application/vnd.openxmlformats-officedocument.presentationml.template" : ".potx",
                                              "application/vnd.openxmlformats-officedocument.presentationml.slideshow" : ".ppsx",
                                              "application/vnd.ms-powerpoint.addin.macroEnabled.12" : ".ppam",
                                              "application/vnd.ms-powerpoint.presentation.macroEnabled.12":".pptm",
                                              "application/vnd.ms-powerpoint.template.macroEnabled.12": ".potm",
                                              "application/vnd.ms-powerpoint.slideshow.macroEnabled.12" : ".ppsm",
                                              "application/x-iwork-pages-sffpages" : ".pages"]
    
    class var allContentTypes : [String: String] {
        get {
            var dictionary = [String: String]()
   
            websiteContentType.forEach { dictionary[$0] = $1 }
            videoContentType.forEach { dictionary[$0] = $1 }
            pictureContentType.forEach { dictionary[$0] = $1 }
            fileContentType.forEach { dictionary[$0] = $1 }
            audioContentType.forEach { dictionary[$0] = $1 }
            
            return dictionary
        }
    }
    
    class func getFileType(contentType: String) -> EllieFileType {
        
        print("Is it coming here?")
        
        if let _ = fileContentType[contentType] {
            print("FILE \(contentType)")
            return .file
        }
        
        if let _ = pictureContentType[contentType] {
            print("PICTURE \(contentType)")
            return .image
        }
        
        if let _ = videoContentType[contentType] {
            print("VIDEO \(contentType)")
            return .video
        }
        
        if let _ = audioContentType[contentType] {
            print("AUDIO \(contentType)")
            return .audio
        }
        
        if  let _ = websiteContentType[contentType] {
            print("WEBSITE \(contentType)")
            return .website
        }
        
        print("NONE \(contentType)")
        return .loading
        
    }
    
    class func downloadFileFrom(fileDataModel : EllieBrowserFileDataModel) {
        
        guard let urlPath = fileDataModel.fileURL
            else { return }
        
        getWebViewContentType(urlPath: urlPath) {
            (type) in
            print("hedsadsadllo")
            print(type)
            
            if let _ = EllieBrowserUtilities.allContentTypes[type] {
                print("IT GOT IN ALL CONTENT TYPE")
                let pathUrl = URL(string: urlPath)
                
                fileDataModel.contentType = type
                fileDataModel.fileExtension = allContentTypes[type]
                fileDataModel.fileType = getFileType(contentType: type)
        
                if fileDataModel.fileType == .website {
                        parseHTMLtoText(pathURL: pathUrl!, fileDataModel: fileDataModel)
                    return
                }
                
                downloadFile(fileDataModel : fileDataModel)
            }
        }
        
    }
    
    private class func parseHTMLtoText(pathURL: URL, fileDataModel : EllieBrowserFileDataModel) {
        
        do {
           let parsedMarkup = try String(contentsOf: pathURL, encoding: .utf8)
           
            if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                
                let fileName = returnUniqueFileName(length: 10, fileExtension: fileDataModel.fileExtension!)
                let fileLocation = directory.appendingPathComponent(fileName)
                
                fileDataModel.fileName = fileName
                fileDataModel.fileLocation = fileLocation

                try parsedMarkup.write(to: fileLocation, atomically: false, encoding: .utf8)
            }
            
        }
        catch { }
    }
    
    private class func getWebViewContentType(urlPath: String, completion: @escaping (_ type: String)->()) {
        if let url = URL(string: urlPath) {
            var request = URLRequest(url: url)
            request.httpMethod = "HEAD"
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse, error == nil {
                    if let ct = httpResponse.allHeaderFields["Content-Type"] as? String {
                        let refinedContentType = ct.components(separatedBy: ";")
                        completion(refinedContentType[0])
                    }
                }
            }.resume()
        }
    }
    
    private class func downloadFile(fileDataModel : EllieBrowserFileDataModel) {
        
        let urlPath = fileDataModel.fileURL!
        let url = URL(string: urlPath)!
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error == nil {
                var fileLocation = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).last
                
                fileDataModel.fileLocation = fileLocation
                
                let fileName =  returnUniqueFileName(length: 10, fileExtension: fileDataModel.fileExtension!)
                
                fileDataModel.fileName = fileName
                fileLocation = fileLocation?.appendingPathComponent(fileName)
                
                do {
                    if let dat = data {
                        try dat.write(to: fileLocation!)
                    }
                }
                catch let erro {
                    print(erro)
                }
                
            }
            
            }.resume()
        
    }
    
    class func returnUniqueFileName(length: Int, fileExtension: String) -> String {
        let generatedString = randomStringGenerator(length: length) + fileExtension
        if validateFileExistance(fileName: generatedString) {
            return returnUniqueFileName(length: length, fileExtension: fileExtension)
        }
        return generatedString
    }
    
    class func validateFileExistance(fileName: String) -> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let url = URL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent(fileName).path
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    class func randomStringGenerator(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    class func getFile(fileDataModel : EllieBrowserFileDataModel) -> URL? {
        var content : [URL]?
        do {
            if let location = fileDataModel.fileLocation {
                content = try FileManager.default
                    .contentsOfDirectory(at: location,
                                         includingPropertiesForKeys: nil,
                                         options: .skipsHiddenFiles)
                    .filter {
                        $0.absoluteString
                            .contains(fileDataModel.fileName!)
                }
                print(content![0])
            }
        }
        catch let error { print(error) }
        return content?[0]
    }
    
    class func isInternetAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
}
