//
//  EllieBrowserViewController.swift
//  Ellie
//
//  Created by Mar Basava on 9/1/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy
import WebKit

class EllieBrowserViewController : UIViewController {
    
    fileprivate let statusBarHeight = UIApplication.shared.statusBarFrame.height + 5
    
    fileprivate var firstDone = false
    fileprivate var isFullscreen = false
    fileprivate var nextToScrollDown = false
    fileprivate var currentAtHome = true
    fileprivate var downloadedLinks = [String()]
    
    fileprivate lazy var closeableBanner : EllieViewControllerClosableBanner = {
        let b = EllieViewControllerClosableBanner()
        b.backgroundColor = UIColor.white
        b.bannerLabel.computedText = "BROWSER"
        b.bannerLabel.textColor = UIColor.EllieColors.flatDarkGreen
        return b
    }()
    
    fileprivate lazy var searchView : EllieBrowserSearchView = {
        let view = EllieBrowserSearchView()
        view.delegate = self
        return view
    }()
    
    fileprivate lazy var bookmarkCollectionView : EllieBrowserBookmarkCollectionView = {
        let view = EllieBrowserBookmarkCollectionView()
        view.backgroundColor = UIColor.white
        view.delegate = self
        return view
    }()
    
    fileprivate lazy var bookmarkCreationView : EllieCreateBookmarkPopupView = {
        [weak self] in
        let view = EllieCreateBookmarkPopupView()
        view.height = 400
        view.delegate = self
        return view
    }()
    
    fileprivate lazy var webView : WKWebView = {
        [weak self] in
        let a = WKWebView()
        a.backgroundColor = UIColor.white
        a.isUserInteractionEnabled = true
        a.scrollView.delegate = self
        a.navigationDelegate = self
        a.uiDelegate = self
        return a
    }()
    
    fileprivate lazy var bottomBar : EllieBrowserBottomBar = {
        [weak self] in
        let a = EllieBrowserBottomBar()
        a.websiteCollection.delegate = self
        a.delegate = self
        return a
        }()
    
    override func viewDidLoad() {
        
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.white
        
        webView.addObserver(self,
                            forKeyPath: "estimatedProgress",
                            options: .new,
                            context: nil)
        
        hideKeyboardWhenTappedAround()
        initializeLayouts()
        
    }
    
    func initializeLayouts() {
        
        view.addSubview(closeableBanner)
        view.addSubview(searchView)
        view.addSubview(webView)
        view.addSubview(bookmarkCollectionView)
        view.addSubview(bottomBar)
        view.addSubview(bookmarkCreationView)
        
        closeableBanner.easy.layout(Center(0.0),
                                    Top(statusBarHeight),
                                    Left(0),
                                    Right(0),
                                    Height(closeableBanner.height))
        
        searchView.easy.layout(
            Center(0.0),
            Top(0).to(closeableBanner),
            Left(0),
            Right(0),
            Height(searchView.height))
        
        bookmarkCollectionView.easy.layout(
            Center(0.0),
            Top(0).to(searchView),
            Left(0),
            Right(0),
            Bottom(0))
        
        webView.easy.layout(
            Center(0.0),
            Top(0).to(searchView),
            Left(0),
            Right(0),
            Bottom(0))
        
        bottomBar.easy.layout(
            Center(0.0),
            Top(bottomBar.initialTop).to(webView),
            Right(0),
            Left(0),
            Height(bottomBar.height))
        
        bookmarkCreationView.easy.layout(Edges(0))
        
        bottomBar.layer.zPosition = 10
        
        postInitializationOfLayouts()
        
    }
    
    func postInitializationOfLayouts() {
        webView.load(URLRequest(url: URL(string: "http://google.com/" )!))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            searchView.progress.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    func loadByQuery(query: String) {
        let b = ("http://"+query).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        webView.load(URLRequest(url: URL( string: b!)!))
    }
    
    func validateUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url  = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    deinit {
        print("EllieBrowserViewController has been released")
    }
    
}

extension EllieBrowserViewController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
    
}

extension EllieBrowserViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
        
    }
    
    func webView(_ webView: WKWebView!, createWebViewWith configuration: WKWebViewConfiguration!, for navigationAction: WKNavigationAction!, windowFeatures: WKWindowFeatures!) -> WKWebView! {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
}

extension EllieBrowserViewController : EllieBroswerSearchViewDelegate {
    
