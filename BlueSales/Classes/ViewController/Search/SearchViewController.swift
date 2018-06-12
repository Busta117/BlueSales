//
//  SearchViewController.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import SVProgressHUD
import RxSwift

class SearchViewController: BaseViewController {

    @IBOutlet var searchBarCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SearchViewModel!
    
    override func configureAppearance() {
        super.configureAppearance()
        registerNotifications()
        registerCell()
        
        tableView.accessibilityIdentifier = "tableView"
        tableView.isHidden = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "SearchProductTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchProductTableViewCell")
    }
    
    func registerNotifications() {
        notificationManager.addObserver(forName: .UIKeyboardWillShow) { notification in
            
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: notification.keyboardHeight, right: 0)
            self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: notification.keyboardHeight, right: 0)
            
            UIView.animate(withDuration: notification.keyboardAnimationDuration, delay: 0, options: notification.keyboardAnimationOptions, animations: {
                self.searchBar.y = self.view.safeAreaInsets.top
                self.logoImageView.y = self.view.safeAreaInsets.top - self.logoImageView.height - 30
                self.logoImageView.alpha = 0
            }, completion: { _ in
                self.searchBarCenterConstraint.isActive = false
                self.tableView.isHidden = false
            })
        }
        
        notificationManager.addObserver(forName: .UIKeyboardWillHide) { notification in
            self.tableView.contentInset = UIEdgeInsets.zero
            self.tableView.scrollIndicatorInsets = UIEdgeInsets.zero
        }
    }
    
    
    override func dataBinding() {
        super.dataBinding()
        
        viewModel.error.asObservable().subscribe(onNext: { error in
            guard let error = error else {
                return
            }
            SVProgressHUD.dismiss()
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
        
        viewModel.products.asObservable().subscribe(onNext: { _ in
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
    }


}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.cleanResults()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SVProgressHUD.show()
        view.endEditing(true)
        viewModel.search(query: searchBar.text!)
    }
    
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchProductTableViewCell", for: indexPath) as! SearchProductTableViewCell
        let product = viewModel.products.value[indexPath.row]
        cell.setup(with: product)
        
        if indexPath.row == viewModel.products.value.count - 1 {
            viewModel.search(query: searchBar.text!)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = viewModel.products.value[indexPath.row]
        
        navigationController?.pushViewController(ProductDetailViewController.launch(product: product), animated: true)
        
    }
    
}
