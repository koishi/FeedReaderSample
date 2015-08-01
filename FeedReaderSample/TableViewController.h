//
//  TableViewController.h
//  FeedReaderSample
//
//  Created by bs on 2015/07/30.
//  Copyright (c) 2015年 bs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@interface TableViewController : UITableViewController
<MWFeedParserDelegate> {

  MWFeedParser *feedParser;
  NSMutableArray *parsedItems;

  // 追加
  NSArray *itemsToDisplay;
}

@end
