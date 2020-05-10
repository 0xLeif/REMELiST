//
//  SUIKStyle.swift
//  REMELiST
//
//  Created by Zach Eriksen on 5/9/20.
//  Copyright © 2020 oneleif. All rights reserved.
//

import UIKit

protocol Styleable {
    func apply(style: SUIKStyle)
}

struct SUIKStyle {
    // Number Values
    var margin: Float = 0
    var padding: Float = 0
    var borderWidth: Float = 0
    var cornerRadius: Float = 0
    // Color Values
    var backgroundColor: UIColor = .clear
    var marginBackgroundColor: UIColor = .clear
    var borderColor: UIColor = .black
    var textColor: UIColor = .black
    
    func apply(styleTo view: Styleable) {
        view.apply(style: self)
    }
}

extension UILabel: Styleable {
    func apply(style: SUIKStyle) {
        textColor = style.textColor
    }
}
