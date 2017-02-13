//
//  WebViewVC.m
//  RallyUp
//
//  Created by Gordon Kung on 2/13/17.
//  Copyright © 2017 GKCo. All rights reserved.
//

#import "WebViewVC.h"

@interface WebViewVC ()

@end

@implementation WebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSURL *nsurl= self.url;
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [self.webView loadRequest:nsrequest];
//    self.webView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.webView];
}


@end
