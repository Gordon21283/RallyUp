//
//  WebViewVC.h
//  RallyUp
//
//  Created by Gordon Kung on 2/13/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewVC : UIViewController

@property (weak, nonatomic) NSURL *url;
@property (strong,nonatomic) UIWebView *webView;

@end
