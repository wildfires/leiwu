//
//  VideoView.swift
//  YouHua
//
//  Created by 高洋 on 16/7/31.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

protocol VideoViewDelegate: NSObjectProtocol {
    func videoView(videoView: VideoView, didSelectedVideoAtIndex index: Int)
    func videoView(videoView: VideoView, currentTime: Float64, durationTime: Float64)
}

class VideoView: UIView {
    
    weak var delegate: VideoViewDelegate!
    
    var VIEW_WIDTH: CGFloat = 0
    var VIEW_HEIGHT: CGFloat = 0
    
    var player: AVPlayer? //播放器对象
    var playerLayer: AVPlayerLayer?
    var playerItem: AVPlayerItem? //播放属性
    
    var timeObserver: AnyObject?
    
//    var isPlay: Bool = false //播放状态
//    var isFull: Bool = false //是否全屏
    
    var videoBgView: UIView?
    
    var cacheProgressView: UIProgressView? // 缓存百分比
    
    var videoBarView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor(patternImage: UIImage(named: "bg_media_default")!)
        return temp
    }()//播放工具栏
    var playSlider: UISlider = {
        let temp = UISlider()
        temp.setThumbImage(UIImage(named: "thumbImage"), forState: .Normal)
        temp.value = 0
        return temp
    }()//播放进度
    var playButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "play"), forState: .Normal)
        return temp
    }()//播放按钮
    var fullButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(named: "full_screen"), forState: .Normal)
        
        return temp
    }()//全屏按钮
    var timeLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(name: FONT_NAME, size: 8)
        temp.textColor = UIColor.whiteColor()
        //temp.text = "0:00:00/0:00:00"
        return temp
    }()//播放时间
    
    var totalDuration: Float64 = 0 //总时长
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        VIEW_WIDTH = frame.size.width
        VIEW_HEIGHT = frame.size.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initVideoView(url: String) {
        
        initVew()
//        if (thePlayer.currentItem) {
//            
//            [thePlayer replaceCurrentItemWithPlayerItem:anItem];
//            
//        }else{
//            
//            thePlayer = [AVPlayer playerWithPlayerItem:anItem];
//            
//        }
        let videoURL: NSURL = NSURL(string: url)!
        let videoAsset: AVAsset = AVAsset(URL: videoURL)
        playerItem = AVPlayerItem(asset: videoAsset)
        if ((player?.currentItem) != nil) {
            
            player?.replaceCurrentItemWithPlayerItem(playerItem)
        } else {
            
            player = AVPlayer(playerItem: playerItem!)
        }
        playerLayer = AVPlayerLayer(player: player)
        
        playerLayer = self.layer as? AVPlayerLayer
        playerLayer?.player = player
        playerLayer?.videoGravity = AVLayerVideoGravityResizeAspect
        
        //监听当前时间
        //[thePlayer removeTimeObserver:playbackObserver];
        
        
        weak var weakSelf: VideoView? = self
        timeObserver = player?.addPeriodicTimeObserverForInterval(CMTime(value: 1, timescale: 1), queue: nil, usingBlock: { (time: CMTime) in
            
            let currentTime: Float64 = CMTimeGetSeconds(weakSelf!.playerItem!.currentTime())
            let durationTime: Float64  = CMTimeGetSeconds(weakSelf!.playerItem!.duration)
            
            weakSelf!.playSlider.value = Float(currentTime / durationTime)
            //weakSelf!.timeLabel.text = "\(weakSelf!.timeForString(currentTime))/\(weakSelf!.timeForString(durationTime))"
            
//            weakSelf!.delegate.videoView(weakSelf!, currentTime: currentTime, durationTime: durationTime)
            weakSelf!.totalDuration = durationTime
        })
    }
    
    func initVew() {
        
        self.backgroundColor = RGBA(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.addSubview(videoBarView)
        videoBarView.addSubview(playButton)
        videoBarView.addSubview(playSlider)
        videoBarView.addSubview(timeLabel)
        videoBarView.addSubview(fullButton)
        
        weak var weakSelf: VideoView? = self
        videoBarView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(weakSelf!).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.height.equalTo(30)
        }
        playButton.snp_makeConstraints { (make) in
            make.top.left.bottom.equalTo(videoBarView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.size.equalTo(30)
        }
        playSlider.snp_makeConstraints { (make) in
            make.top.equalTo(videoBarView).offset(0)
            make.left.equalTo(playButton.snp_right).offset(5)
            make.right.equalTo(timeLabel.snp_left).offset(-5)
            make.height.equalTo(30)
        }
        timeLabel.snp_makeConstraints { (make) in
            make.top.equalTo(videoBarView).offset(0)
            make.left.equalTo(playSlider.snp_right).offset(5)
            make.right.equalTo(fullButton.snp_left).offset(-5)
            make.height.equalTo(30)
        }
        fullButton.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(videoBarView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            make.size.equalTo(30)
        }
        
        
        
        playSlider.addTarget(self, action: #selector(updateSliderValue(_:)), forControlEvents: .TouchUpInside)
        playButton.addTarget(self, action: #selector(playOrPause(_:)), forControlEvents: .TouchUpInside)
        fullButton.addTarget(self, action: #selector(miniOrFull(_:)), forControlEvents: .TouchUpInside)
    }
    
    override class func layerClass() -> AnyClass {
        
        return AVPlayerLayer.self
    }
    
    //播放/暂停
    func playOrPause(button: UIButton) {
        
        button.selected = !button.selected
        if button.selected {
            
            player?.pause()
            playButton.setImage(UIImage(named: "play"), forState: .Normal)
        } else {
            
            player?.play()
            playButton.setImage(UIImage(named: "pause"), forState: .Normal)
        }
    }
    
//    - (void)PlayOrPause:(UIButton *)sender{
//    if (self.durationTimer==nil) {
//    self.durationTimer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(finishedPlay:) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
//    }
//    sender.selected = !sender.selected;
//    if (self.player.rate != 1.f) {
//    if ([self currentTime] == [self duration])
//    [self setCurrentTime:0.f];
//    [self.player play];
//    } else {
//    [self.player pause];
//    }
//    
//    //    CMTime time = [self.player currentTime];
//    }
    
    //全屏/缩小
    func full() {
        
        
    }
    func miniOrFull(button: UIButton) {
        
        //
        
        
        button.selected = !button.selected
        
        videoViewSwitchOrientation(button.selected)
        if button.selected {
            
//            self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
//            //self.layoutIfNeeded()
//            playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            fullButton.setImage(UIImage(named: "mini_screen"), forState: .Normal)
//            [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
//            [wmPlayer removeFromSuperview];
//            wmPlayer.transform = CGAffineTransformIdentity;
//            if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
//                wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
//            }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
//                wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
//            }
//            wmPlayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//            wmPlayer.playerLayer.frame =  CGRectMake(0,0, self.view.frame.size.height,self.view.frame.size.width);
//            
//            [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(40);
//                make.top.mas_equalTo(self.view.frame.size.width-40);
//                make.width.mas_equalTo(self.view.frame.size.height);
//                }];
//            
//            [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(wmPlayer).with.offset((-self.view.frame.size.height/2));
//                make.height.mas_equalTo(30);
//                make.width.mas_equalTo(30);
//                make.top.equalTo(wmPlayer).with.offset(5);
//                
//                }];
//            
//            
//            [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
//            wmPlayer.isFullscreen = YES;
//            wmPlayer.fullScreenBtn.selected = YES;
//            [wmPlayer bringSubviewToFront:wmPlayer.bottomView];
            
            
//            self.transform = CGAffineTransformIdentity
//            self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
//            
            
            //playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        } else {
            
            //self.frame = CGRect(x: 0, y: 0, width: VIEW_WIDTH, height: VIEW_HEIGHT)
            playerLayer?.videoGravity = AVLayerVideoGravityResizeAspect
            fullButton.setImage(UIImage(named: "full_screen"), forState: .Normal)
        }
    }
    
    func videoViewSwitchOrientation(isFull: Bool) {
        
        if isFull {
            
        } else {
            
        }
        
        
        
        
        //self.currentPlayerLayer.transform = CATransform3DMakeRotation(M_PI/2, 0, 0, 1);
        //self.currentPlayerLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.layer.frame = CGRect(x: 0, y: 0, width: SCREEN_HEIGHT, height: SCREEN_WIDTH)
        self.playerLayer?.transform = CATransform3DMakeRotation(CGFloat(M_PI) / 2, 0, 0, 1)
        
        self.playerLayer?.frame = CGRect(x: 0, y: 0, width: SCREEN_HEIGHT, height: SCREEN_WIDTH)
        
        self.playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.backgroundColor = UIColor.blueColor()
        
        //UIApplication.sharedApplication().keyWindow?.addSubview(self)
        
    }
    
    //快进／快退
    func updateSliderValue(step: AnyObject) {
        
        let dragedSeconds = Int64(floorf(Float(totalDuration) * step.value))
        let dragedTime = CMTime(value: dragedSeconds, timescale: 1)
        playButton.selected = false
        
        weak var weakSelf: VideoView? = self
        playerLayer?.player?.seekToTime(dragedTime, completionHandler: { (finish: Bool) -> Void in
            weakSelf!.playButton.selected = true
        })
    }
    
    func timeForString(second: Float64) -> String {
        
        let seconds = Int(second % 60)
        let minutes = Int((second / 60) % 60)
        let hours = Int((second / 60) / 60)
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func removeVideoView() {
        
        self.removeFromSuperview()
        if timeObserver != nil {
            player?.removeTimeObserver(timeObserver!)
        }
//        self.player?.currentItem?.cancelPendingSeeks()
//        self.player?.currentItem?.asset.cancelLoading()
    }
}








