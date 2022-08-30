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
        networkCheck()
        title = "CODERIAN APP"
        
        //Network Monitor
        func networkCheck(){
            if NetworkMonitor.shared.isConnected {
                print("Connected")
                self.showSpinner()
                loadData()
            } else {
                print("Not connected")
                self.showSpinner()
                showConnectionAlert()
            }
        }
        func showConnectionAlert() {
            let alert = UIAlertController(title: "Connection Problem", message: "Make sure your device is connected to an internet and try to restart the app!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            exit(-1)
            }))
            self.present(alert, animated: true)
            }
        }
        
        // Do any additional setup after loading the view.
        func loadData() {
            self.removeSpinner()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil),forCellReuseIdentifier: "cell")
            
            // Get the articles from the article model
            model.delegate = self
            model.getArticles()
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
fileprivate var aView: UIView?
extension ViewController {

    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
