//
//  ArticleModel.swift
//  Percobaan
//
//  Created by Daninsyah Bagas Abiyansa on 24/08/22.
//

import Foundation
protocol ArticleModernProtocol {
    
    func articleRetrived(_ article:[Article])
}

class ArticleService {
    
    var delegate:ArticleModernProtocol?
    
    func getArticles(){
        
        // Fire off the request to the API
        
        // Create a string URL
        let stringUrl = "https://newsapi.org/v2/everything?q=apple&tech&apiKey=ee4c66c8ac7949afada05f49a74d37b4"
        
        // Create a URL object
        let url = URL(string: stringUrl)
      
        // Check that it isn't a nil
        guard url != nil else {
            print("Coudn't create url object")
            return
        }
       
        // Get the URL Session
        let session = URLSession.shared
        
        // Create the data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            // Check that there are no errors and that there is data
            if error == nil && data != nil {
                
                // Attempt to parse the JSON
                let decoder = JSONDecoder()
                
                do{
                    
                    // Parse the json into ArticleService
                    let articleService = try decoder.decode(ArticleModel.self, from: data!)
                    
                    // Get the articles
                    let articles = articleService.articles!
                    
                    // Pass it back to the view controller in the main thread
                    DispatchQueue.main.async {
                        self.delegate?.articleRetrived(articles)
                    }
                    
                }
                catch{
                    
                    print("error parsing the json")
                    
                } // End Do - Catch
                
            } // End if
            
        } // End Data Task
       
        // Start the data task
        dataTask.resume()
        
    }
}

