//
//  SettingsViewController.swift
//  carz4life
//
//  Created by Arthur Quemard on 02/12/2017.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: UIViewController {
    //MARK: - Properties
    //MARK: UI components
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var userAccountDetailsView: UIView!
    
    //MARK: Attributes
    var disposeBag = DisposeBag()
    var viewModel: SettingsViewModel!
    
    //MARK: - Overriding
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SettingsViewModel()
        
        setupUIComponents()
        bindToRx()
    }
    //MARK: - Rx implementation
    private func bindToRx() {
        disposeBag = DisposeBag()
        viewModel.userEmail.drive(emailLabel.rx.text).disposed(by: disposeBag)
    }
    
    //MARK: - Actions
    @IBAction func logoutButtonDidTap(_ sender: Any) {
        viewModel.logoutCommand()
    }
}

//MARK: - UI Stuff
extension SettingsViewController {
    func setupUIComponents() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        logoutButton.layer.cornerRadius = 5
        userAccountDetailsView.layer.cornerRadius = 5
    }
}
