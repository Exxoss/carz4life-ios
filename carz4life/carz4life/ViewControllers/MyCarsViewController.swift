//
//  MyCarsViewController.swift
//  carz4life
//
//  Created by Arthur Quemard on 21.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwipeCellKit

class MyCarsViewController: UITableViewController {
    
    //MARK: - Properties
    var disposeBag = DisposeBag()
    var viewModel: MyCarsViewModel!
    
    let loadingDataView = LoadingDataView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MyCarsViewModel()
        
        setupUIComponents()
        bindToRx()
    }
    
    //MARK: - Rx implementation
    private func bindToRx() {
        disposeBag = DisposeBag()
        tableView.dataSource = nil
        tableView.delegate = nil
        
        viewModel.auctions.asObservable().bind(to: tableView.rx.items(cellIdentifier: "MyCarsCellIdentifier")) {(row, auction: Auction, cell: MyCarsViewCell) in
                cell.bindToRx(viewModel: MyCarsCellViewModel(auction: auction))
                cell.delegate = self
            }.disposed(by: disposeBag)
        
        viewModel.selectedItem.asObservable().subscribe({[weak self] in
            guard let _ = $0.element as? Auction else {return}
            self?.performSegue(withIdentifier: "displayWinningPage", sender: nil)
        }).disposed(by: disposeBag)
        
        viewModel.selectedAuction.asObservable().subscribe({[weak self] in
            guard let _ = $0.element as? Auction else {return}
            self?.performSegue(withIdentifier: "displayAuctionDetailsFromMyCars", sender: nil)
        }).disposed(by: disposeBag)
        
        viewModel.isLoadingData.drive(onNext: {[weak self] in
            self?.tableView.tableFooterView = $0 ? self?.loadingDataView : nil
            UIApplication.shared.isNetworkActivityIndicatorVisible = $0
        }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe({[weak self] in
            self?.viewModel.selectItemCommand(index: ($0.element)!.row)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let winningViewController = segue.destination as? WinningViewController {
            guard let auction = viewModel.selectedItem.value else{return}
            winningViewController.viewModel = WinningViewModel(auction: auction)
        } else if let auctionDetailsViewController = segue.destination as? AuctionDetailsViewController {
            guard let auction = viewModel.selectedAuction.value else{return}
            auctionDetailsViewController.viewModel = AuctionDetailsViewModel(auction: auction, repo: viewModel.repository)
        }
    }
}

//MARK: - Swipe button implementation
extension MyCarsViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let showDetailsAction = SwipeAction(style: .default, title: "Details") {[weak self] action, indexPath in
            self?.viewModel.selectAuctionCommand(index: indexPath.row)
        }
        
        showDetailsAction.backgroundColor = ColorHelper.sharedInstance.primary
        
        return [showDetailsAction]
    }
}

//MARK: - UI Stuff
extension MyCarsViewController {
    
    private func setupUIComponents() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadingDataView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
    }
}
