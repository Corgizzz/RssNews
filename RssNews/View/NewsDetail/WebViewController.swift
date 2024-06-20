//
//  WebViewController.swift
//  RssNews
//
//  Created by 00591908 on 2024/6/19.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
    var urlString: String
    
    // 初始化時傳入要加載的 URL 字符串
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Web View"
        
        setupWebView()
        loadURL()
    }
    
    // 配置 WKWebView
    private func setupWebView() {
        // 創建 WKWebView 配置
        let webConfiguration = WKWebViewConfiguration()
        
        // 創建 WKWebView 實例
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        // 將 WKWebView 添加到視圖中
        view.addSubview(webView)
        
        // 使用 SnapKit 設置 WKWebView 的約束
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // 設置 WebView 充滿整個視圖
        }
    }
    
    // 加載指定的 URL
    private func loadURL() {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            print("無效的 URL: \(urlString)")
        }
    }
}
