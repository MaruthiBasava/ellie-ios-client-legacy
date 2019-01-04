//
//  EllieWebsitePreviewViewController.swift
//  Ellie
//
//  Created by Mar Basava on 10/11/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy
import SystemConfiguration
import WebKit

class EllieWebsitePreviewViewController: UIViewController {
    
    fileprivate let cellIdentifier = "websitePreviewCell"
    fileprivate var hasShown = false
    
    weak var currentWebsiteDataModel : EllieBrowserFileDataModel?
    weak var fileDataManager: EllieBrowserFileDataManager?
    
    var currentIndex : IndexPath?
    
    lazy var closeButton : EllieImageButton = {
        let a = EllieImageButton()
        a.buttonImage.image = UIImage(named: WideImages.closeimageView)
        a.appendTarget(target: self, selector: #selector(closeView))
        return a
    }()
    
    lazy var collectionViewLayout : UICollectionViewFlowLayout = {
        [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
        }()
    
    lazy var collectionView : UICollectionView = {
        [weak self] in
        let collectionView = UICollectionView(frame: (self?.view.frame)!,
                                              collectionViewLayout: (self?.collectionViewLayout)!)
        collectionView.register(EllieWebsitePreviewCollectionViewCell.self,
                                forCellWithReuseIdentifier: (self?.cellIdentifier)!)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = currentWebsiteDataModel?.fileType?.bannerBackgroundColor
        initializeLayouts()
    }
    
    @objc fileprivate func closeView() {
        navigationController?.popViewController(animated: true)
        hasShown = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initializeLayouts() {
        
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        
        collectionView.easy.layout(Top(0), Left(0), Right(0), Bottom(0))
        
        closeButton.easy.layout(Top(EllieConstants.statusBarHeight - 5),
                                Right(5),
                                Width(40),
                                Height(40))
        
    }
    
    deinit {
        print("EllieWebsitePreviewViewController has been released")
    }
    
}

class EllieWebsitePreviewCollectionViewCell : UICollectionViewCell {
    
    weak var currentWebsiteDataModel : EllieBrowserFileDataModel?
    
    fileprivate lazy var banner : EllieViewControllerBanner = {
        let banner = EllieViewControllerBanner()
        banner.bannerLabel.textColor = .white
        return banner
    }()
    
    lazy var progress: UIProgressView = {
        let a = UIProgressView()
        a.trackTintColor = UIColor.EllieColors.flatGray
        a.setProgress(0.0, animated: false)
        return a
    }()
    
    fileprivate lazy var webView : WKWebView = {
        [weak self] in
        let a = WKWebView()
        a.backgroundColor = UIColor.white
        a.isUserInteractionEnabled = true
        a.scrollView.bounces = false
        a.uiDelegate = self
        a.navigationDelegate = self
        return a
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        layer.shouldRasterize = true;
        layer.rasterizationScale = UIScreen.main.scale;
        
        
        webView.addObserver(self,
                            forKeyPath: "estimatedProgress",
                            options: .new,
                            context: nil)
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initializeLayouts() {
        
        addSubview(banner)
        addSubview(progress)
        addSubview(webView)
        
        banner.easy.layout(Top(EllieConstants.statusBarHeight),
                           Left(0),
                           Right(0),
                           Height(banner.height))
        
        progress.easy.layout(Top(0).to(banner), Right(0), Left(0))
        
        webView.easy.layout(Top(0).to(progress),
                            Left(0),
                            Right(0),
                            Bottom(0))
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progress.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    func initialize(currentWebsiteDataModel: EllieBrowserFileDataModel) {
        
        self.currentWebsiteDataModel = currentWebsiteDataModel
        
        DispatchQueue.main.async {
            [weak self] in
            let currentDataModelFileType = self?.currentWebsiteDataModel?.fileType
            let bannerBackgroundColor = currentDataModelFileType?.bannerBackgroundColor
            self?.banner.bannerLabel.computedText = (currentDataModelFileType?.headerType)!
            
            self?.progress.progressTintColor = bannerBackgroundColor
            self?.banner.backgroundColor = bannerBackgroundColor
            self?.backgroundColor = bannerBackgroundColor
        }
        
        if EllieBrowserUtilities.isInternetAvailable() {
            let url = URL(string: currentWebsiteDataModel.fileURL!)
            let request = URLRequest(url: url!)
            webView.load(request)
        }
        else {
            loadDocument()
        }
    }
    
    fileprivate func loadDocument() {
        
        if currentWebsiteDataModel?.fileType == .website {
            do {
                let markup = try String(contentsOf: (currentWebsiteDataModel?.fileLocation)!, encoding: .utf8)
                webView.loadHTMLString(markup, baseURL: nil)
            }
            catch { }
        }
        
        guard let p_directoryURL = EllieBrowserUtilities.getFile(fileDataModel: currentWebsiteDataModel!)
            else { return }
        
        webView.loadFileURL(p_directoryURL, allowingReadAccessTo: p_directoryURL)
        
    }
    
}

extension EllieWebsitePreviewCollectionViewCell: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
        
    }
    
    func webView(_ webView: WKWebView!, createWebViewWith configuration: WKWebViewConfiguration!, for navigationAction: WKNavigationAction!, windowFeatures: WKWindowFeatures!) -> WKWebView! {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            if !EllieBrowserUtilities.isInternetAvailable(){
                decisionHandler(WKNavigationActionPolicy.cancel)
                return
            }
            
        }

        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
}

extension EllieWebsitePreviewViewController : UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension EllieWebsitePreviewViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? EllieWebsitePreviewCollectionViewCell
            else { return UICollectionViewCell() }
        
        cell.initialize(currentWebsiteDataModel: (fileDataManager?.get(index: indexPath.row))!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let items = fileDataManager?.getSize()
            else { return 0 }
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !hasShown {
            fileDataManager?.print()
            collectionView.scrollToItem(at: currentIndex!, at: .left, animated: false)
            hasShown = true
        }
    }
    
}

extension EllieWebsitePreviewViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height+5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -EllieConstants.statusBarHeight, left: 0, bottom: 0, right: 0)
    }
    
}

