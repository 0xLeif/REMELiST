//
//  DetailViewController.swift
//  REMELiST
//
//  Created by Zach Eriksen on 4/29/20.
//  Copyright © 2020 oneleif. All rights reserved.
//

import UIKit
import SwiftUIKit
import FLite

class DetailViewController: UIViewController {
    public var updateItemHandler: (ListItemData) -> Void
    
    var item: ListItemData
    
    private var stackContainer = UIView(backgroundColor: .systemGray6).layer(cornerRadius: 4)
    
    init(item: ListItemData, updateItemHandler: @escaping (ListItemData) -> Void) {
        self.item = item
        self.updateItemHandler = updateItemHandler
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FLite.connection.do { (connection) in
            self.item.notes = "👋🧙🏻‍♂️"
            
            self.item.update(on: connection)
            print("Updated")
            
            self.updateItemHandler(self.item)
        }
        
        stackContainer.embed {
            SafeAreaView {
                VStack {
                    [
                        Label.title1(self.item.title),
                        Label.body(self.item.notes).number(ofLines: 100),
                        Label.caption1(self.item.tags.joined(separator: ", ")),
                        Spacer()
                    ]
                }
            }
        }
        
        view
            .background(color: .white)
            .embed {
                ScrollView {
                    self.stackContainer
                        .frame(width: Float(self.view.bounds.width))
                }
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: nil) { _ in
            self.stackContainer.update(width: Float(self.view.bounds.width))
        }
    }
}
