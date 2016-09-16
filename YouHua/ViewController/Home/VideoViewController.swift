//
//  VideoViewController.swift
//  YouHua
//
//  Created by 高洋 on 16/8/17.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    var videoUrl: String = ""
    lazy var videoView: VideoView = {
        let temp = VideoView(frame: CGRect(x: 0, y: 0, width: Screen_Height, height: Screen_Width))
        return temp
    }()
    
    var backButton: UIButton = {
        let temp = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        temp.setImage(UIImage(named: "ic_nav_second_back_normal_17x17_"), forState: .Normal)
        return temp
    }()//返回按钮
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
        self.view.addSubview(videoView)
        self.view.addSubview(backButton)
        
        
        videoView.initVideoView(videoUrl)
        videoView.player?.play()
        //videoView.playButton.selected = true
        backButton.addTarget(self, action: #selector(closeViewAction), forControlEvents: .TouchUpInside)
    }
    
    override func closeViewAction() {
        
        videoView.removeVideoView()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //强制改变旋转
    override func shouldAutorotate() -> Bool {
        
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        
        return [.LandscapeLeft, .LandscapeRight]
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        
        return .LandscapeLeft
    }
    
    deinit {
        print("VideoViewController deinit")
    }
}