//
//  EllieBrowserWebsiteDownloadCollectionView.swift
//  Ellie
//
//  Created by Mar Basava on 9/4/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy
import UIImageViewAlignedSwift

protocol EllieBrowserWebsiteDownloadViewDelegate : class {
    func presentWebsiteViewController(fileDataManager: EllieBrowserFileDataManager, currentIndexPath: IndexPath)
}

class EllieBrowserWebsiteDownloadView: EllieRoundedView {
    
    
    var fileDataManager = EllieBrowserFileDataManager()
    
    var height : CGFloat = 130
    fileprivate let websiteDownloadCellIdentifier = "WebsiteDownloadCell"
    
    weak var delegate : EllieBrowserWebsiteDownloadViewDelegate?
    
    lazy var flowLayout : UICollectionViewFlowLayout = {
        [weak self] in
        let a = UICollectionViewFlowLayout()
        a.scrollDirection = .horizontal
        a.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return a
        
        }()
    
    lazy var downloadCollectionView : UICollectionView = {
        [weak self] in
        let a = UICollectionView(frame: (self?.frame)! , collectionViewLayout: (self?.flowLayout)!)
        a.register(EllieWebsiteDownloadCell.self, forCellWithReuseIdentifier: (self?.websiteDownloadCellIdentifier)!)
        a.delegate = self
        a.dataSource = self
        a.backgroundColor = .white
        a.showsHorizontalScrollIndicator = false
        return a
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 0
        layer.shadowRadius = 2
        
        initializeLayouts()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        addSubview(downloadCollectionView)
        
        downloadCollectionView.easy.layout(
            Center(0.0),
            Edges(0)
        )
        
    }
    
}

class EllieWebsiteDownloadCell : UICollectionViewCell {
    
    weak var currentDataModel : EllieBrowserFileDataModel?
    
    lazy var disabledCellView : EllieRoundedView = {
        let view = EllieRoundedView()
        view.backgroundColor = UIColor.EllieColors.flatAuqaBlue
        return view
    }()
    
    lazy var contentBanner : EllieContentViewBanner = {
        let a = EllieContentViewBanner()
        return a
    }()
    
    lazy var contentScrenshot : UIImageViewAligned = {
        [weak self] in
        let a = UIImageViewAligned()
        a.contentMode = .scaleAspectFill
        a.alignTop = true
        a.clipsToBounds = true
        
        return a
        }()
    
    lazy var cellContentView : EllieRoundedView = {
        let view = EllieRoundedView()
        return view
    }()
    
    var currentLink = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shouldRasterize = true;
        layer.rasterizationScale = UIScreen.main.scale;
        
        
        initializeLayouts()
        
        print("WOWO OK WOWOW OK \(currentDataModel?.rendered)")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        addSubview(cellContentView)
        cellContentView.addSubview(contentScrenshot)
        cellContentView.addSubview(contentBanner)
        cellContentView.addSubview(disabledCellView)
        
        cellContentView.easy.layout(Edges(0))
        
        contentBanner.easy.layout(
            Center(0.0),
            Top(0),
            Left(0),
            Right(0),
            Height(contentBanner.height))
        
        contentScrenshot.easy.layout(
            Top(0).to(contentBanner),
            Left(0),
            Right(0),
            Bottom(0))
        
        disabledCellView.easy.layout(Edges(0))
        
        postInitializationOfLayouts()
    }
    
    func postInitializationOfLayouts() {
        
        disable()
        
    }
    
    
    func initialize(currentDataModel: EllieBrowserFileDataModel) {
        print("it got into the init")
        self.currentDataModel = currentDataModel
        
        guard currentDataModel.rendered
            else {
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(renderCellContent),
                                                       name: EllieBrowserUtilities.finishedLoading,
                                                       object: nil)
                return
        }
        
        renderCellContent()
        
    }
    
    func renderCellContent() {
        
        DispatchQueue.main.async {
            [weak self] in
            
            print("Hello everybody my fDASKJJLSJDLJKLDJKASJKDLJSALKriend is gurd")
            
            guard let materialType = self?.currentDataModel?.fileType
                else { return }
            
            self?.contentBanner.bannerLabel.computedText = materialType.headerType
            self?.contentBanner.backgroundColor = materialType.bannerBackgroundColor
            self?.contentScrenshot.image = self?.currentDataModel?.screenshot
            
        }
        
        if !(currentDataModel?.rendered)! {
            NotificationCenter.default.removeObserver(self)
            currentDataModel?.rendered = true
        }
        
        enable()
        
    }
    
    func disable() {
        DispatchQueue.main.async {
            [weak self] in
            UIView.animate(withDuration: 0.3) {
                self?.disabledCellView.alpha = 0.5
            }
            self?.isUserInteractionEnabled = false
        }
    }
    
    func enable() {
        DispatchQueue.main.async {
            [weak self] in
            UIView.animate(withDuration: 0.3) {
                [weak self] in
                self?.disabledCellView.alpha = 0
            }
            
            self?.isUserInteractionEnabled = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}


extension EllieBrowserWebsiteDownloadView : UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension EllieBrowserWebsiteDownloadView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: websiteDownloadCellIdentifier, for: indexPath)
            as? EllieWebsiteDownloadCell
            else { return UICollectionViewCell() }
        
        cell.initialize(currentDataModel:  fileDataManager.get(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fileDataManager.getSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if delegate != nil {
            delegate?.presentWebsiteViewController(fileDataManager: fileDataManager, currentIndexPath: indexPath)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
    }
    
}

extension EllieBrowserWebsiteDownloadView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}



