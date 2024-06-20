//
//  NewsListViewController.swift
//  RssNews
//
//  Created by 00591908 on 2024/6/5.
//

import SnapKit
import UIKit

class NewsListViewController: BaseViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private var newsItems: [NewsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "新聞資訊"
        
        setupTableView()
        loadNewsData()
    }
}

private extension NewsListViewController {
    
    // 設置 TableView
    private func setupTableView() {
        // 添加 TableView 到視圖
        view.addSubview(tableView)
        
        // 設置 TableView 約束
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        // 註冊自定義 Cell
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        
        // 設置數據源和代理
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // 加載新聞數據
    private func loadNewsData() {
        Task {
            do {
                self.newsItems = try await fetchRSSFeed()
                tableView.reloadData()
            } catch {
                print("獲取新聞數據時出錯: \(error)")
            }
        }
    }
    
    
    func fetchRSSFeed() async throws -> [NewsItem] {
        let urlString = "https://news.ltn.com.tw/rss/all.xml"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // 創建 RSSParser 並解析數據
        let parser = RSSParser()
        let newsItems = parser.parseRSS(feed: data)
        
        return newsItems
    }
    
    func refreshNewsItems(_ newItems: [NewsItem]) {
        self.newsItems = newItems
        tableView.reloadData()
    }
    
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        let newsItem = newsItems[indexPath.row]
        cell.configure(with: newsItem)
        
        return cell
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsItem = newsItems[indexPath.row]
        self.navigationController?.pushViewController(WebViewController(urlString: newsItem.link), animated: true)
    }
}
