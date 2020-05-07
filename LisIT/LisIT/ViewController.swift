//
//  ViewController.swift
//  LisIT
//
//  Created by Zach Eriksen on 4/25/20.
//  Copyright © 2020 oneleif. All rights reserved.
//

import UIKit
import SwiftUIKit
import FLite
import EKit

class ViewController: UIViewController {
    // MARK: Data
    
    private(set) var currentTableData: [[ListItemData]] = []
    private var data: [ListItemData] = [] {
        didSet {
            currentTableData = newTableData
            
            print(currentTableData)
            self.table
                .headerTitle { "\(self.currentTableData[$0].first?.section ?? "N/A")"}
                .footerView { _ in UIView() }
                .update { _ in currentTableData }
                .reloadData()
        }
    }
    private var newTableData: [[ListItemData]] {
        data
            .map { ($0.section, $0) }
            .reduce([String: [ListItemData]]()) { (dictionary: [String: [ListItemData]], keyValueTuple: (String?, ListItemData)) -> [String : [ListItemData]] in
                var reduceDictionary = dictionary
                
                guard var array = reduceDictionary[keyValueTuple.0 ?? ""] else {
                    reduceDictionary[keyValueTuple.0 ?? ""] = [keyValueTuple.1]
                    return reduceDictionary
                }
                
                array.append(keyValueTuple.1)
                reduceDictionary[keyValueTuple.0 ?? ""] = array
                
                return reduceDictionary
        }
        .values
        .map { $0 }
        
        
    }
    
    // MARK: Views
    
    private var table = TableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FLite.storage = .file(path: "\(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path ?? "")/default.sqlite")
        
        FLite.prepare(model: ListItemData.self)
        
        FLite.fetchAll(model: ListItemData.self) { (listItems) in
            DispatchQueue.main.async {
                self.data += listItems
            }
        }
        
        Navigate.shared.configure(controller: navigationController)
            .setRight(barButton: BarButton {
                Button(E.plus_sign.rawValue) {
                    Navigate.shared.go(AddViewController(addItemHandler: { (newItem) in
                        FLite.create(model: newItem)
                        self.data.append(newItem)
                    }), style: .modal)
                }
            })
        
        table.delegate = self
        
        table.register(cells: [ListItemCell.self])
        
        view.embed {
            SafeAreaView {
                ZStack {
                    [
                    Image(E.abacus.image(ofSize: 256, withFontSize: 256)!)
                    ]
                }
//            table
//            Table(defaultCellHeight: 120) {
//                E.allCases.map { emoji in
//                    VStack {
//                        [
//                            Label("\(emoji)").text(alignment: .center),
////                            Label.title1(emoji.rawValue).text(alignment: .center).font(.systemFont(ofSize: 64)),
////                            Image(E.abacus.)
//                            emoji.image!.frame(height: 40)
//                        ]
//                    }
//                }
//
//            }
            }
        }.debug()
        
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = currentTableData[indexPath.section][indexPath.row]
        
        Navigate.shared.go(DetailViewController(item: data) { data  in
                self.currentTableData[indexPath.section][indexPath.row] = data
                
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }, style: .push)
    }
}
