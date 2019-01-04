//
//  EllieSectionSelectionCollectionView.swift
//  Ellie
//
//  Created by Mar Basava on 4/14/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieSectionSelectionCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    var strings = ["COMBUSTION", "CHEMISTRY", "PHYSICS", "ASTROPHYSICS", "UNIT I", "UNIT II", "UNIT III", "VALENCE ELECTRON"]
    
    var height = CGFloat(160)
    
    lazy var collectionView: UICollectionView = {
        [weak self] in
        var cv = UICollectionView(frame: (self?.frame)!, collectionViewLayout: (self?.flowLayout)!)
        cv.delegate = self
        cv.dataSource = self
        cv.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        cv.register(EllieSectionSelectionCell.self, forCellWithReuseIdentifier: (self?.sectionCellIdentifier)!)
        cv.backgroundColor = UIColor.white
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    lazy var flowLayout:CustomViewFlowLayout = {
        var flow = CustomViewFlowLayout()
        flow.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        flow.itemSize = CGSize(width: 120, height: self.height)
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 0;
        flow.minimumLineSpacing = 0;
        return flow
    }()
    
    let sectionCellIdentifier = "sectionCell"
    var navigationController : UINavigationController!
    var sectionLabels = ["VALENCE ELECTRONS", "COMBUSTION", "AEROFLAMMATION"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.allowsMultipleSelection = false
        collectionView.isPrefetchingEnabled = false
        collectionView.isPagingEnabled = true
        
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        let a = EllieSectionPreviewView()
        
        return CGSize(width: a.viewSize.width, height: a.viewSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return sectionLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sectionCellIdentifier, for: indexPath) as? EllieSectionSelectionCell else { return UICollectionViewCell() }
        
        cell.sectionView.updateSectionLabel(string: sectionLabels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            [weak self] in
            self?.navigationController.pushViewController(HomeViewController(), animated: true)
        }

    }

}

class EllieSectionSelectionCell : UICollectionViewCell {
    
    var sectionView = EllieSectionPreviewView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        addSubview(sectionView)
        
        sectionView.easy.layout(
            Center(0.0),
            Width(sectionView.viewSize.width),
            Height(sectionView.viewSize.height)
        )

        
    }
    
}
