//
//  ArticleTableViewCell.swift
//  Percobaan
//
//  Created by Daninsyah Bagas Abiyansa on 24/08/22.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var cardCell: UIView!
    @IBOutlet weak var datePublished: UILabel!
    
    var articleToDisplay:Article?
    
    func displaArticle(_ article:Article) {
        
      // Clean up the cell before displaying the next article
        articleImageView.image = nil
        articleImageView.alpha = 0
        articleImageView.clipsToBounds = true
        articleImageView.layer.cornerRadius = 10.0
        headlineLabel.text = ""
        headlineLabel.alpha = 0
        
        cardCell.layer.shadowColor = UIColor.gray.cgColor
        cardCell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardCell.layer.shadowOpacity = 1.0
        cardCell.layer.masksToBounds = false
        cardCell.layer.cornerRadius = 10.0
        
        // Keep a reference to the article
        articleToDisplay = article
        
        // Set the headline
        headlineLabel.text = articleToDisplay!.title
        
        //Dated Formated
        let dateString: String? = articleToDisplay!.publishedAt

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString!)
        {
          let outputFormatter = DateFormatter()
          outputFormatter.locale = Locale(identifier: "en_US_POSIX")
          outputFormatter.dateFormat = "dd MMMM hh:mm aaa"
          let outputDate = outputFormatter.string(from: date)
        datePublished.text = "Published at \(String(describing: outputDate))"
        }
        
        // Animated the label into view
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            
            self.headlineLabel.alpha = 1
            
        }, completion: nil)
        
        // Download and display the image
        
        // Check the article actually has an image
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        // Create url string
        let urlString = articleToDisplay!.urlToImage!
        
        // Check the cachemanager before downloading any image data
        if let imageData = CacheManager.retrievedData(urlString) {
            
            // There is image data, set the imageview and return
            articleImageView.image = UIImage(data: imageData)
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.articleImageView.alpha = 1
                
            }, completion: nil)
            
            return
        }
        
        // Create the url
        let url = URL(string: urlString)
        
        // Check that the url isn't nil
        guard url != nil else {
            print("Coudn't create the url object ")
            return
        }
        
        // Get a URLSession
        let session = URLSession.shared
        
        // Create the datatask
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            // Check that there no errors
            if error == nil && data != nil {
                
                // Save the date into cache
                CacheManager.saveData(urlString, data!)
                
                
                // Check if the url string that the data task went off download matches the article this cell is set to display
                if self.articleToDisplay!.urlToImage == urlString {
                    
                    DispatchQueue.main.async {
                        
                        // Dispaly the image data in the image view
                        self.articleImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            
                            self.articleImageView.alpha = 1
                            
                        }, completion: nil)
                        
                    }
                }
                
            } // End if
        } // End data task
        
        // Kick off the datatask
        dataTask.resume()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
