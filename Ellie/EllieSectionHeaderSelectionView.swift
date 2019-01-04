//
//  EllieSectionHeaderSelectionView.swift
//  Ellie
//
//  Created by Mar Basava on 4/10/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieSectionHeaderSelectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var headerPreview : EllieHeaderSelectionPreviewView!
    
    var strings = ["COMBUSTION", "CHEMISTRY", "PHYSICS", "ASTROPHYSICS", "UNIT I", "UNIT II", "UNIT III"]
    
    lazy var collectionView: UICollectionView = {
        var cv = UICollectionView(frame: self.frame, collectionViewLayout: self.flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        cv.register(EllieSectionSliderCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = UIColor.white
        cv.showsHorizontalScrollIndicator = false

        return cv
    }()
    
    lazy var flowLayout:UICollectionViewFlowLayout = {
        var flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsetsMake(2.0, 15.0, 2.0, 15.0)
        flow.itemSize = CGSize(width: 140, height: 60)
        flow.scrollDirection = .horizontal
        return flow
    }()
    
    let sectionHeaderCellIdentifier = "sectionHeaderCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.allowsMultipleSelection = false
        collectionView.isPrefetchingEnabled = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize.init(width: 0, height: 0)
        
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        let width:CGFloat = frame.size.width * 0.98;
        let height:CGFloat = 150.0;
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return strings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EllieSectionSliderCell
            else { return UICollectionViewCell() }
        
//        cell.sectionLabel.addCharactersSpacing(spacing: EllieConstants.labelSpacing, text: strings[indexPath.row])

//        guard cell.isSelected
//            else {
//                cell.sectionHeaderView.backgroundColor = UIColor.EllieColors.flatMedimumBlack
//                return cell
//            }
        
        if cell.isSelected {
            cell.sectionHeaderView.backgroundColor = UIColor.EllieColors.flatDarkGreen
        }
        else {
            cell.sectionHeaderView.backgroundColor = UIColor.EllieColors.flatMedimumBlack
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EllieSectionSliderCell
            else { return }
        
        cell.sectionHeaderView.backgroundColor = UIColor.EllieColors.flatDarkGreen
//        headerPreview.sectionLabel.addCharactersSpacing(spacing: EllieConstants.labelSpacing, text: strings[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EllieSectionSliderCell
            else { return }

        cell.sectionHeaderView.backgroundColor = UIColor.EllieColors.flatMedimumBlack
    }
    
}

class EllieSectionSliderCell : UICollectionViewCell {

    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        
        sectionHeaderView.addSubview(sectionLabel)
        addSubview(sectionHeaderView)
     
        sectionHeaderView.easy.layout(
            Center(0.0),
            Width(139),
            Height(35)
)
        
        sectionLabel.easy.layout(
            Center(0.0)
)
        
    }
    
    lazy var sectionHeaderView : EllieRoundedView = {
        let view = EllieRoundedView()
        view.backgroundColor = UIColor.EllieColors.flatMedimumBlack
        
        view.layer.cornerRadius = 17
        
        return view
    }()
    
    lazy var sectionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: WideFonts.glacialIndifferenceBold, size: 10)
        label.textAlignment = .center
        label.textColor = UIColor.white
//        label.addCharactersSpacing(spacing: EllieConstants.labelSpacing, text: "COMBUSTION")
        
        return label
    }()
}
