//
//  RSSParser.swift
//  RssNews
//
//  Created by 00591908 on 2024/6/19.
//

import Foundation

class RSSParser: NSObject, XMLParserDelegate {
    var currentElement = ""
    var currentTitle = ""
    var currentDescription = ""
    var currentLink = ""
    var currentPubDate = ""
    
    var newsItems: [NewsItem] = []
    
    func parseRSS(feed: Data) -> [NewsItem] {
        let parser = XMLParser(data: feed)
        parser.delegate = self
        parser.parse()
        return newsItems
    }
    
    // 當遇到開始標記時被調用
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentLink = ""
            currentPubDate = ""
        }
    }
    
    // 當發現字符時被調用
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title":
            currentTitle += string
        case "description":
            currentDescription += string
        case "link":
            currentLink += string
        case "pubDate":
            currentPubDate += string
        default:
            break
        }
    }
    
    // 當遇到結束標記時被調用
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            currentTitle = currentTitle.trimmingCharacters(in: .whitespacesAndNewlines)
            currentDescription = currentDescription.trimmingCharacters(in: .whitespacesAndNewlines)
            currentLink = currentLink.trimmingCharacters(in: .whitespacesAndNewlines)
            currentPubDate = currentPubDate.trimmingCharacters(in: .whitespacesAndNewlines)
            // 創建 NewsItem 並添加到數組中
            let newsItem = NewsItem(title: currentTitle, description: currentDescription, link: currentLink, pubDate: currentPubDate)
            newsItems.append(newsItem)
        }
    }
    
    // 當解析過程中出錯時被調用
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("解析錯誤: \(parseError.localizedDescription)")
    }
}
