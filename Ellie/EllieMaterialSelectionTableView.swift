//
//  EllieMaterialSelectionTableView.swift
//  Ellie
//
//  Created by Mar Basava on 4/13/17.
//  Copyright © 2017 MarBasava. All rights reserved.
//

import UIKit
import EasyPeasy

class EllieMaterialSelectionTableView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        materialSelectionTableView.delegate = self
        materialSelectionTableView.dataSource = self
        
        materialSelectionTableView.register(EllieMaterialSelectionTableCell.self, forCellReuseIdentifier: headerIdentifier)
        materialSelectionTableView.separatorColor = UIColor.clear
        materialSelectionTableView.showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func initializeLayouts() {
        addSubview(materialSelectionTableView)
        
        materialSelectionTableView.easy.layout(
            Left(0),
            Right(0),
            Top(0),
            Bottom(0)
)
        
    }
    
    let materialsHeaders = ["UNMARKED", "UNIT I", "UNIT II", "UNIT III", "UNIT IV", "UNIT V","UNMARKED", "UNIT I", "UNIT II", "UNIT III", "UNIT IV", "UNIT V","UNMARKED", "UNIT I", "UNIT II", "UNIT III", "UNIT IV", "UNIT V"]
    
    let headerIdentifier = "materialSelectionHeader"
    
    var navigationController : UINavigationController!
    
    lazy var materialSelectionTableView : UITableView = {
        let tableView = UITableView()
    
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materialsHeaders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: headerIdentifier, for: indexPath) as? EllieMaterialSelectionTableCell else { return UITableViewCell() }
        
//        cell.headerLabel.addCharactersSpacing(spacing: 2.2, text: materialsHeaders[indexPath.row])
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            navigationController.navigationBar.isHidden = false
        
        DispatchQueue.main.async {
            [weak self] in
            self?.navigationController.pushViewController(EllieExpandedMaterialSelectionViewController(), animated: true)
        }

    }
    
}

class EllieMaterialSelectionHeaderTableCell : UITableViewCell {

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

class EllieMaterialSelectionTableCell : UITableViewCell {
        
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.EllieColors.flatGray
        
        initializeLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeLayouts() {
        
        
    }
    
}



