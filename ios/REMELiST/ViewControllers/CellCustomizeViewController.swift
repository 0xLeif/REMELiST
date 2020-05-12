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
            VStack {
                [
                    Label.headline("Margin"),
                    Slider(value: globalStyle.margin, from: 0, to: 32) { [weak self] value in
                        globalStyle.margin = value
                        self?.styledView.apply(style: globalStyle)
                    }
                    .padding(4)
                ]
                
            },
            
            VStack {
                [
                    Label.headline("Padding"),
                    Slider(value: globalStyle.padding, from: 0, to: 32) { [weak self] value in
                        globalStyle.padding = value
                        self?.styledView.apply(style: globalStyle)
                    }
                    .padding(4)
                ]
            },
            
            VStack {
                [
                    Label.headline("Border width"),
                    Slider(value: globalStyle.borderWidth, from: 0, to: 12) { [weak self] value in
                        globalStyle.borderWidth = value
                        self?.styledView.apply(style: globalStyle)
                    }
                    .padding(4)
                ]
            },
            
            VStack {
                [
                    Label.headline("Corner Radius"),
                    Slider(value: globalStyle.cornerRadius, from: 0, to: 16) { [weak self] value in
                        globalStyle.cornerRadius = value
                        self?.styledView.apply(style: globalStyle)
                    }
                    .padding(4)
                ]
            },
            
            VStack {
                var currentBackgroundColor = UIView()
                
                return [
                    Label.headline("Background Color"),
                    NavButton(destination: UIViewController {
                        var view = UIView().background(color: globalStyle.backgroundColor)
                        return view.embed {
                            SafeAreaView {
                                VStack {
                                    [
                                        UIView(backgroundColor: .white) {
                                            VStack {
                                                [
                                                    Label("Red"),
                                                    Slider(value: 255, from: 0, to: 255) { [weak self] (red) in
                                                        globalStyle.backgroundColor = UIColor(red: CGFloat(red / 255),
                                                                                              green: globalStyle.backgroundColor.green,
                                                                                              blue: globalStyle.backgroundColor.blue,
                                                                                              alpha: globalStyle.backgroundColor.alpha)
                                                        self?.styledView.apply(style: globalStyle)
                                                        view.background(color: globalStyle.backgroundColor)
                                                        currentBackgroundColor.background(color: globalStyle.backgroundColor)
                                                    },
                                                    Label("Green"),
                                                    Slider(value: 255, from: 0, to: 255) { [weak self] (green) in
                                                        globalStyle.backgroundColor = UIColor(red: globalStyle.backgroundColor.red,
                                                                                              green: CGFloat(green / 255),
                                                                                              blue: globalStyle.backgroundColor.blue,
                                                                                              alpha: globalStyle.backgroundColor.alpha)
                                                        self?.styledView.apply(style: globalStyle)
                                                        view.background(color: globalStyle.backgroundColor)
                                                        currentBackgroundColor.background(color: globalStyle.backgroundColor)
                                                    },
                                                    Label("Blue"),
                                                    Slider(value: 255, from: 0, to: 255) { [weak self] (blue) in
                                                        globalStyle.backgroundColor = UIColor(red: globalStyle.backgroundColor.red,
                                                                                              green: globalStyle.backgroundColor.green,
                                                                                              blue: CGFloat(blue / 255),
                                                                                              alpha: globalStyle.backgroundColor.alpha)
                                                        self?.styledView.apply(style: globalStyle)
                                                        view.background(color: globalStyle.backgroundColor)
                                                        currentBackgroundColor.background(color: globalStyle.backgroundColor)
                                                    },
                                                    Label("Alpha"),
                                                    Slider(value: 255, from: 0, to: 255) { [weak self] (alpha) in
                                                        globalStyle.backgroundColor = UIColor(red: globalStyle.backgroundColor.red,
                                                                                              green: globalStyle.backgroundColor.green,
                                                                                              blue: globalStyle.backgroundColor.blue,
                                                                                              alpha: CGFloat(alpha / 255))
                                                        self?.styledView.apply(style: globalStyle)
                                                        view.background(color: globalStyle.backgroundColor)
                                                        currentBackgroundColor.background(color: globalStyle.backgroundColor)
                                                    }
                                                ]
                                            }
                                        }
                                        .padding()
                                        .layer(cornerRadius: 8),
                                        Spacer().background(color: .clear)
                                    ]
                                }
                            }
                        }
                    }, style: .push) {
                        HStack {
                            [
                                Label("Set Color"),
                                Spacer(),
                                currentBackgroundColor
                                    .frame(width: 44)
                                    .layer(borderWidth: 1)
                                    .layer(borderColor: .black)
                                    .layer(cornerRadius: 8)
                                    .background(color: globalStyle.backgroundColor)
                            ]
                        }
                        .frame(height: 44)
                        .padding(4)
                        
                    }
                ]
            }
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
        
        globalStyle.marginBackgroundColor = .white
        globalStyle.textColor = .black
        globalStyle.borderColor = .black
        globalStyle.backgroundColor = .white
        
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
