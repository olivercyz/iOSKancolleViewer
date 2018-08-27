//
//  ViewController.m
//  kancolleViewer
//
//  Created by cuiyzh on 2018/8/27.
//  Copyright © 2018年 yourForum. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "KCResponseHandlerProtocol.h"

@interface ViewController ()<WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet WKWebView *webView;

@property (nonatomic, strong)NSMutableArray<id<KCResponseHandlerProtocol>> *handlers;

@property (nonatomic, assign)BOOL hasAlerted;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.navigationDelegate = self;
    [self registerHandlers];
    [self reload];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"request with url:%@", navigationAction.request.URL);
    if (decisionHandler) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(nonnull WKNavigationResponse *)navigationResponse decisionHandler:(nonnull void (^)(WKNavigationResponsePolicy))decisionHandler
{
    [self.handlers enumerateObjectsUsingBlock:^(id<KCResponseHandlerProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj httpPath] isEqualToString:navigationResponse.response.URL.path]) {
            NSDictionary *dic = [obj httpQuery];
            BOOL canHandle = YES;
            for (NSString *key in [dic allKeys]) {
                if ([navigationResponse.response.URL.query rangeOfString:[NSString stringWithFormat:@"%@=%@",key, [dic objectForKey:key]]].location == NSNotFound) {
                    canHandle = NO;
                    break;
                }
            }
            if (canHandle) {
                [obj dealWithResponse:navigationResponse.response];
            }
     
        }
    }];
    if (decisionHandler) {
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
}

- (void)reload
{
     [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.dmm.com/netgame/social/application/-/detail/=/app_id=854854"]]];
}

- (void)registerHandlers
{
    NSArray *classNames = @[];
    self.handlers = [NSMutableArray arrayWithCapacity:classNames.count];
    for (NSString *className in classNames) {
        Class class = NSClassFromString(className);
        id<KCResponseHandlerProtocol> handler = (id<KCResponseHandlerProtocol>)[[class alloc] init];
        [self.handlers addObject:handler];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)logout
{
    __block NSInteger count = 0;
    
    [self.webView.configuration.websiteDataStore.httpCookieStore getAllCookies:^(NSArray<NSHTTPCookie *> * _Nonnull cookies) {
        count = cookies.count;
        [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.webView.configuration.websiteDataStore.httpCookieStore deleteCookie:obj completionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (--count == 0) {
                        [self reload];
                    }
                });
            }];
        }];
    }];;
}

@end
