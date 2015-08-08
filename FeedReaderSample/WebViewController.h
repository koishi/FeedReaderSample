//
//  WebViewController.h
//  FeedReaderSample
//
//  Created by bs on 2015/08/02.
//  Copyright (c) 2015年 bs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (strong,nonatomic) NSString *URL;

@end
