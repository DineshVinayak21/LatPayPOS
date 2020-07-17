//
//  SuccessMessageView.swift
//  posTerminalApplication
//
//  Created by user166170 on 5/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit
//self.view.successMessage(toastMessage: "dummy text", duration: 2.0)

extension UIView
{
    func successMessage(toastMessage:String,duration:CGFloat)
    {
        //View to blur bg and stopping user interaction
        let bgView = UIView(frame: self.frame)
        bgView.backgroundColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(255.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(0.6))
        bgView.tag = 555

        //Label For showing toast text
        let lblMessage = UILabel()
        lblMessage.numberOfLines = 0
        lblMessage.lineBreakMode = .byWordWrapping
        lblMessage.textColor = .white
        lblMessage.backgroundColor = .black
        lblMessage.textAlignment = .center
        lblMessage.font = UIFont.init(name: "Helvetica Neue", size: 17)
        lblMessage.text = toastMessage

        //calculating toast label frame as per message content
        let maxSizeTitle : CGSize = CGSize(width: self.bounds.size.width-16, height: self.bounds.size.height)
        var expectedSizeTitle : CGSize = lblMessage.sizeThatFits(maxSizeTitle)
        // UILabel can return a size larger than the max size when the number of lines is 1
        expectedSizeTitle = CGSize(width:maxSizeTitle.width.getminimum(value2:expectedSizeTitle.width), height: maxSizeTitle.height.getminimum(value2:expectedSizeTitle.height))
        lblMessage.frame = CGRect(x:((self.bounds.size.width)/2) - ((expectedSizeTitle.width+16)/2) , y: (self.bounds.size.height/2) - ((expectedSizeTitle.height+16)/2), width: expectedSizeTitle.width+16, height: expectedSizeTitle.height+16)
        lblMessage.layer.cornerRadius = 8
        lblMessage.layer.masksToBounds = true
        lblMessage.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        bgView.addSubview(lblMessage)
        self.addSubview(bgView)
        lblMessage.alpha = 0

        UIView.animateKeyframes(withDuration:TimeInterval(duration) , delay: 0, options: [] , animations: {
            lblMessage.alpha = 1
            }, completion: {
                sucess in
                UIView.animate(withDuration:TimeInterval(duration), delay: 8, options: [] , animations: {
                    lblMessage.alpha = 0
                    bgView.alpha = 0
                    })
                bgView.removeFromSuperview()
            })
    }
}

extension CGFloat
    {
        func getminimum(value2:CGFloat)->CGFloat
        {
            if self < value2
            {
                return self
            }
            else
            {
                return value2
            }
        }
    }

//MARK: Extension on UILabel for adding insets - for adding padding in top, bottom, right, left.

extension UILabel
{
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }

    var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    override open func draw(_ rect: CGRect)
    {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }

    override open var intrinsicContentSize: CGSize
    {
        get {
            var contentSize = super.intrinsicContentSize
            if let insets = padding {
                contentSize.height += insets.top + insets.bottom
                contentSize.width += insets.left + insets.right
                }
            return contentSize
        }
    }
}


/*
open class SuccessMessageView: UILabel {
    
    var overlayView = UIView()
    var backView = UIView()
    var lbl = UILabel()
    
    class var shared: SuccessMessageView {
        struct Static {
            static let instance: SuccessMessageView = SuccessMessageView()
        }
        return Static.instance
    }
    
    func setup(_ view: UIView,txt_msg:String)
    {
        let white = UIColor ( red: 1/255, green: 0/255, blue:0/255, alpha: 0.0 )
        
        backView.frame = CGRect(x: 0, y: 0, width: view.frame.width , height: view.frame.height)
        backView.center = view.center
        backView.backgroundColor = white
        view.addSubview(backView)
        
        overlayView.frame = CGRect(x: 0, y: 0, width: view.frame.width - 60  , height: 50)
        overlayView.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height - 100)
        overlayView.backgroundColor = UIColor.black
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        overlayView.alpha = 0
        
        lbl.frame = CGRect(x: 10, y: 0, width: overlayView.frame.width, height: 50)
        lbl.numberOfLines = 0
        lbl.textColor = UIColor.white
        lbl.center = overlayView.center
        lbl.text = txt_msg
        lbl.textAlignment = .center
        lbl.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        overlayView.addSubview(lbl)
        
        view.addSubview(overlayView)
    }
    
    open func short(_ view: UIView,txt_msg:String) {
        self.setup(view,txt_msg: txt_msg)
        //Animation
        UIView.animate(withDuration: 1, animations: {
            self.overlayView.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 1, animations: {
                self.overlayView.alpha = 0
            }) { (true) in
                UIView.animate(withDuration: 1, animations: {
                    DispatchQueue.main.async(execute: {
                        self.overlayView.alpha = 0
                        self.lbl.removeFromSuperview()
                        self.overlayView.removeFromSuperview()
                        self.backView.removeFromSuperview()
                    })
                })
            }
        }
    }
    
    open func long(_ view: UIView,txt_msg:String) {
        self.setup(view,txt_msg: txt_msg)
        //Animation
        UIView.animate(withDuration: 2, animations: {
            self.overlayView.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 2, animations: {
                self.overlayView.alpha = 0
            }) { (true) in
                UIView.animate(withDuration: 2, animations: {
                    DispatchQueue.main.async(execute: {
                        self.overlayView.alpha = 0
                        self.lbl.removeFromSuperview()
                        self.overlayView.removeFromSuperview()
                        self.backView.removeFromSuperview()
                    })
                })
            }
        }
    }
}
*/
