//
//  EmptyMyCarsView.swift
//  carz4life
//
//  Created by Arthur Quemard on 09/01/2018.
//  Copyright © 2018 Arthur Quemard. All rights reserved.
//

import UIKit

class EmptyMyCarsView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("EmptyMyCars", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
