//
//  HelpViewController.m
//  Dr.Prebid
//
//  Created by Punnaghai Puviarasu on 7/11/18.
//  Copyright © 2018 Prebid. All rights reserved.
//

#import "HelpViewController.h"
#import <WebKit/WebKit.h>
#import "PBVSharedConstants.h"

@interface HelpViewController () <WKNavigationDelegate, WKUIDelegate>
@property     UIActivityIndicatorView *activityIndicator;
@end

@implementation HelpViewController

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    WKWebView *content = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    content.navigationDelegate = self;
    content.UIDelegate = self;
    NSString * filePath;
    if ([self.title isEqualToString:kAboutString]) {
        filePath = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
    } else if( [self.title isEqualToString:kGeneralInfoHelpString]) {
        filePath = [[NSBundle mainBundle] pathForResource:@"info-general" ofType:@"html"];
    } else if ( [self.title isEqualToString:kAdServerInfoHelpString]) {
        filePath = [[NSBundle mainBundle] pathForResource:@"info-ad-server" ofType:@"html"];
    } else if ( [self.title isEqualToString:kPrebidServerInfoHelpString]) {
        filePath = [[NSBundle mainBundle] pathForResource:@"info-prebid-server" ofType:@"html"];
    }
    NSURL *filePathURL = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:filePathURL];
    [self.view addSubview:content];
    // Add activity indicator
    self.activityIndicator = [[UIActivityIndicatorView alloc] init];
    self.activityIndicator.center = self.view.center;
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.activityIndicatorViewStyle   = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:self.activityIndicator];
    [content loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self.activityIndicator startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self.activityIndicator stopAnimating];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
}

@end
