//
//  WFNetwork.swift
//  YouHua
//
//  Created by 高洋 on 16/6/23.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//网络请求回调
typealias WFNetworkFinished = (success: Bool, result: JSON?, error: NSError?) -> ()

protocol WFNetwork {
    //var complete = (result: JSON?) -> ()
    ///func WFGet(url: String, parameters: [String : AnyObject]?, finished: (result: JSON?) -> ())
    
    //func WFRequest(method: Method, url: String, parameters: [String : AnyObject]?, finished: (result: JSON?) -> ())
    
    ///func WFUpload(url: String, formData: MultipartFormData, finished: (result: JSON?) -> ())
}

extension WFNetwork {
//    服务端php页面可以这么取得发送过来的JSON数据：
//    <?
//    $postdata = json_decode(file_get_contents("php://input"),TRUE);
//    
//    $foo= $postdata["foo"];
//    foreach ($foo as $item){
//    echo $item."|";
//    }
//    //输出：1|2|3|
    func WFGet(url: String, parameters: [String : AnyObject]?, finished: WFNetworkFinished) {
        
        Alamofire.request(.GET, API_RUL + url, parameters: parameters).responseJSON() {
            response in
            
            switch response.result {
                
                case let .Success(data):
                    
                    let json = JSON(data)
                    //finished(result: json)
                    finished(success: true, result: json, error: nil)
                case .Failure:
                    
                    print("网络不给力啊")
                    finished(success: false, result: nil, error: response.result.error)
            }
        }
    }
    
    
    
    /// 封装POST（带图片）
//    private func POST(URLString: String, image: UIImage, parameters: [String: AnyObject]?, finish: YBNetworkingFinish) {
//        // POST请求
//        netManager.POST(URLString, parameters: parameters, constructingBodyWithBlock: { (formData) -> Void in
//            let data = UIImagePNGRepresentation(image)!
//            formData.appendPartWithFileData(data, name: "pic", fileName: "sb", mimeType: "image/png")
//            }, success: { (_, data) -> Void in
//                // 成功调用
//                finish(result: data as? [String : AnyObject], error: nil)
//        }) { (_, error) -> Void in
//            // 失败调用
//            finish(result: nil, error: error)
//        }
//    }
    
    func WFUpload(url: String, formData: MultipartFormData, finished: (result: JSON?) -> ()) {
        
        Alamofire.upload(.POST, API_RUL + url, multipartFormData: { (formData) in
            
//            formData.appendBodyPart(data: strData!, name: "value1")
//            formData.appendBodyPart(data: intData!, name: "value2")
//            formData.appendBodyPart(data: file1Data!, name: "file1", fileName: "h.png", mimeType: "image/png")
//            formData.appendBodyPart(fileURL: file2URL!, name: "file2")
            
            
            
            }) { (encodingResult) in
                
//                switch encodingResult {
//                case let .Success(let upload, _, _):
//                    
//                    let json = JSON(upload)
//                    finished(result: json)
//                case .Failure:
//                    
//                    print("error")
//                }
        }
        
        
//        Alamofire.upload(.POST, url, multipartFormData: { (multipartFormData) in
//            
//            
//            for image in imageArrays {
//                let data = UIImageJPEGRepresentation(image as! UIImage, 0.5)
//                let imageName = String(NSDate()) + ".png"
//                multipartFormData.appendBodyPart(data: data!, name: "name", fileName: imageName, mimeType: "image/png")
//            }
//            
//            // 这里就是绑定参数的地方
//            for (key, value) in param {
//                assert(value is String, "参数必须能够转换为NSData的类型，比如String")
//                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key )
//            }
//            
//        }) { (encodingResult) in
//            switch encodingResult {
//            case .Success(let upload, _, _):
//                upload.responseJSON(completionHandler: { (response) in
//                    completeBlock(responseObject: response.result.value!, error: nil)
//                })
//            case .Failure(let error):
//                completeBlock(responseObject: nil, error: error)
//            }
//        }
    }
}