//
//  EllieBrowserBookmarkCollectionView.swift
//  Ellie
//
//  Created by Mar Basava on 9/9/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy
import FavIcon

protocol EllieBrowserBookmarkCollectionViewDelegate : class {
    func requestLink(url: String)
}

class EllieBrowserBookmarkCollectionView: EllieRoundedView {
    
    fileprivate let cellIdentifier = "bookmarkCell"
    fileprivate let headerIdentifier = "bookmarkHeader"
    
    fileprivate var cellWidth : CGFloat = 85
    fileprivate var cellHeight : CGFloat = 120
    
    fileprivate let headerHeight : CGFloat = 40
    fileprivate let leftRightInset : CGFloat = 19
    
    fileprivate let numberOfItemsPerRow : CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 3 : 4
    
    fileprivate var longPressGesture : UILongPressGestureRecognizer?
    
    var bookmarkDataManager = EllieBookmarkDataManager()
    
    weak var delegate : EllieBrowserBookmarkCollectionViewDelegate?
    
    lazy var bookmarkCollectionLayout : UICollectionViewFlowLayout = {
        [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
        }()
    
    lazy var collectionView : UICollectionView = {
        [weak self] in
        let collectionView = UICollectionView(frame: (self?.frame)!,
                                              collectionViewLayout: (self?.bookmarkCollectionLayout)!)
        collectionView.register(EllieBrowserBookmarkedCollectionViewCell.self,
                                forCellWithReuseIdentifier: (self?.cellIdentifier)!)
        collectionView.register(EllieBrowserBookmarkHeaderCollectionViewCell.self,
                                forCellWithReuseIdentifier: (self?.headerIdentifier)!)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        return collectionView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(gesture:)))
//        collectionView.addGestureRecognizer(longPressGesture!)
        
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initializeLayouts() {
        addSubview(collectionView)
        
        collectionView.easy.layout(
            Edges(0)
)
        
        postLayoutInitalization()
    }
    
    func postLayoutInitalization() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            [weak self] in
            self?.collectionView.reloadData()
        })
        
    }
    
    func validateDelegate() -> Bool {
        return delegate != nil
    }
    
    func handleLongPressGesture (gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView))
                else { break }
            
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
}

extension EllieBrowserBookmarkCollectionView : UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return bookmarkDataManager.getSize()
    }
    
}

extension EllieBrowserBookmarkCollectionView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return ( indexPath.row == 0
            ? generateBookmarkCollectionViewHeader(indexPath: indexPath)
            : generateBookmarkCollectionViewCell(indexPath: indexPath))
    }
    
    func generateBookmarkCollectionViewHeader(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerIdentifier, for: indexPath)
            as? EllieBrowserBookmarkHeaderCollectionViewCell
            else { return UICollectionViewCell() }
        
        guard let headerDataModel = bookmarkDataManager.getSectionHeader(of: indexPath.section)
            as? EllieBookmarkHeaderModel
            else { return UICollectionViewCell() }
        
        cell.bookmarkHeader.text = headerDataModel.bookmarkHeaderTitle
        cell.bookmarkHeader.addCharactersSpacing(spacing: EllieConstants.labelSpacing2p24)
        
        return cell
    }
    
    func generateBookmarkCollectionViewCell(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            as? EllieBrowserBookmarkedCollectionViewCell
            else { return UICollectionViewCell() }
        
        guard let bookmarkDataModel = bookmarkDataManager.getAllSectionBookmarks(of: indexPath.section)[indexPath.row-1]
            as? EllieBookmarkModel
            else { return UICollectionViewCell() }
        
        cell.bookmarkedWebsiteTitle.text = bookmarkDataModel.bookmarkViewTitle
        cell.bookmarkedWebsiteTitle.addCharactersSpacing(spacing: EllieConstants.labelSpacing0p69)
        cell.bookmarkScreenShot.image = bookmarkDataModel.bookmarkedScreenShot
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarkDataManager.getSectionSize(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard indexPath.row != 0
            else { return }
        
        guard let bookmarkCellDataModel = bookmarkDataManager.getAllSectionBookmarks(of: indexPath.section)[indexPath.row - 1]
            as? EllieBookmarkModel
            else { return }
        
        if validateDelegate() {
            delegate?.requestLink(url: bookmarkCellDataModel.bookmarkURL)
        }
        
    }
    
}

extension EllieBrowserBookmarkCollectionView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (indexPath.row == 0
            ? generateSizeForBookmarkHeader()
            : generateSizeForBookmarkCell())
    }
    
    func generateSizeForBookmarkHeader() -> CGSize {
        return CGSize(width: (bounds.size.width - (2*leftRightInset)), height: headerHeight)
    }
    
    func generateSizeForBookmarkCell() -> CGSize {
        let width = UIScreen.main.bounds.width
        cellWidth = (width - (2*leftRightInset))/numberOfItemsPerRow
        return CGSize(width: cellWidth - 0.01 , height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return (section == bookmarkDataManager.getSize() - 1
            ? generateMarginSpaceForLastSection()
            : generateMarginSpaceForEveryCellRow())
    }
    
    func generateMarginSpaceForLastSection() -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: leftRightInset, bottom: 80, right: leftRightInset)
    }
    
    func generateMarginSpaceForEveryCellRow() -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: leftRightInset, bottom: -15, right: leftRightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return (indexPath.row != 0) ? true : false
    }
    
//    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        
//        
//            if let _ = collectionView.cellForItem(at: sourceIndexPath) as? EllieBrowserBookmarkedCollectionViewCell {
//                guard let cell = self?.bookmarkDataManager.getBookmarkFromSection(section: sourceIndexPath.section,
//                                                                                  index: sourceIndexPath.row-1)
//                    else { return }
//                
//                print(cell.bookmarkViewTitle)
//                
//                self?.bookmarkDataManager.removeAtSection(section: sourceIndexPath.section,
//                                                          index: sourceIndexPath.row)
//                self?.bookmarkDataManager.insertIntoSection(section: destinationIndexPath.section,
//                                                            bookmark: cell,
//                                                            at: destinationIndexPath.row)
//                
//                print( "FIRST \(String(describing: self?.bookmarkDataManager.getSectionSize(section: 0)))")
//                print( "SECOND \(String(describing: self?.bookmarkDataManager.getSectionSize(section: 1)))")
//                
//                DispatchQueue.main.async {
//                    collectionView.reloadData()
//                    collectionView.reloadInputViews()
//                }
//            }
//        })
//        
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
//        return proposedIndexPath.row == 0
//            ? IndexPath(row: 1, section: proposedIndexPath.section)
//            : proposedIndexPath
//    }
    
}
