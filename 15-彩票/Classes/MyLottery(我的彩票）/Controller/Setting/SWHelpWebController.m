//
//  SWHelpWebController.m
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import "SWHelpWebController.h"
#import <WebKit/WKWebView.h>

@interface SWHelpWebController () <WKNavigationDelegate>

@end

@implementation SWHelpWebController

/// 把控制器变成 webview
-(void)loadView{
    self.view = [[WKWebView alloc] initWithFrame:KScreenSize];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载网页
    WKWebView *webView = (WKWebView *) self.view;
    webView.navigationDelegate = self;
    // 创建 URL 对象
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.help.html withExtension:nil];
    // 通过一个统一资源定位符 包装成一个请求
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    // 加载请求
    [webView loadRequest:req];

}
/// 页面加载完成的回调
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

    NSString *javascript = [NSString stringWithFormat:@"window.location.href = '#%@';",self.help.ids];
    [webView evaluateJavaScript:javascript completionHandler:^(id _Nullable, NSError * _Nullable error) {
        NSLog(@"调用js方法完成");
    }];
}

@end
