//
//  ComposeViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/7/1.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import TZImagePickerController
import Alamofire

typealias ComposeProtocol = protocol<UICollectionViewDelegate, UICollectionViewDataSource, WFProgress, TZImagePickerControllerDelegate>
//typealias dismissViewControllerBlock = (() -> ()) = {}
/// 返回参数
//typealias YBNetworkingFinish = (result: [String: AnyObject]?, error: NSError?) -> ()

class ComposeViewController: UIViewController, ComposeProtocol {

    var dismissViewControllerBlock: (() -> ()) = {}
    
    let cellIdentifier = "cellid"
    lazy var collectionView: UICollectionView = {
        //布局对象
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        flowLayout.itemSize = CGSize(width: (SCREEN_WIDTH - 30) / 3, height: (SCREEN_WIDTH - 30) / 3)
        flowLayout.minimumInteritemSpacing = 5 //列间距
        flowLayout.minimumLineSpacing = 5 //行间距
        
        let temp = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: flowLayout)
        temp.backgroundColor = RGBA(red: 240, green: 240, blue: 240, alpha: 0.5)
        return temp
    }()
    
    //NSMutableArray *_selectedPhotos;
    var photosArray: NSMutableArray = NSMutableArray()
    var pass: Array<AnyObject> = []
    var textData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initView() {
        
        self.view.backgroundColor = UIColor.whiteColor()
        navigationItem.title = "发布"
        setNavigationItem(title: "ic_nav_close_normal_16x16_.png", selector: #selector(closeViewAction), isRight: false)
        setNavigationItem(title: "发布", selector: #selector(submitButton), isRight: true)
        
        self.view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //注册cell
        collectionView.registerClass(ComposeViewCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
        
        //注册header
        collectionView.registerClass(ComposeReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        //注册footer
        collectionView.registerClass(ComposeReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
    }
    
    //关闭视图
    override func closeViewAction(){
        
        dismissViewControllerBlock()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //发布按钮
    func submitButton(){
        
        composeData()
    }
    
//  MARK: - Delegate
    
    //分组头部、尾部
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as! ComposeReusableView
            headerView.initView(ComposeViewType.Header)
            textData = headerView.textView.text
            return headerView
        case UICollectionElementKindSectionFooter:
            
            let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath) as! ComposeReusableView
            footerView.initView(ComposeViewType.Footer)
            return footerView
        default:
            return ComposeReusableView()
        }
    }
    
    //返回分组的头部视图的尺寸，在这里控制分组头部视图的高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: SCREEN_WIDTH, height: 180)
    }
    
    //返回分组脚部视图的尺寸，在这里控制分组脚部视图的高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: SCREEN_WIDTH, height: 200)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if photosArray.count < 9 {
//            return photosArray.count + 1
//        }
        
        print(photosArray.count)
        let count: Int = (photosArray.count < 9) ? photosArray.count + 1 : photosArray.count
        print(count)
        return count //photosArray.count == 0 ? 1 : photosArray.count + 1// photosArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: ComposeViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! ComposeViewCell
        
        // 是否隐藏删除按钮
        cell.isHiddenDelBut = (indexPath.row == photosArray.count) ? true : false
        
        if indexPath.row == photosArray.count {
            cell.coverView.image = UIImage(named: "compose_pic_add")
        } else {
            cell.coverView.image = photosArray[indexPath.row] as? UIImage
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(composeDelPicture(_:)), forControlEvents: .TouchUpInside)
        }
//        if indexPath.row == 9 {
//            cell.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
//        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == photosArray.count {
            
            composeAddPicture()
        } else {
            
            //let preview = TZImagePickerController()
            
        }
    }
    
