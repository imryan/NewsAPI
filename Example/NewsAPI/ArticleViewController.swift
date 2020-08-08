//
//  ArticleViewController.swift
//  NewsAPI_Example
//
//  Created by Ryan Cohen on 8/8/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import NewsAPI

class ArticleViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    // MARK: - Attributes -
    
    var article: Article?
    
    // MARK: - UI Functions -
    
    private func setupUI() {
        guard let article = article else { return }
        
        DispatchQueue.main.async {
            if let imageURL = article.urlToImage {
                self.getImage(from: imageURL, completion: { [weak self] (image) in
                    self?.imageView.image = image
                })
            }
            
            self.titleLabel.text = article.title ?? "Untitled"
            self.sourceLabel.text = article.source?.name ?? "Unknown Source"
            
            if article.articleDescription?.isEmpty ?? false || article.articleDescription == nil {
                self.contentTextView.text =  "No content."
            } else {
                self.contentTextView.text = article.articleDescription
            }
            
            if let dateString = article.publishedAt {
                self.dateLabel.text = self.formatDate(string: dateString)
            } else {
                self.dateLabel.text = "Unknown Date"
            }
            
            if article.author?.isEmpty ?? false || article.author == nil {
                self.authorLabel.text = "Unknown Author"
            } else {
                self.authorLabel.text = article.author
            }
        }
    }
    
    private func formatDate(string: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        
        let date = formatter.date(from: string) ?? Date()
        return formatter.string(from: date)
    }
    
    // MARK: - Networking Functions -
    
    private func getImage(from url: String, completion: @escaping (_ image: UIImage?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }.resume()
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
