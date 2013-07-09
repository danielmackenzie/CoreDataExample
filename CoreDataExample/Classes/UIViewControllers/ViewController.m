//  ViewController.m

#import "ViewController.h"
#import "User.h"
#import "Message.h"
#import "MessageCell.h"
#import "NSDataAdditions.h"

@implementation ViewController

#pragma mark - View LifeStyle

- (void)viewDidLoad; {
  [super viewDidLoad];
  
  _refreshControl = [[UIRefreshControl alloc] init];
  [_refreshControl addTarget:self action:@selector(fetchUsers) forControlEvents:UIControlEventValueChanged];
  [_tableView addSubview:_refreshControl];
  
  NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[ServerController sharedServerController].managedObjectContext];
  NSFetchRequest * request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDescription];
  
  NSArray * array = [[ServerController sharedServerController].managedObjectContext executeFetchRequest:request error:nil];
  
  if(array.count > 0){
    User * user = [array objectAtIndex:0];
    _tableDataArray = user.messages.allObjects;
    [_tableView reloadData];
  }
}

#pragma mark - Methods

- (void)fetchUsers; {
  [[ServerController sharedServerController] fetchUsersWithDelegate:self];
}

- (IBAction)getDataButtonPressed:(UIButton *)aButton; {
  [self fetchUsers];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
  return _tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
  static NSString * cellIdentifier = @"Cell";
  MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  Message * message = [_tableDataArray objectAtIndex:indexPath.row];
  
  if(!cell){
    cell = [[MessageCell alloc] init];
  }
  cell.message = message;
  return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ServerController Methods

- (void)serverController:(ServerController *)aServerController didFetchUsers:(NSArray *)aUsersArray; {
  User * user = [aUsersArray objectAtIndex:0];
  _tableDataArray = user.messages.allObjects;
  [_tableView reloadData];
  [_refreshControl endRefreshing];
  
  if(aUsersArray.count > 0){
    User * user = [aUsersArray objectAtIndex:0];
    NSLog(@"User: %@ The Messages: %@", user, user.messages.allObjects);
  }
}

@end