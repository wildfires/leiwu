//
//  WFRichText.swift
//  YouHua
//
//  Created by 高洋 on 16/6/26.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import Foundation

protocol WFRichText {
    
    func transformAttributeString(originalString: String) -> NSMutableAttributedString
    
}

extension WFRichText {
    
    func transformAttributeString(text: String) -> NSMutableAttributedString {
        let body = NSMutableAttributedString(string: text)
        
        do {
            let emotionPattern: NSString = "\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]"
            let atPattern: NSString = "@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*"
            let topicPattern: NSString = "#.*?#"
            let urlPattern: NSString = "[a-zA-Z]*://[a-zA-Z0-9/\\.]*"
        
        
            let pattern: NSString = NSString(format: "%@|%@|%@", atPattern, topicPattern, urlPattern)
        
            let regex = try NSRegularExpression(pattern: pattern as String, options: NSRegularExpressionOptions.CaseInsensitive)
            
            let res = regex.matchesInString(text, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, text.characters.count))
            for checkingRes in res {
                let str = (text as NSString).substringWithRange(checkingRes.range)
                let tempStr = NSMutableAttributedString(string: str)
                
                //tempStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: NSMakeRange(0, str.characters.count))
                tempStr.addAttributes([NSFontAttributeName: UIFont(fontSize: 12), NSForegroundColorAttributeName: Color_Tags], range: NSMakeRange(0, str.characters.count))
                body.replaceCharactersInRange(checkingRes.range, withAttributedString: tempStr)
            }
            
            //    //解析表情
            let emojiRegex = try NSRegularExpression(pattern: emotionPattern as String, options: NSRegularExpressionOptions.CaseInsensitive)
            let emojiRes = emojiRegex.matchesInString(text, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, text.characters.count))
            //if let fileName = NSBundle.mainBundle().pathForResource("emoji_config", ofType: "json") {
            
                //let emojiDic: NSDictionary = NSDictionary(contentsOfFile: fileName)!
                
                for checkingRes in emojiRes {
                    let str = (text as NSString).substringWithRange(checkingRes.range)
                    let tempStr = NSMutableAttributedString(string: str)
                    tempStr.forwardingTargetForSelector(#selector(HomeViewModel.clemoji))
                    //tempStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: NSMakeRange(0, str.characters.count))
                    tempStr.addAttributes([NSFontAttributeName: UIFont(fontSize: 12), NSForegroundColorAttributeName: Color_Tags], range: NSMakeRange(0, str.characters.count))
                    body.replaceCharactersInRange(checkingRes.range, withAttributedString: tempStr)
                }
                
            //}
            
            
        } catch {}
        
        return body
    }
    
}