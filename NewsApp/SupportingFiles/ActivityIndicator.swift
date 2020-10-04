//
//  ActivityIndicator.swift
//  NewsApp
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Apple. All rights reserved.
//


import SwiftUI

//MARK: ActivityIndicator:- Progress bar to show When established a connection from the Server.

open class ActivityIndicator{
    
    //MARK: Properties
    
    //backGroundView:- where we have to add Activity Indicator.
    var backGroundView : UIView?
    
    //overlayView:- to show the shadow  where we can add Activity Indicator  and the background overlay of Indicator.
    var overlayView : UIView?
    
    //ActivityIndicator:- To Show activity indicator on the top of the Screen.
    var activityIndicator : UIActivityIndicatorView?
    
    //shared:- an instance of a class in the form of singleton.
    class var shared: ActivityIndicator {
        struct Static {
            static let instance: ActivityIndicator = ActivityIndicator()
        }
        return Static.instance
    }
    
    // Initialisation.
    // Create a Window of the screen of topView add Back ground view on the top of the window  also add overlay on the background view on that overlay added activity Indicator.
    init(){
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let frame = window?.rootViewController?.view.bounds
        self.backGroundView = UIView()
        self.backGroundView?.frame = CGRect(x: 0, y: 0, width: frame?.width ?? 100.0, height: frame?.height ?? 100.0)
        self.backGroundView?.backgroundColor = UIColor.clear
        self.overlayView = UIView()
        self.activityIndicator = UIActivityIndicatorView()
        overlayView?.frame = CGRect(x: 0, y: 0, width: 80.0, height: 80.0)
        overlayView?.backgroundColor = UIColor(white: 0, alpha: 0.7)
        //UIColor.init(red: 215.0/255.0, green: 150.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        overlayView?.clipsToBounds = true
        overlayView?.layer.cornerRadius = 10
        overlayView?.layer.zPosition = 1
        
        self.backGroundView?.addSubview(overlayView ?? UIView())
        activityIndicator?.frame = CGRect(x:0, y:0, width:40, height:40)
        activityIndicator?.center = CGPoint(x:(overlayView?.bounds.width ?? 80.0) / 2,y: (overlayView?.bounds.height ?? 80.0) / 2)
        activityIndicator?.style = .large
        activityIndicator?.color = .white
        overlayView?.addSubview(activityIndicator ?? UIActivityIndicatorView())
    }
    
    // showOverlay:- to show overlay on the top of the Screen.
    /// - Parameter view: add a view where we have to add the Activity Indicator.
    open func showOverlay(_ view: UIView?) {
        DispatchQueue.main.async {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            self.overlayView?.center = (window?.center ?? CGPoint(x: 0, y: 0))
            // view.addSubview(overlayView)
            if window?.subviews.contains(self.backGroundView ?? UIView()) == false{
                window?.addSubview(self.backGroundView ?? UIView())
            }
            self.activityIndicator?.startAnimating()
        }
    }
    
    /// Hide activity Indicator from the view.
    open func hideOverlayView() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            // self.overlayView.removeFromSuperview()
            self.backGroundView?.removeFromSuperview()
        }
    }
}



