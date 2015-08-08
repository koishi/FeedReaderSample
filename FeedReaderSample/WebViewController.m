//
//  WebViewController.m
//  FeedReaderSample
//
//  Created by bs on 2015/08/02.
//  Copyright (c) 2015年 bs. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // ページ読み込み
  self.webView.delegate = self;
  NSURL *url = [NSURL URLWithString:self.URL];
  [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  // タイトル取得と表示
  NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
  self.title = title;
}

- (void)dealloc
{
  [self.webView stopLoading];
  self.webView.delegate = nil;
}

@end
