//
//  AuctionViewCell.swift
//  carz4life
//
//  Created by Arthur Quemard on 05.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class AuctionViewCell: UITableViewCell {
    //Properties
    //MARK: Attributes
    var disposeBag = DisposeBag()
    
    //MARK: UI components
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeBeforeOpeningLabel: UILabel!
    @IBOutlet weak var auctionStatusLabel: UILabel!
    
    //MARK : - Overriding
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Rx implementation
    func bindToRx(viewModel: AuctionCellViewModel) {
        
        disposeBag = DisposeBag()
        
        viewModel.title.drive(titleLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.articleImage.drive(onNext: {[weak self] in
            self?.articleImageView.sd_setImage(with: URL(string: $0), placeholderImage: UIImage(named: "noPic"))
        }).disposed(by: disposeBag)
        
        viewModel.mark.drive(markLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.model.drive(modelLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.price.drive(priceLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.timeBeforeOpening.drive(timeBeforeOpeningLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.auctionStatus.drive(onNext: {[weak self] in
            self?.timeBeforeOpeningLabel.isHidden = !($0 == AuctionStatus.pending)
            self?.auctionStatusLabel.text = ($0 == AuctionStatus.alive) ? NSLocalizedString("Alive", comment: "") : (($0 == AuctionStatus.closed) ? NSLocalizedString("Closed", comment: "") : NSLocalizedString("Pending", comment: ""));
            self?.auctionStatusLabel.textColor = ($0 == AuctionStatus.alive) ? ColorHelper.sharedInstance.valid : (($0 == AuctionStatus.closed) ? ColorHelper.sharedInstance.error : ColorHelper.sharedInstance.primary)
        }).disposed(by: disposeBag)
    }

}
