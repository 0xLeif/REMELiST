//
//  ListItemCell.swift
//  REMELiST
//
//  Created by Zach Eriksen on 5/1/20.
//  Copyright © 2020 oneleif. All rights reserved.
//

import UIKit
import SwiftUIKit

class ListItemCell: UITableViewCell {
    let title = Label.title1("")
    let notes = Label.body("")
}

extension ListItemCell: TableViewCell {
    func configure(forData data: CellDisplayable) {
        contentView.clear().embed {
            VStack(withSpacing: 4) {
                [
                    title,
                    notes
                        .number(ofLines: 5)
                ]
            }
        }
        
        selectionStyle = .none
    }
    
    func update(forData data: CellDisplayable) {
        guard let data = data as? ListItemData else {
            return
        }
        
        title.text = data.title
        notes.text = data.notes
    }
    
    static var ID: String {
        "ListItemCell"
    }
}
