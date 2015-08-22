//
//  TableViewController.m
//  FeedReaderSample
//
//  Created by bs on 2015/07/30.
//  Copyright (c) 2015年 bs. All rights reserved.
//

#import "TableViewController.h"
#import "MWFeedParser.h"
#import "WebViewController.h"

@interface TableViewController ()

@end

static NSString *const kRSSFeedURLString = @"http://www.oreilly.co.jp/catalog/soon.xml";

@implementation TableViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
  
  // 配列初期化
  parsedItems = [[NSMutableArray alloc] init];
  itemsToDisplay = [[NSArray array] init];
  
  // フィード読み込み準備
  NSURL *feedURL = [NSURL URLWithString:kRSSFeedURLString];
  feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
  feedParser.delegate = self;
  feedParser.feedParseType = ParseTypeFull;
  feedParser.connectionType = ConnectionTypeAsynchronously;
  [feedParser parse];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return itemsToDisplay.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

  MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
  cell.textLabel.text = item.title;
  
  return cell;
}

# pragma mark - MWFeedParserDelegate

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {

  if (parsedItems.count == 0) {
    self.title = @"Failed";
  }

  itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
                         [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date"
                                                                              ascending:NO]]];
  self.tableView.userInteractionEnabled = YES;
  self.tableView.alpha = 1;
  [self.tableView reloadData];
  
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
  if (item) [parsedItems addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
  itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
                    [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date"
                                                                         ascending:NO]]];
  self.tableView.userInteractionEnabled = YES;
  self.tableView.alpha = 1;
  [self.tableView reloadData];
}

# pragma mark - Event

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"selectRow"]) {
    MWFeedItem *item = itemsToDisplay[[self.tableView indexPathForSelectedRow].row];
    WebViewController *webVC = [segue destinationViewController];
    webVC.URL = item.link;
  }
}

@end
