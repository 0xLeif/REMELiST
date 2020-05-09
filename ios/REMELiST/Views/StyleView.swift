//
//  StyleView.swift
//  REMELiST
//
//  Created by Zach Eriksen on 5/9/20.
//  Copyright © 2020 oneleif. All rights reserved.
//

import UIKit
import SwiftUIKit

class StyleView: UIView {
    private var view: UIView
    
    init(style: Style, closure: () -> UIView) {
        self.view = closure()
        super.init(frame: .zero)
        
        embed { view }
        
        apply(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StyleView: Styleable {
    func apply(style: Style) {
        clear()
            .background(color: style.marginBackgroundColor)
            .embed(withPadding: style.margin) {
                view
                .padding(style.padding)
                .background(color: style.backgroundColor)
                .layer(borderColor: style.borderColor)
                .layer(borderWidth: style.borderWidth)
                .layer(cornerRadius: style.cornerRadius)
        }
        
        allSubviews
            .compactMap { $0 as? Styleable }
            .forEach { $0.apply(style: style) }
        
    }
}
