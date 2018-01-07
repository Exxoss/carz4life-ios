//
//  WinningPageViewController.swift
//  carz4life
//
//  Created by Arthur Quemard on 27/12/2017.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WinningViewController: UIViewController {
    //MARK: - Properties
    //MARK: UI components
    @IBOutlet weak var contactButton: UIButton!
    
    
    //MARK: Attributes
    var viewModel: WinningViewModel!
    
    //MARK: - Overriding
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIComponents()
        bindToRx()
    }
    
    //MARK: - Rx implementation
    private func bindToRx(){
        
    }
}
extension WinningViewController {
    private func setupUIComponents(){
        contactButton.layer.cornerRadius = (contactButton.frame.height)/2
    }
}
