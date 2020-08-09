//
//  SourceViewController.swift
//  NewsAPI_Example
//
//  Created by Ryan Cohen on 8/8/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import NewsAPI

class SourceViewController: UIViewController {
    
    // MARK: - IBOutlet -
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    // MARK: - Attributes -
    
    var source: NewsSource?
    
    // MARK: - UI Functions -
    
    private func setupUI() {
        guard let source = source else { return }
        
        DispatchQueue.main.async {
            self.title = source.name ?? "Unknown Source"
            self.nameLabel.text = self.title
            self.descriptionTextView.text = source.sourceDescription ?? "No description"
            self.linkLabel.text = source.url ?? "No URL"
            self.categoryLabel.text = source.category?.rawValue.capitalized ?? "No category"
            self.languageLabel.text = source.language?.rawValue.uppercased() ?? "No language"
            self.countryLabel.text = source.country?.rawValue.uppercased() ?? "No country"
        }
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
