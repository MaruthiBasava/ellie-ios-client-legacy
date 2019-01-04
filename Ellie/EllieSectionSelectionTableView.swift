//
//  EllieSectionSelectionTableView.swift
//  Ellie
//
//  Created by Mar Basava on 4/14/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieSectionSelectionTableView: UIView, UITableViewDelegate, UITableViewDataSource{

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sectionSelectionTable.delegate = self
        sectionSelectionTable.dataSource = self
        
        sectionSelectionTable.register(EllieSectionSelectionTableCell.self, forCellReuseIdentifier: headerIdentifier)
        sectionSelectionTable.register(EllieSectionSelectionHeaderTableCell.self, forCellReuseIdentifier: sectionIdentifier)

        sectionSelectionTable.separatorColor = UIColor.clear
        sectionSelectionTable.showsVerticalScrollIndicator = false
        
        
//        createSections(title: "QUARTER I", a: "VALENCE ELECTRONS", b: "DIMENSIONAL THEORY", c: "LAB RULES")
//        createSections(title: "QUARTER II", a: "COMBUSTION THEORY", b: "COMBUSTIONAL MOLECULES", c: "ACIDS AND BASES")
//        createSections(title: "QUARTER III", a: "ORGANIC CHEMISTRY", b: "CARBON RINGS", c: "RULES")

    }
    
//    func createSections(title: String, a: String, b: String, c: String) {
//        let q = EllieSectionPreviewView()
//        q.sectionLabel.text = a
//        let w = EllieSectionPreviewView()
//        w.sectionLabel.text = b
//        let e = EllieSectionPreviewView()
//        e.sectionLabel.text = c
//
//        let a = EllieSectionDataModel(sectionTitle: title)
//        a.sections.append(q)
//        a.sections.append(w)
//        a.sections.append(e)
//
//        sections.append(a)
//
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initializeLayouts() {
        addSubview(sectionSelectionTable)
        
        sectionSelectionTable.easy.layout(
            Left(0),
            Right(0),
            Top(0),
            Bottom(0)
)
        
    }
    
    
    let headerIdentifier = "materialSelectionHeader"
    let sectionIdentifier = "sectionSelectionHeader"

    var navigationController : UINavigationController!
    
    lazy var sectionSelectionTable : UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

class EllieSectionSelectionHeaderTableCell : UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.EllieColors.flatGray
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        addSubview(headerLabel)
        addSubview(caret)
        
        headerLabel.easy.layout(
            Center(0.0),
            Left(10)
)
        
        caret.easy.layout(
            Center(0.0),
            Right(5),
            Width(15),
            Height(15)
)
    }
    
    lazy var headerLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: WideFonts.glacialIndifferenceBold, size: 14)
        label.textColor = UIColor.EllieColors.flatDarkGreen
        label.textAlignment = .center
//        label.addCharactersSpacing(spacing: 2.2, text: "COMBUSTION")
        return label
    }()
    
    lazy var caret : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: WideImages.leftCaret)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
}

class EllieSectionSelectionTableCell : UITableViewCell {
    
    var sectionCollectionView = EllieSectionSelectionCollectionView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.EllieColors.flatGray
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        addSubview(sectionCollectionView)
        
        sectionCollectionView.easy.layout(
            Top(0),
            Left(0),
            Right(0),
            Bottom(0)
)
    }

    
}


