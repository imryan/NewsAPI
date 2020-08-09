//
//  ViewController.swift
//  NewsAPI
//
//  Created by imryan on 08/08/2020.
//  Copyright (c) 2020 imryan. All rights reserved.
//

import UIKit
import NewsAPI

class ViewController: UIViewController {
    
    // MARK: - IBOutlet -
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Attributes -
    
    private let news: News = News(apiKey: "")
    
    private var topHeadlines: [Article] = []
    private var everything: [Article] = []
    private var sources: [NewsSource] = []
    
    // MARK: - UI Functions -
    
    private func setupUI() {
        self.title = "News"
    }
    
    private func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadSections([0, 1, 2], with: .automatic)
        }
    }
    
    // MARK: - Functions -
    
    private func getTopHeadlines() {
        let options: [QueryOptions] = [
            .country(.us),
            .pageSize(5),
            .sortBy(.popularity)
        ]
        
        news.get(.topHeadlines, with: options, headlinesCompletion: { [weak self] (headlines, error) in
            if let headlines = headlines, let articles = headlines.articles {
                self?.topHeadlines = articles
                self?.reloadTableViewData()
            }
            
            if let error = error {
                debugPrint("Error: \(error)")
            }
        })
    }
    
    private func getEverything() {
        let options: [QueryOptions] = [
            .domains(["bbc.co.uk", "bbc.com"]),
            .excludeDomains(["google.com"]),
            .pageSize(5),
            .country(.us)
        ]
        
        news.get(.everything, with: options, headlinesCompletion: { [weak self] (headlines, error) in
            if let headlines = headlines, let articles = headlines.articles {
                self?.everything = articles
                self?.reloadTableViewData()
            }
            
            if let error = error {
                debugPrint("Error: \(error)")
            }
        })
    }
    
    private func getSources() {
        let options: [QueryOptions] = [
            .language(.en),
            .category(.technology),
            .country(.us)
        ]
        
        news.get(.sources, with: options) { [weak self] (sources, error) in
            if let sources = sources?.sources {
                self?.sources = sources
                self?.reloadTableViewData()
            }
            
            if let error = error {
                debugPrint("Error: \(error)")
            }
        }
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Pull all headlines
        getTopHeadlines()
        
        // Pull everything
        getEverything()
        
        // Pull sources
        getSources()
    }
    
    // MARK: - UIStoryboardSegue -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        if indexPath.section == 2 {
            guard let sourceViewController = segue.destination as? SourceViewController else { return }
            sourceViewController.source = sources[indexPath.row]
        } else {
            guard let articleViewController = segue.destination as? ArticleViewController else { return }
            
            switch indexPath.section {
            case 0:
                articleViewController.article = topHeadlines[indexPath.row]
            case 1:
                articleViewController.article = everything[indexPath.row]
            case 2:
                break
            default:
                break
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Top Headlines"
        case 1:
            return "Everything"
        case 2:
            return "Sources"
        default:
            return "Articles"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return topHeadlines.count
        case 1:
            return everything.count
        case 2:
            return sources.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator
        
        let data: [Any]
        switch indexPath.section {
        case 0:
            data = topHeadlines
        case 1:
            data = everything
        case 2:
            data = sources
        default:
            data = []
        }
        
        // Sources
        if indexPath.section == 2 {
            if let sourcesData = data as? [NewsSource] {
                let source = sourcesData[indexPath.row]
                cell.detailTextLabel?.text = source.sourceDescription ?? "No description"
                
                if source.name == nil || source.name?.isEmpty ?? false {
                    cell.textLabel?.text = "Unknown Source"
                } else {
                    cell.textLabel?.text = source.name
                }
            }
            
            return cell
        }
        
        // Headlines
        if let articlesData = data as? [Article] {
            let article = articlesData[indexPath.row]
            cell.detailTextLabel?.text = article.title
            
            if article.author == nil || article.author?.isEmpty ?? false {
                cell.textLabel?.text = "Unknown Author"
            } else {
                cell.textLabel?.text = article.author
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = tableView.indexPathForSelectedRow {
            if indexPath.section == 2 {
                performSegue(withIdentifier: "ToSource", sender: nil)
            } else {
                performSegue(withIdentifier: "ToArticle", sender: nil)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
