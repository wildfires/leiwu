//
//  LoginAndRegController.swift
//  YouHua
//
//  Created by 高洋 on 16/7/17.
//  Copyright © 2016年 Wildfire. All rights reserved.
//

import UIKit
import SnapKit

typealias dismissLoginViewControllerBlock = () -> Void

class LoginAndRegController: UIViewController, UITextFieldDelegate {

    var dismissLoginViewController: dismissLoginViewControllerBlock!
    
    var topConstraint: Constraint? //顶部约束
    var isJumpHomeViewController: Bool = false
    
    lazy var imageView: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        temp.userInteractionEnabled = true
        temp.contentMode = .ScaleAspectFill
        temp.clipsToBounds = true
        return temp
    }()
    
    lazy var closeButton: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = UIColor.grayColor()
        temp.setImage(UIImage(named: "compose_card_delete_highlighted"), forState: .Normal)
        temp.addTarget(self, action: #selector(closeViewAction), forControlEvents: .TouchUpInside)
        return temp
    }()
    
    lazy var logoView: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .Center
        temp.clipsToBounds = true
        temp.image = UIImage(named: "logo")
        return temp
    }()
    
    lazy var userField: UITextField = {
        let temp = UITextField()
        temp.layer.cornerRadius = 4
        temp.layer.masksToBounds = true
        temp.backgroundColor = RGBA(red: 255, green: 255, blue: 255, alpha: 0.8)
        temp.textColor = UIColor.blackColor()
        temp.font = UIFont(name: FONT_NAME, size: 12)
        temp.leftView = UIView(frame: CGRectMake(0, 0, 44, 44))
        temp.leftViewMode = .Always
        return temp
    }()
    
    lazy var passField: UITextField = {
        let temp = UITextField()
        
//        var maskLayer = CAShapeLayer()
//        maskLayer.path = UIBezierPath(roundedRect: temp.bounds, byRoundingCorners: UIRectCorner.TopLeft, cornerRadii: CGSize(width: 8, height: 8)).CGPath
//        temp.layer.mask = maskLayer
        temp.layer.cornerRadius = 4
        temp.layer.masksToBounds = true
        temp.backgroundColor = RGBA(red: 255, green: 255, blue: 255, alpha: 0.8)
        temp.textColor = UIColor.blackColor()
        temp.secureTextEntry = true
        temp.font = UIFont(name: FONT_NAME, size: 12)
        temp.leftView = UIView(frame: CGRectMake(0, 0, 44, 44))
        temp.leftViewMode = .Always
        return temp
    }()
    
    lazy var loginAndRegisterButton: UIButton = {
        let temp = UIButton()
        temp.layer.cornerRadius = 4
        temp.layer.masksToBounds = true
        temp.backgroundColor = UIColor.orangeColor()
        temp.titleLabel?.font = UIFont(name: FONT_NAME, size: 14)
        return temp
    }()
    
    lazy var changeButton: UIButton = {
        let temp = UIButton()
        temp.titleLabel?.font = UIFont(name: FONT_NAME, size: 12)
        return temp
    }()
    
    lazy var forgotButton: UIButton = {
        let temp = UIButton()
        temp.setTitle("忘记密码?", forState: .Normal)
        temp.titleLabel?.font = UIFont(name: FONT_NAME, size: 12)
        temp.addTarget(self, action: #selector(forgotPassAction), forControlEvents: .TouchUpInside)
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
        navigationController?.navigationBar.hidden = true
        
        self.view.addSubview(imageView)
        self.view.addSubview(closeButton)
        self.view.addSubview(logoView)
        self.view.addSubview(userField)
        self.view.addSubview(passField)
        self.view.addSubview(loginAndRegisterButton)
        self.view.addSubview(changeButton)
        self.view.addSubview(forgotButton)
        
        userField.delegate = self
        passField.delegate = self
        
        //输入框左侧图标
        let userIcon = UIImageView(frame: CGRectMake(11, 11, 22, 22))
        userIcon.image = UIImage(named: "mine_normal")
        
        let passIcon = UIImageView(frame: CGRectMake(11, 11, 22, 22))
        passIcon.image = UIImage(named: "home_normal")
        
        userField.leftView?.addSubview(userIcon)
        passField.leftView?.addSubview(passIcon)
        
        //首先创建一个模糊效果
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        //接着创建一个承载模糊效果的视图
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.imageView.frame
        blurView.alpha = 0.5 //这句会提示错误
        imageView.addSubview(blurView)
        
        weak var weakSelf: LoginAndRegController? = self
        closeButton.snp_makeConstraints { (make) in
            make.top.right.equalTo(imageView).inset(UIEdgeInsetsMake(24, 0, 0, 8))
            make.size.equalTo(25)
        }
        
        logoView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(imageView).inset(UIEdgeInsetsMake(64, 0, 0, 0))
            make.height.equalTo(105)
        }
        
        userField.snp_makeConstraints { (make) in
            make.left.right.equalTo(imageView).inset(UIEdgeInsetsMake(0, 24, 0, 24))
            make.height.equalTo(44)
            //存储top属性
            weakSelf!.topConstraint = make.top.equalTo(logoView.snp_bottom).offset(48).constraint
        }
        
        passField.snp_makeConstraints { (make) in
            make.top.equalTo(userField.snp_bottom).offset(8)
            make.left.right.equalTo(imageView).inset(UIEdgeInsetsMake(0, 24, 0, 24))
            make.height.equalTo(44)
        }
        
        loginAndRegisterButton.snp_makeConstraints { (make) in
            make.top.equalTo(passField.snp_bottom).offset(24)
            make.left.right.equalTo(imageView).inset(UIEdgeInsetsMake(0, 24, 0, 24))
            make.height.equalTo(44)
        }
        
        changeButton.snp_makeConstraints { (make) in
            make.top.equalTo(loginAndRegisterButton.snp_bottom).offset(5)
            make.left.equalTo(loginAndRegisterButton.snp_left).offset(0)
        }
        
        forgotButton.snp_makeConstraints { (make) in
            make.top.equalTo(loginAndRegisterButton.snp_bottom).offset(5)
            make.right.equalTo(loginAndRegisterButton.snp_right).offset(0)
        }
    }
    
    override func closeViewAction() {
        
        if isJumpHomeViewController {
            dismissLoginViewController()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loginAction() {
        
        dismissLoginViewController()
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isLogin")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func registerAction() {
        
        loginAction()
    }
    
    func forgotPassAction() {
        
        
    }
    
    func loginViewAction() {
        
        forgotButton.hidden = false
        imageView.image = UIImage(named: "login_bg_10")
        userField.placeholder = "手机或邮箱"
        passField.placeholder = "登陆密码"
        loginAndRegisterButton.setTitle("登陆", forState: .Normal)
        loginAndRegisterButton.addTarget(self, action: #selector(loginAction), forControlEvents: .TouchUpInside)
        changeButton.setTitle("注册帐号", forState: .Normal)
        changeButton.addTarget(self, action: #selector(registerViewAction), forControlEvents: .TouchUpInside)
    }
    
    func registerViewAction() {
        
        userField.becomeFirstResponder()
        forgotButton.hidden = true
        imageView.image = UIImage(named: "login_bg_05")
        userField.placeholder = "请输入邮箱"
        passField.placeholder = "请输入密码"
        loginAndRegisterButton.setTitle("注册", forState: .Normal)
        loginAndRegisterButton.addTarget(self, action: #selector(registerAction), forControlEvents: .TouchUpInside)
        changeButton.setTitle("返回登陆", forState: .Normal)
        changeButton.addTarget(self, action: #selector(loginViewAction), forControlEvents: .TouchUpInside)
    }
    
    //文本框获取焦点
    func textFieldDidBeginEditing(textField: UITextField) {
        
        weak var weakSelf: LoginAndRegController? = self
        UIView.animateWithDuration(0.25) { () -> Void in
            weakSelf!.topConstraint?.updateOffset(-24)
            weakSelf!.logoView.alpha = 0
            weakSelf!.view.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //收起键盘
        self.view.endEditing(true)
        //视图约束恢复初始设置
        weak var weakSelf: LoginAndRegController? = self
        UIView.animateWithDuration(0.5) { () -> Void in
            weakSelf!.topConstraint?.updateOffset(48)
            weakSelf!.logoView.alpha = 1
            weakSelf!.view.layoutIfNeeded()
        }
    }
    
    deinit {
        print("LoginAndRegController deinit")
    }
}
