//
//  ArticlesDataSource.swift
//  NYMPA
//
//  Created by Parimala Ranganath Velayudam on 13/11/19.
//  Copyright © 2019 VPR productions. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class ArticlesDataSource : GenericDataSource<ArticleCellViewModel>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell configuration
        let cell = tableView.dequeueReusableCell(withIdentifier: constArticleCellID, for: indexPath) as! ArticleCell
        cell.selectionStyle = .none
        
        // Set cell data
        let articleCellVM = self.data.value[indexPath.row]
        cell.articleCellVM = articleCellVM
        return cell
    }
}
