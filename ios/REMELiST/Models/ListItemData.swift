//
//  ListItemData.swift
//  REMELiST
//
//  Created by Zach Eriksen on 5/1/20.
//  Copyright © 2020 oneleif. All rights reserved.
//

import Foundation
import SwiftUIKit
import FluentSQLite

final class ListItemData: SQLiteModel {
    var id: Int?
    
    private var lastEdited: Date = Date()
    var section: String?
    
    var title: String = ""
    var notes: String = ""
    var linkURLS: [String] = []
    var imageURLS: [String] = []
    var tags: [String] = []
    
    var date: Date?
}

extension ListItemData: Migration { }
extension ListItemData: CellDisplayable {
    var cellID: String {
        ListItemCell.ID
    }
}
extension ListItemData {
    func configure(closure: (ListItemData) -> Void) -> ListItemData {
        closure(self)
        
        return self
    }
}
extension ListItemData {
    var copy: ListItemData {
        ListItemData().configure { (copy) in
            copy.id = id
            copy.lastEdited = lastEdited
            copy.section = section
            copy.title = title
            copy.notes = notes
            copy.linkURLS = linkURLS
            copy.imageURLS = imageURLS
            copy.tags = tags
            copy.date = date
        }
    }
}
