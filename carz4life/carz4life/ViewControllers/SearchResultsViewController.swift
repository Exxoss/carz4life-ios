//
//  SearchResultsViewController.swift
//  carz4life
//
//  Created by Arthur Quemard on 04.12.17.
//  Copyright © 2017 Arthur Quemard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchResultsViewController: UITableViewController, UITabBarControllerDelegate{
    
    //MARK: - Properties
    //MARK: Attributes
    var disposeBag = DisposeBag()
    var viewModel: SearchResultsViewModel!
    
    //MARK: UI Components
    let loadingDataView = LoadingDataView()
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
        
        viewModel = SearchResultsViewModel()
        
        setupSearchController()
        setupNavBar()
        setupLoadingDataView()
        
        bindToRx()
        
    }
    //MARK: - Rx implementation
    private func bindToRx() {
        disposeBag = DisposeBag()
        tableView.dataSource = nil
        tableView.delegate = nil
        
        viewModel.auctionsDisplayed.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "AuctionCellIdentifier")) { (row, auction: Auction, cell: AuctionViewCell) in
                cell.bindToRx(viewModel: AuctionCellViewModel(auction: auction))
            }.disposed(by: disposeBag)
        
        searchController.searchBar.rx.text.orEmpty.bind(to: viewModel.searchText).disposed(by: disposeBag)
        
        viewModel.isLoadingData.drive(onNext: {[weak self] in
            self?.tableView.tableFooterView = $0 ? self?.loadingDataView : nil
            UIApplication.shared.isNetworkActivityIndicatorVisible = $0
        }).disposed(by: disposeBag)
        
        viewModel.selectedAuction.asObservable().subscribe({[weak self] in
            guard let _ = $0.element as? Auction else {return}
            self?.performSegue(withIdentifier: "displayAuctionDetails", sender: nil)
        }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe({[weak self] in
                self?.viewModel.selectAuctionCommand(index: ($0.element)!.row)
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let auctionDetailsViewController = segue.destination as? AuctionDetailsViewController {
            guard let auction = viewModel.selectedAuction.value else{return}
            auctionDetailsViewController.viewModel = AuctionDetailsViewModel(auction: auction, repo: viewModel.repository)
        }
    }
 

}

//MARK: - UI Stuff
extension SearchResultsViewController {
    private func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    private func setupLoadingDataView() {
        loadingDataView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
    }
}

//MARK: - SearchController
extension SearchResultsViewController {
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        searchController.isActive = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        searchController.isActive = false
    }
}