//    #pragma mark - 保存图片至沙盒
//    - (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
//    {
//    
//    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
//    // 获取沙盒目录
//    
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
//    // 将图片写入文件
//    
//    [imageData writeToFile:fullPath atomically:NO];
//    }
    
    func composeData() {
        
        //获取textView
        //let textData = "123123".dataUsingEncoding(NSUTF8StringEncoding)
        
        var parameters: [String: AnyObject]
        
        parameters = [
            "content": textData
        ]
        //图片
        //let path = NSBundle.mainBundle().pathForResource("img_01", ofType: "png")
        //let imageData = NSData(contentsOfFile: path!)
        
        Alamofire.upload(.POST, API_RUL + compose_url, multipartFormData: { (formData) in
            //加载提示菊花
            self.WFShowHUD("上传中...", status: WFStatusHUD.Success)
            //PS:上传图片前，必须先压缩图片，不然图片过大，可能会导致上传失败！
            
//            formData.appendBodyPart(data: textData!, name: "content")
//            //formData.appendBodyPart(data: image, name: imageName, mimeType: "image/png")
//            
//
//            
//            for (NSData *imageData in imageDatas) {
//                
//                formData.appendBodyPart(data: image, name: imageName, mimeType: "image/png")
//                
//                imgCount++;
//                
//            }
            // 上传多张图片
//            for(NSInteger i = 0; i < self.imageDataArray.count; i++)
//            {
//                //取出单张图片二进制数据
//                NSData * imageData = self.imageDataArray[i];
//                
//                // 上传的参数名，在服务器端保存文件的文件夹名
//                NSString * Name = [NSString stringWithFormat:@"%@%ld", Image_Name, i+1];
//                // 上传filename
//                NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];
//                
//                [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpeg"];
//            }
            
            for index in 0..<self.photosArray.count {
                
                //取出单张图片二进制数据
                //let imageData: NSData = self.photosArray[index] as! NSData
                let imagePath = self.savePicture(self.photosArray[index] as! UIImage, name: "\(index)")
                //上传到参数名，在服务器端保存文件到文件名
                //2. 利用时间戳当做图片名字
                let fileName: String = "\(index).jpg"
                
                formData.appendBodyPart(data: NSData(contentsOfFile: imagePath)!, name: "fileArr[]", fileName: fileName, mimeType: "image/jpeg")
                
                
//                let imagePath = self.savePicture(self.photosArray[index] as! UIImage, name: "\(index)") image/jpeg/png/jpg
//                let imageData = NSData(contentsOfFile: imagePath)
//                
//                formData.appendBodyPart(data: imageData!, name: "file1", fileName: "\(index).png", mimeType: "image/png")
            }
            
            //formData.appendBodyPart(data: imageData!, name: "file1", fileName: "img_01.png", mimeType: "image/png")
            
            for (key, value) in parameters {
                
                formData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            
            }) { (encodingResult) in
                
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseString { response in
                        print(response)
                        self.WFHideHUD()
                        self.closeViewAction()
                        //self.dismissViewControllerAnimated(true, completion: nil)
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
//                switch encodingResult {
//                                    case .Success(let upload, , ):
//                                        upload.responseJSON { request, response, JSON, error in
//                                            println(request)
//                                            println(response)
//                                            println(error)
//                                            println(JSON)
//                                        }
//                                    case .Failure(let encodingError):
//                                        println(encodingError)
//                                    }
        }
        
        
    }
    
    func composeUploadPicture(image: UIImage) {
        
        
        
        //compose_url
        //    上传照片    :param: url      上传url    :param: path  图片path
        
//        static func uploadImage(url:String,parameter:String,imagePath:NSURL ,requestDelegate:RequestDelegate){
//            
//            Alamofire.upload( .POST, URLString: url, multipartFormData: { multipartFormData in
//                
//                multipartFormData.appendBodyPart(fileURL: imagePath, name: "file")
//                }, encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .Success(let upload, , ):
//                    upload.responseJSON { request, response, JSON, error in
//                        println(request)
//                        println(response)
//                        println(error)
//                        println(JSON)
//                    }
//                case .Failure(let encodingError):
//                    println(encodingError)
//                }
//            }
//            )
//        }
    }
    
    func composeDelPicture(sender: UIButton) {
        
        photosArray.removeObjectAtIndex(sender.tag)
        
        self.collectionView.reloadData()
//        collectionView.performBatchUpdates({
//            
//            let indexPath: NSIndexPath = NSIndexPath(forItem: sender.tag, inSection: 0)
//            self.collectionView.deleteItemsAtIndexPaths([indexPath])
//        }) { (finished: Bool) in
//            
//            self.collectionView.reloadData()
//        }
//        collectionView.performBatchUpdates({
//            
//            let indexPath: NSIndexPath = NSIndexPath(forItem: sender.tag, inSection: 0)
//            self.collectionView.deleteItemsAtIndexPaths([indexPath])
//            
//            }, completion: nil)
    }
    
    func composeAddPicture() {
        
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            //初始化图片控制器
            let picker = TZImagePickerController(maxImagesCount: (9 - photosArray.count), delegate: self)
//            let picker = TZImagePickerController()
//            picker.pickerDelegate = self
//            picker.maxImagesCount = 9 - self.photosArray.count
            // You can get the photos by block, the same as by delegate.
            // 你可以通过block或者代理，来得到用户选择的照片.
//            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
//                
//                }];
            self.presentViewController(picker, animated: true, completion: nil)
        } else {
            print("读取相册错误")
        }
    }
    
//  MARK: - PickerDelegate
//    photosArray.addObjectsFromArray(assets)
//    print(assets)
//    collectionView.reloadData()
//    dismissViewControllerAnimated(true, completion: nil)
    //获取选择的原图
    func savePicture(image: UIImage, name: String) -> String {
        
        //先把图片转成NSData
        let imageData: NSData
        //压缩图片方法
        if UIImagePNGRepresentation(image) == nil {
            imageData = UIImageJPEGRepresentation(image, 0.5)!
        } else {
            imageData = UIImagePNGRepresentation(image)!
        }
        //获取沙盒目录
        let fullPath = NSHomeDirectory().stringByAppendingString("/Documents/").stringByAppendingString(name).stringByAppendingString(".jpg")
        //将图片写入文件
        imageData.writeToFile(fullPath, atomically: false)
        
        //得到选择后沙盒中图片的完整路径
        //let imagePath: String = "\(fullPath)/\(name).jpg"
        
        print(fullPath)
        return fullPath
    }
    
    //选择了图片
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool) {
        
            photosArray.addObjectsFromArray(photos)
        
            collectionView.reloadData()
    }
    func imagePickerControllerDidCancel(picker: TZImagePickerController!) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
//    func assetsPickerControllerDidCancel(picker: CTAssetsPickerController!) {
//        
//        picker.dismissViewControllerAnimated(true, completion: nil)
//    }
//    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool) {
//        
//        photosArray.addObjectsFromArray(photos)
//        print(photosArray.count)
//        collectionView.reloadData()
//    }
    
    //选择了视频
    
    
    deinit {
        print("ComposeViewController deinit")
    }
}
