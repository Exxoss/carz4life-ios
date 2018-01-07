//
//  AuctionDetailsViewController.swift
//  carz4life
//
//  Created by Arthur Quemard on 14.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ImageSlideshow

class AuctionDetailsViewController: UIViewController {
    //MARK: - Properties
    //MARK: UI components
    @IBOutlet weak var articleImageSlideShow: ImageSlideshow!
    
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var auctionStatusLabel: UILabel!
    @IBOutlet weak var timeBeforeStatusChangeLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var priceAfterBiddingLabel: UILabel!
    @IBOutlet weak var markLogoImageView: UIImageView!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var bidButton: UIButton!
    
    @IBOutlet weak var engineValueLabel: UILabel!
    @IBOutlet weak var hpPowerValueLabel: UILabel!
    @IBOutlet weak var fuelValueLabel: UILabel!
    @IBOutlet weak var gearValueLabel: UILabel!
    @IBOutlet weak var doorValueLabel: UILabel!
    @IBOutlet weak var seatValueLabel: UILabel!
    @IBOutlet weak var lightValueLabel: UILabel!
    @IBOutlet weak var mileageValueLabel: UILabel!
    @IBOutlet weak var descriptionValueLabel: UILabel!
    @IBOutlet weak var peopleParticipateToTheAuctionCountLabel: UILabel!
    @IBOutlet weak var bidButtonActivityIndicator: UIActivityIndicatorView!
    
    //MARK: Attributes
    var viewModel: AuctionDetailsViewModel!
    var disposeBag = DisposeBag()
    
    //MARK: - Overriding
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIItems()
        bindToRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func bindToRx() {
        disposeBag = DisposeBag()
        
        viewModel.articleImageUrls.drive(onNext: {[weak self] in
            self?.setArticleImageSlideShow(imageUrls: $0)
        }).disposed(by: disposeBag)
        
        viewModel.title.drive(onNext: {[weak self] in self?.title = $0}).disposed(by: disposeBag)
        
        viewModel.userParticipateToTheAuction.drive(onNext: {[weak self] in self?.notificationLabel.isHidden = !$0}).disposed(by: disposeBag)
        viewModel.userIsTheCurrentWinner.drive(onNext: {[weak self] in
            self?.notificationLabel.backgroundColor = $0 ? ColorHelper.sharedInstance.valid : ColorHelper.sharedInstance.error
            self?.notificationLabel.text = $0 ? NSLocalizedString("You are the current winner", comment: "") : NSLocalizedString("You were outbid", comment: "")
        }).disposed(by: disposeBag)
        
        viewModel.shouldBidButtonBeEnable.drive(onNext: {[weak self] in
            self?.bidButton.backgroundColor = $0 ? ColorHelper.sharedInstance.primary : ColorHelper.sharedInstance.disabled
            self?.bidButton.isEnabled = $0
        }).disposed(by: disposeBag)
        
        viewModel.auctionStatus.drive(onNext: {[weak self] in
            self?.auctionStatusLabel.text = ($0 == AuctionStatus.alive) ? NSLocalizedString("Alive", comment: "") : (($0 == AuctionStatus.closed) ? NSLocalizedString("Closed", comment: "") : NSLocalizedString("Pending", comment: ""));
            self?.auctionStatusLabel.textColor = $0 == AuctionStatus.alive ? ColorHelper.sharedInstance.valid : $0 == AuctionStatus.pending ? ColorHelper.sharedInstance.primary : ColorHelper.sharedInstance.error
        }).disposed(by: disposeBag)
        
        viewModel.timerBeforeStatusChange.drive(timeBeforeStatusChangeLabel.rx.text).disposed(by: disposeBag)
        viewModel.shouldTimerBeforeStatusChangeBeHidden.drive(timeBeforeStatusChangeLabel.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.currentPrice.drive(currentPriceLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.shouldNewPriceAfterBiddingBeHidden.drive(priceAfterBiddingLabel.rx.isHidden).disposed(by: disposeBag)
        viewModel.newPriceAfterBidding.drive(priceAfterBiddingLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.mark.drive(onNext: {[weak self] in
            self?.markLogoImageView.image = UIImage(named: setupLogoFromMark(mark: $0).rawValue)
            self?.markLabel.text = $0
        }).disposed(by: disposeBag)
        
        viewModel.model.drive(modelLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.description.drive(descriptionValueLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.engine.drive(engineValueLabel.rx.text).disposed(by: disposeBag)
        viewModel.hpPower.drive(hpPowerValueLabel.rx.text).disposed(by: disposeBag)
        viewModel.fuel.drive(fuelValueLabel.rx.text).disposed(by: disposeBag)
        viewModel.gear.drive(gearValueLabel.rx.text).disposed(by: disposeBag)
        viewModel.door.drive(doorValueLabel.rx.text).disposed(by: disposeBag)
        viewModel.seat.drive(seatValueLabel.rx.text).disposed(by: disposeBag)
        viewModel.light.drive(lightValueLabel.rx.text).disposed(by: disposeBag)
        viewModel.mileage.drive(mileageValueLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.countUsersParticipatedToTheAuction.drive(peopleParticipateToTheAuctionCountLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.isInProcess.drive(onNext: {[weak self] in
            $0 ? self?.bidButtonActivityIndicator.startAnimating() : self?.bidButtonActivityIndicator.stopAnimating()
            UIApplication.shared.isNetworkActivityIndicatorVisible = $0
        }).disposed(by: disposeBag)
    }
    
    //MARK: - Action
    @IBAction func bidButtonDidTap(_ sender: Any) {
        let newPrice = Variable<String>("")
        viewModel.newPriceAfterBidding.drive(newPrice).disposed(by: disposeBag)
        
        let refreshAlert = UIAlertController(title: NSLocalizedString("Confirm", comment: ""), message: String(format: NSLocalizedString("ConfirmBidPopUpMessageFormat", comment: ""), newPrice.value), preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: {[weak self] (action: UIAlertAction!) in
            self?.viewModel.bidCommand()
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: {(action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
}

//MARK: - UI Stuff
extension AuctionDetailsViewController {
    private func setupUIItems() {
        bidButton.layer.cornerRadius = bidButton.frame.height/2
        
        articleImageSlideShow.backgroundColor = UIColor.black
        articleImageSlideShow.zoomEnabled = true
        articleImageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        articleImageSlideShow.activityIndicator = DefaultActivityIndicator()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(AuctionDetailsViewController.articleImageSlideShowDidTap))
        articleImageSlideShow.addGestureRecognizer(recognizer)
    }
    
    @objc private func articleImageSlideShowDidTap() {
        let fullScreenController = articleImageSlideShow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    private func setArticleImageSlideShow(imageUrls: [String]) {
        var imageSources = [SDWebImageSource]([])
        for url in imageUrls {
            imageSources.append(SDWebImageSource(urlString: url, placeholder: UIImage(named: "noPic"))!)
        }
        articleImageSlideShow.setImageInputs(imageSources)
    }
}
