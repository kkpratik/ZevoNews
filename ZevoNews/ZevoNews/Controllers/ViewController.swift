//
//  ViewController.swift
//  ZevoNews
//
//  Created by Apple on 15/07/23.
//

import UIKit
import IHProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var headlineTableView: UITableView!
    @IBOutlet weak var topicCollectionView: UICollectionView!
    var selectedCategoryIndex = 0
    
    var viewModel = HeadlineListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.headlineTableView.dataSource = self
        self.headlineTableView.delegate = self
        self.headlineTableView.rowHeight = UITableView.automaticDimension
        
        self.topicCollectionView.dataSource = self
        self.topicCollectionView.delegate = self
        self.topicCollectionView.allowsMultipleSelection = false
        
        getHeadlines(category: .all)
    }
    
    func getHeadlines(category:Category){
        IHProgressHUD.show()
        self.viewModel.getheadlines(category:category, completion: { success in
            IHProgressHUD.dismiss()
            if success{
                self.headlineTableView.reloadData()
            }
        })
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineTableViewCell", for: indexPath) as? HeadlineTableViewCell{
            if let article = self.viewModel.articles?[indexPath.row]{
                cell.configureWith(object: article)
                return cell
            }
            
        }
        return UITableViewCell()
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let webVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            
            webVC.articleURL = self.viewModel.articles?[indexPath.row].url
            self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
}

extension ViewController:  UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicCollectionViewCell", for: indexPath) as? TopicCollectionViewCell {
            
            cell.configureWith(title: self.viewModel.categories[indexPath.row], selected: selectedCategoryIndex == indexPath.row)
            return cell
        }
            
        return UICollectionViewCell()
    }
    
    //MARK: - CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategoryIndex = indexPath.row
        self.viewModel.selectCategory(atIndex: indexPath.row)
        self.topicCollectionView.reloadData()
        
        getHeadlines(category: self.viewModel.selectedCategory)
    }
}

