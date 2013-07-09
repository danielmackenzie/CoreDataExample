//  ViewController.h

#import <UIKit/UIKit.h>
#import "ServerController.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ServerControllerDelegate> {
  NSArray              * _tableDataArray;
  UIRefreshControl     * _refreshControl;
  IBOutlet UIImageView * _imageView;
  IBOutlet UITableView * _tableView;
}

- (void)fetchUsers;
- (IBAction)getDataButtonPressed:(UIButton *)aButton;

@end