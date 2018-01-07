//
//  SignUpViewController.swift
//  carz4life
//
//  Created by Arthur Quemard on 30.11.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    
    //MARK: UI Components
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailValidImageView: UIImageView!
    @IBOutlet weak var passwordValidImageView: UIImageView!
    @IBOutlet weak var confirmValidImageView: UIImageView!
    
    //MARK: Attributes
    var disposeBag = DisposeBag()
    var viewModel: SignUpViewModel!
    
    //MARK: - Overriding
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        
        viewModel = SignUpViewModel()
        
        customSignUpButton()
        bindToRx()

    }
    
    private func bindToRx() {
        disposeBag = DisposeBag()
        emailTextField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        confirmTextField.rx.text.orEmpty.bind(to: viewModel.confirm).disposed(by: disposeBag)
        
        viewModel.signUpEnabled.drive(signUpButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.signUpEnabled.drive(onNext: {[weak self] in
            self?.signUpButton.backgroundColor = $0 ? ColorHelper.sharedInstance.primary : ColorHelper.sharedInstance.disabled
        }).disposed(by: disposeBag)
        
        viewModel.errorMsg.drive(errorLabel.rx.text).disposed(by: disposeBag)
        viewModel.signUpExecuting.drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: disposeBag)
        
        let checkImg = UIImage(named: "checkInd")
        let crossImg = UIImage(named: "crossInd")
        
        viewModel.emailIsValid.drive(onNext: {[weak self] in
            self?.emailValidImageView.image = $0 ? checkImg : crossImg
        }).disposed(by: disposeBag)
        
        viewModel.passwordIsValid.drive(onNext: {[weak self] in
            self?.passwordValidImageView.image = $0 ? checkImg : crossImg
        }).disposed(by: disposeBag)
        
        viewModel.confirmIsValid.drive(onNext: {[weak self] in
            self?.confirmValidImageView.image = $0 ? checkImg : crossImg
        }).disposed(by: disposeBag)
        
    }
    
    //MARK: - Action
    @IBAction func signUpButtonDidTap(_ sender: Any) {
        viewModel.signUpCommand()
    }
    
    
}
//MARK: - UI stuff
extension SignUpViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    private func customSignUpButton() {
        signUpButton.layer.cornerRadius = signUpButton.frame.height/2
    }
}