    func search(query: String) {
        showWebView()
        
        let a = !query.contains("www.") ? "www." : ""
        
        if validateUrl(urlString: "http://"+a+query) {
            loadByQuery(query: query)
        }
        else {
            loadByQuery(query: "google.com/search?q=" + query)
        }
        
    }
    
    func showWebView() {
        
        if currentAtHome {
            bookmarkCollectionView.fadeOut()
            currentAtHome = false
        }
        
    }
    
    func home() {
        if currentAtHome == false {
            bookmarkCollectionView.fadeIn()
            currentAtHome = true
        }
        else {
            showWebView()
        }
    }
    
    func refresh() {
        showWebView()
        webView.reload()
    }
    
}

extension EllieBrowserViewController : EllieBrowserBottomBarDelegate, EllieBrowserWebsiteDownloadViewDelegate {
    
    func goForward() {
        webView.goForward()
    }
    
    func goBack() {
        webView.goBack()
    }
    
    func downloadCurrentLink() {
        
        bottomBar.websiteCollection.downloadCollectionView.performBatchUpdates({
            [weak self] in
            
            let dataModel = EllieBrowserFileDataModel(fileURL: (self?.webView.url?.absoluteString)!)
            dataModel.screenshot = self?.webView.snapshot()
            
            self?.bottomBar.websiteCollection.fileDataManager.add(website: dataModel)
            
            let indexPath = IndexPath(item: 0, section: 0)
            self?.bottomBar.websiteCollection.downloadCollectionView.insertItems(at: [indexPath])
            
        }, completion: nil)
        
    }
    
    func presentWebsiteViewController(fileDataManager: EllieBrowserFileDataManager, currentIndexPath: IndexPath) {
        let vc = EllieWebsitePreviewViewController()
        vc.fileDataManager = fileDataManager
        vc.currentIndex = currentIndexPath
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pull(to: CGFloat ) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                [weak self] in
                (self?.bottomBar)!.easy.layout(Top(to).to((self?.webView)!))
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    func bookmark() {
        let website = (webView.url?.absoluteString)!
        bookmarkCreationView.bookmarkUrlTextfield.text = website
        bookmarkCreationView.bookmarkPreviewView.bookmarkScreenShot.image = webView.snapshot()
        bookmarkCreationView.startObservation()
        bookmarkCreationView.open()
    }
    
    func toggleFullscreen() {
        DispatchQueue.main.async {
            [weak self] in
            
            if !(self?.isFullscreen)! {
                self?.closeableBanner.fadeOut()
                self?.bottomBar.fadeOut()
                
                UIView.animate(withDuration: 0.3) {
                    [weak self] in
                    (self?.searchView)!.easy.layout(Top((self?.statusBarHeight)!))
                    (self?.webView)!.easy.layout(Top(0).to((self?.searchView)!))
                    self?.view.layoutIfNeeded()
                }
                
                self?.isFullscreen = true
            }
                
            else {
                self?.closeableBanner.fadeIn()
                self?.bottomBar.fadeIn()
                
                UIView.animate(withDuration: 0.3) {
                    [weak self] in
                    (self?.searchView)!.easy.layout(Top(0).to((self?.closeableBanner)!))
                    (self?.webView)!.easy.layout(Top(0).to((self?.searchView)!))
                    self?.view.layoutIfNeeded()
                }
                
                self?.isFullscreen = false
                
            }
        }
    }
    
}

extension EllieBrowserViewController : EllieBrowserBookmarkCollectionViewDelegate {
    
    func requestLink(url: String) {
        bookmarkCollectionView.fadeOut()
        searchView.searchField.text = url
        webView.load(URLRequest(url: URL(string: url)!))
    }
    
}

extension EllieBrowserViewController : EllieBrowserBookmarkPreviewDelegate {
    
    func sendBookmarkModelData(bookmarkModel: EllieBookmarkModel) {
        bookmarkCollectionView.collectionView.performBatchUpdates({
            [weak self] in
            
            self?.bookmarkCollectionView.bookmarkDataManager.add(bookmark: bookmarkModel)
            
            let indexPath
                = IndexPath(item: (self?.bookmarkCollectionView.bookmarkDataManager
                    .getSectionSize(section: 0))! - 1, section: 0)
            self?.bookmarkCollectionView.collectionView.insertItems(at: [indexPath])
            }, completion: nil)
    }
    
}

extension EllieBrowserViewController : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView.superview)
        if nextToScrollDown && velocity.y > 0 {
            toggleFullscreen()
            nextToScrollDown = false
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.y < 0 && !nextToScrollDown{
            toggleFullscreen()
            nextToScrollDown = true
        }
    }
    
}

