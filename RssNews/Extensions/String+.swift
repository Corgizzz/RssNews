//
//  String+.swift
//  RssNews
//
//  Created by 00591908 on 2024/6/19.
//

import Foundation

// 擴展 String，添加一個方法來去除 HTML 標籤
extension String {
    // 去除 HTML 標籤
    func removingHTMLTags() -> String {
        // 定義正則表達式來匹配 HTML 標籤
        let regexPattern = "<[^>]+>"
        
        // 使用正則表達式替換 HTML 標籤
        do {
            let regex = try NSRegularExpression(pattern: regexPattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: self.utf16.count)
            let htmlLessString = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
            return htmlLessString
        } catch {
            print("正則表達式錯誤: \(error)")
            return self // 返回原始字符串作為後備方案
        }
    }
}
