//
//  CellCustomizeViewController.swift
//  REMELiST
//
//  Created by Zach Eriksen on 5/9/20.
//  Copyright © 2020 oneleif. All rights reserved.
//

import UIKit
import SwiftUIKit

class CellCustomizeViewController: UIViewController {
    private lazy var settingsTable = Table {
        [
            Label.headline("Margin"),
                       Slider(value: 0.5, from: 0, to: 32) { [weak self] value in
                           globalStyle.margin = value
                           self?.styledView.apply(style: globalStyle)
                       }
                       .configure { $0.value = globalStyle.margin }
                       .padding(4),
                       
            Label.headline("Padding"),
            Slider(value: 0.5, from: 0, to: 32) { [weak self] value in
                globalStyle.padding = value
                self?.styledView.apply(style: globalStyle)
            }
            .configure { $0.value = globalStyle.padding }
            .padding(4),
            
            Label.headline("Border width"),
            Slider(value: 0.5, from: 0, to: 12) { [weak self] value in
                globalStyle.borderWidth = value
                self?.styledView.apply(style: globalStyle)
            }
            .configure { $0.value = globalStyle.borderWidth }
            .padding(4),
            
            Label.headline("Corner Radius"),
            Slider(value: 0.5, from: 0, to: 16) { [weak self] value in
                globalStyle.cornerRadius = value
                self?.styledView.apply(style: globalStyle)
            }
            .configure { $0.value = globalStyle.cornerRadius }
            .padding(4)
        ]
    }
    private var styledView = StyleView(style: globalStyle) {
        VStack(withSpacing: 4) {
            [
                Label.title1("SOME TITLE"),
                Label.body("THIS IS THE FIRST NOTE")
                    .number(ofLines: 5)
            ]
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        globalStyle.marginBackgroundColor = .brown
        globalStyle.textColor = .white
        globalStyle.borderColor = .white
        globalStyle.backgroundColor = .brown
        
        draw()
    }
    
    private func draw() {
        
        view.clear()
            .embed {
                UIView(backgroundColor: .white) {
                    SafeAreaView {
                        VStack(withSpacing: 32) {
                            [
                                self.styledView,
                                self.settingsTable
                            ]
                        }
                        
                    }
                    
                }
        }
    }
}
