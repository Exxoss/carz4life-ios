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
import Lottie

class WinningViewController: UIViewController {
    //MARK: - Properties
    //MARK: UI components
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var checkView: UIView!
    
    
    //MARK: Attributes
    var viewModel: WinningViewModel!
    
    //MARK: - Overriding
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIComponents()
        bindToRx()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playSuccessAnimation()
    }
    
    //MARK: - Rx implementation
    private func bindToRx(){
        
    }
}
extension WinningViewController {
    private func setupUIComponents(){
        contactButton.layer.cornerRadius = (contactButton.frame.height)/2
    }
    
    private func playSuccessAnimation () {
        guard let successAnimationView = LOTAnimationView(name: "success") as LOTAnimationView? else {return}
        successAnimationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        successAnimationView.loopAnimation = false
        successAnimationView.contentMode = .scaleAspectFill
        successAnimationView.animationSpeed = 0.6
    
        UIView.animate(withDuration: 4.0, delay: 0.0, options: [], animations: {
            successAnimationView.transform = CGAffineTransform.identity
        }, completion: nil)
        
        checkView.addSubview(successAnimationView)
        successAnimationView.play()
    }
}
