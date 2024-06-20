//
//  ActorTableViewCell.swift
//  RssNews
//
//  Created by 00591908 on 2024/6/19.
//

import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textLimedSpruce
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textNevada
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let pubDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    // 初始化 Cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NewsTableViewCell {
    // 配置 Cell 內容
    func configure(with newsItem: NewsItem) {
        print(newsItem)
        titleLabel.text = newsItem.title
        descriptionLabel.text = newsItem.description
        pubDateLabel.text = newsItem.pubDate
    }
}

private extension NewsTableViewCell{
    // 配置 UI 元素
    private func setupUI() {
        // 添加到內容視圖
        self.selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(pubDateLabel)
    }
    
    // 設置約束
    private func setupConstraints() {
        // 使用 SnapKit 設置約束
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        pubDateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
