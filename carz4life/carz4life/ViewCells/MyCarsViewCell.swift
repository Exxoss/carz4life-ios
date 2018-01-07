//
//  myCarsViewCell.swift
//  carz4life
//
//  Created by Arthur Quemard on 21.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwipeCellKit

class MyCarsViewCell: SwipeTableViewCell{
    
    
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    
    //MARK: UI Components
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var markLogoImageView: UIImageView!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    

    //MARK: - Overriding
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Rx implementation
    func bindToRx(viewModel: MyCarsCellViewModel) {
        viewModel.title.drive(titleLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.mark.drive(onNext: {[weak self] in
            self?.markLabel.text = $0
            self?.markLogoImageView.image = UIImage(named: setupLogoFromMark(mark: $0).rawValue)
        }).disposed(by: disposeBag)
        
        viewModel.model.drive(modelLabel.rx.text).disposed(by: disposeBag)
    }
}
