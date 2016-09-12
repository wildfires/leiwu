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
import MJRefresh


//网络请求回调
typealias WFNetworkFinished = (success: Bool, result: JSON?, error: NSError?) -> ()

//protocol WFNetwork: NSObjectProtocol, WFProgress {
//    //var complete = (result: JSON?) -> ()
//    ///func WFGet(url: String, parameters: [String : AnyObject]?, finished: (result: JSON?) -> ())
//    
//    //func WFRequest(method: Method, url: String, parameters: [String : AnyObject]?, finished: (result: JSON?) -> ())
//    
//    ///func WFUpload(url: String, formData: MultipartFormData, finished: (result: JSON?) -> ())
//}
class WFNetwork: NSObject, WFProgress {
    
    //单例
    static let shareNetwork = WFNetwork()
    
//  MARK: - 网络请求
    //get 请求
    func WFGET(url: String, parameters: [String : AnyObject]?, finished: WFNetworkFinished) {
        
        Alamofire.request(.GET, API_RUL + url, parameters: parameters).responseJSON() {
            response in
            
            switch response.result {
                
                case let .Success(data):
                    
                    let json = JSON(data)
                    finished(success: true, result: json, error: nil)
                case .Failure:
                    
                    print("网络不给力啊")
                    finished(success: false, result: nil, error: response.result.error)
            }
        }
    }
    
    //post 请求
    func WFPOST(url: String, parameters: [String : AnyObject]?, finished: WFNetworkFinished) {
        
        Alamofire.request(.POST, API_RUL + url, parameters: parameters).responseJSON() {
            response in
            
            switch response.result {
                
                case let .Success(data):
                    
                    let json = JSON(data)
                    finished(success: true, result: json, error: nil)
                case .Failure:
                    
                    print("网络不给力啊")
                    finished(success: false, result: nil, error: response.result.error)
            }
        }
    }
    
    //upload 上传
    
//  MARK: - 首页
    //首页下拉刷新
    func homeLoadNewData(tableView: UITableView, finished: (result: [HomeModel]) -> ()) {
        
        weak var weakSelf: WFNetwork? = self
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            
            let params: [String: AnyObject] = [
                "page": 0
            ]
            
            weakSelf!.WFGET(home_url, parameters: params, finished: { (success, result, error) in
                
                tableView.mj_header.endRefreshing()
                guard let result = result else {
                    return
                }
                
                let code = result["code"].intValue
                let info = result["info"].stringValue
                
                guard code == RETURN_CODE else {
                    weakSelf!.WFShowHUD(info, status: WFStatusHUD.Failure)
                    return
                }
                
                guard let data = result["data"].arrayObject else {
                    return
                }
                
                var tempData = [HomeModel]()
                for dict in data {
                    tempData.append(HomeModel(dict: dict as! [String : AnyObject]))
                }
                finished(result: tempData)
            })
        })
        //根据拖拽比例自动切换透明度
        tableView.mj_header.automaticallyChangeAlpha = true
        tableView.mj_header.beginRefreshing()
    }
    
    //首页上拉加载
    func homeLoadMoreData(tableView: UITableView, currentPage: Int, finished: (result: [HomeModel]) -> ()) {
        
        weak var weakSelf: WFNetwork? = self
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            
            let params: [String: AnyObject] = [
                "page": currentPage
            ]
            
            weakSelf!.WFGET(home_url, parameters: params, finished: { (success, result, error) in
                
                tableView.mj_footer.endRefreshing()
                guard let result = result else {
                    return
                }
                
                let code = result["code"].intValue
                let info = result["info"].stringValue
                
                guard code == RETURN_CODE else {
                    weakSelf!.WFShowHUD(info, status: WFStatusHUD.Failure)
                    return
                }
                
                guard let data = result["data"].arrayObject else {
                    return
                }
                
                var tempData = [HomeModel]()
                for dict in data {
                    tempData.append(HomeModel(dict: dict as! [String : AnyObject]))
                }
                finished(result: tempData)
            })
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //暂时无用
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
    
    func WFPost(url: String, parameters: [String : AnyObject]?, finished: WFNetworkFinished) {
        
        Alamofire.request(.POST, API_RUL + url, parameters: parameters).responseJSON() {
            response in
            
            switch response.result {
                
                case let .Success(data):
                    
                    let json = JSON(data)
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