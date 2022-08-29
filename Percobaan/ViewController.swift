//
//  ViewController.swift
//  Percobaan
//
//  Created by Daninsyah Bagas Abiyansa on 24/08/22.
//

import UIKit

class ViewController:UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    @IBOutlet weak var topBar: UINavigationItem!
    
    var model = ArticleService()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil),forCellReuseIdentifier: "cell")
        
        // Get the articles from the article model
        model.delegate = self
        model.getArticles()
    
        title = "CODERIAN APP"
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell
        
        // Get the article that the tableView is asking about
        let article = articles[indexPath.row]
        
        // Customize it
        cell.displaArticle(article)
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // User has just selected a row, trigger the seque to go to detail
        performSegue(withIdentifier: "goToDetail", sender: self)
        
    }
    
}
extension ViewController:  ArticleModernProtocol{
    
    //MARK: - Article Model Protocol Methods
    
    func articleRetrived(_ article: [Article]) {
        
        // Set the articles property of the view controller to the articless passed back from the model
        self.articles = article
        
        // Refresh the tableview
        tableView.reloadData()
    }
    
}
