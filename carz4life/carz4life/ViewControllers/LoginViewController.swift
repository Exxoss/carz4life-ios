//
//  LoginViewController.swift
//  carz4life
//
//  Created by Arthur Quemard on 29.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController, UITextFieldDelegate{
    //MARK: - Properties
    //MARK: UI componants
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: Attributes
    var disposeBag = DisposeBag()
    var viewModel: LoginViewModel!
    
    //MARK: - Overriding
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        viewModel = LoginViewModel()
        customSignInButton()
        bindToRx()

    }

    //MARK: - Rx implementation
    private func bindToRx() {
        disposeBag = DisposeBag()
        emailTextField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        
        viewModel.loginEnabled.drive(signInButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.loginEnabled.drive(onNext: {[weak self] in
            self?.signInButton.backgroundColor = $0 ? ColorHelper.sharedInstance.primary : ColorHelper.sharedInstance.disabled
        }).disposed(by: disposeBag)
        
        viewModel.errorMsg.drive(errorLabel.rx.text).disposed(by: disposeBag)
        viewModel.loginExecuting.drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: disposeBag)
    }
    
    //MARK: - Action
    @IBAction func signInButtonDidTap(_ sender: Any) {
        viewModel.signInCommand()
    }

}

//MARK: - UI stuff
extension LoginViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    private func customSignInButton() {
        signInButton.layer.cornerRadius = signInButton.frame.height/2
    }
}
