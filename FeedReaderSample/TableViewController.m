//
//  TableViewController.m
//  FeedReaderSample
//
//  Created by bs on 2015/07/30.
//  Copyright (c) 2015年 bs. All rights reserved.
//

#import "TableViewController.h"
#import "MWFeedParser.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  // 追加
  parsedItems = [[NSMutableArray alloc] init];
  itemsToDisplay = [[NSArray array] init];
  
  // 最初の
  NSURL *feedURL = [NSURL URLWithString:@"http://www.oreilly.co.jp/catalog/soon.xml"];
  feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
  feedParser.delegate = self;
  feedParser.feedParseType = ParseTypeFull;
  feedParser.connectionType = ConnectionTypeAsynchronously;
  [feedParser parse];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//    return 10;
  return itemsToDisplay.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  
//  cell.textLabel.text = @"test";
 
  MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
  cell.textLabel.text = item.title;
  
  
  return cell;
}


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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
