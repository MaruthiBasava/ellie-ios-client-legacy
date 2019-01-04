//
//  EllieSectionSliderView.swift
//  Ellie
//
//  Created by Mar Basava on 4/13/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieSectionSliderView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    var strings = ["COMBUSTION", "CHEMISTRY", "PHYSICS", "ASTROPHYSICS", "UNIT I", "UNIT II", "UNIT III", "VALENCE ELECTRON"]
    
    var height = CGFloat(145)
    
    lazy var collectionView: UICollectionView = {
        var cv = UICollectionView(frame: self.frame, collectionViewLayout: self.flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        cv.register(EllieSectionHeaderSelectionCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = UIColor.white
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    lazy var flowLayout:CustomViewFlowLayout = {
        var flow = CustomViewFlowLayout()
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flow.itemSize = CGSize(width: 140, height: self.height)
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 0;
        flow.minimumLineSpacing = 0;
        return flow
    }()
    
    let sectionHeaderCellIdentifier = "sectionSliderCell"
    
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
        
        let width:CGFloat = frame.size.width-1;
        let height:CGFloat = frame.size.height-1;
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return strings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EllieSectionHeaderSelectionCell
            else { return UICollectionViewCell() }
        
//        cell.sectionLabel.addCharactersSpacing(spacing: 2.2, text: strings[indexPath.row])
        
        return cell
    }
    
}

class EllieSectionHeaderSelectionCell : UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        coloredView.addSubview(sectionLabel)
        sectionFirstImage.addSubview(coloredView)
        addSubview(sectionFirstImage)
        
        sectionFirstImage.easy.layout(
            Center(0.0),
            Top(0),
            Left(0),
            Right(0),
            Bottom(0)
)
        
        sectionLabel.easy.layout(
            Center(0.0)
)
        
        coloredView.easy.layout(
            Center(0.0),
            Top(0),
            Left(0),
            Right(0),
            Bottom(0)
)
        
    }
    
    lazy var sectionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: WideFonts.glacialIndifferenceBold, size: 17)
        label.textAlignment = .center
        label.textColor = UIColor.white
//        label.addCharactersSpacing(spacing: 2.2, text: "COMBUSTION")
        
        return label
    }()
    
    lazy var sectionFirstImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "download-")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var coloredView : UIView = {
        let view = UIView()
        let b = UIColor.EllieColors.flatDarkGreen
        view.backgroundColor = b
        return view
    }()
}

class CustomViewFlowLayout : UICollectionViewFlowLayout {
    
    let cellSpacing:CGFloat = 0
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let attributes = super.layoutAttributesForElements(in: rect) {
            for (index, attribute) in attributes.enumerated() {
                if index == 0 { continue }
                let prevLayoutAttributes = attributes[index - 1]
                let origin = prevLayoutAttributes.frame.maxX
                if(origin + cellSpacing + attribute.frame.size.width < self.collectionViewContentSize.width) {
                    attribute.frame.origin.x = origin + cellSpacing
                }
            }
            return attributes
        }
        return nil
    }
}
