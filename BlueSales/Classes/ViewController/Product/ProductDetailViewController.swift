//
//  ProductDetailViewController.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD

class ProductDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ProductDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        viewModel.load()
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        title = "Detail"
        navigationController?.setNavigationBarHidden(false, animated: true)
        setNavigationBarStyle(translucent: false, backgroundColor: .coolBlue, titleColor: .white)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        tableView.tableFooterView = UIView()
    }
    
    override func dataBinding() {
        super.dataBinding()
        
        viewModel.detail.asObservable().subscribe(onNext: { detail in
            guard let _ = detail else {
                return
            }
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.error.asObservable().subscribe(onNext: { error in
            guard let error = error else {
                return
            }
            SVProgressHUD.dismiss()
            //TODO: show error on a UI object
            print("error on getting detail... \(error.localizedDescription)")
        }).disposed(by: disposeBag)
        
    }


}


extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rows = 0
        if let details = viewModel.detail.value {
            rows += 1 //generail info, title, images, price
            if details.specificationSummary.count > 0 {
                rows += 1
            }
            if details.cons.count > 0 || details.pros.count > 0 {
                rows += 1
            }
            if !details.productText.isFullyEmpty {
                rows += 1
            }
            if details.deliveredWith.count > 0 {
                rows += 1
            }
            
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let details = viewModel.detail.value else {
            assertionFailure()
            return UITableViewCell() // prevent crash
        }
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell", for: indexPath) as! ProductDetailTitleTableViewCell
            cell.setup(with: details)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailInformationTableViewCell", for: indexPath) as! ProductDetailInformationTableViewCell
            cell.setup(with: details, forSection: .specifications)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailInformationTableViewCell", for: indexPath) as! ProductDetailInformationTableViewCell
            cell.setup(with: details, forSection: .prosCons)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailInformationTableViewCell", for: indexPath) as! ProductDetailInformationTableViewCell
            cell.setup(with: details, forSection: .description)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailInformationTableViewCell", for: indexPath) as! ProductDetailInformationTableViewCell
            cell.setup(with: details, forSection: .includes)
            return cell
        default:
            assertionFailure("getting a wrong number of rows or there is any row that is not validated")
            return UITableViewCell()
        }
        
        
    }
    
}
