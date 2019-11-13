//
//  MainViewController.swift
//  NYMPA
//
//  Created by Parimala Ranganath Velayudam on 13/11/19.
//  Copyright © 2019 VPR productions. All rights reserved.
//

import UIKit

let EstimatedNewsRableRowHeight:CGFloat = 108.0

class MainViewController: UIViewController {
    
    @IBOutlet weak var articleTableView:UITableView!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    
    var dataSource = ArticlesDataSource()
    
    lazy var viewModel : ArticleViewModel = {
        let viewModel = ArticleViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpIntials()
    }
    
    //MARK:- UI setu methods
    
    func setUpIntials() {
        
        //Setup UI
        self.title = constNewsTitleString
        self.activityIndicator.stopAnimating()
        
        self.articleTableView.rowHeight = UITableView.automaticDimension
        self.articleTableView.estimatedRowHeight = EstimatedNewsRableRowHeight
        
        //Setup datasource
        self.articleTableView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.articleTableView.reloadData()
        }
        
        // Fetch article if network available
        Utilities.isOnline() ? fetchArticle() : showAlertWithMessgae(message: constNoNetworkErrorMessgae)
    }
    
    func fetchArticle()
    {
        self.activityIndicator.startAnimating()
        self.viewModel.fetchArticles({[weak self] result in
            
            self?.activityIndicator.stopAnimating()
            
            switch result{
            case .failure(let error):
                self?.showAlertWithMessgae(message: error.localizedDescription)
                
            default:
                NSLog("sucess")
            }
        })
    }
    
    //MARK:- Alert
    func showAlertWithMessgae(message:String) {
        
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
}

//MARK:- Extension for TableViewDelegate handling
extension MainViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: constNewDetailSegue , sender: self.dataSource.data.value[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == constNewDetailSegue {
            let detailVC = segue.destination as? DetailViewController
            detailVC?.detailNews = (sender as! ArticleCellViewModel).captionInfo
            detailVC?.detailNewsImageUrl = (sender as! ArticleCellViewModel).imageUrl
            detailVC?.title = (sender as! ArticleCellViewModel).title
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
}

