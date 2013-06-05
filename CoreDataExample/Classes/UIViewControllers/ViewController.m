//  ViewController.m

#import "ViewController.h"
#import "User.h"
#import "Plant.h"

@implementation ViewController

#pragma mark - View LifeStyle

- (void)viewDidLoad; {
  [super viewDidLoad];
  
  _refreshControl = [[UIRefreshControl alloc] init];
  [_refreshControl addTarget:self action:@selector(fetchUsers) forControlEvents:UIControlEventValueChanged];
  [_tableView addSubview:_refreshControl];
  [self fetchUsers];
}

#pragma mark - Methods

- (void)fetchUsers; {
  [[ServerController sharedServerController] fetchUsersWithDelegate:self];
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
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if(!cell){
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
  }
  User * user = [_tableDataArray objectAtIndex:indexPath.row];
  
  cell.textLabel.text = user.user_name;
  
  if(user.plants.count > 0){
    Plant * plant = [user.plants.allObjects objectAtIndex:0];
    cell.detailTextLabel.text = plant.common_name;
  }
  
  return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath; {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ServerController Methods

- (void)serverController:(ServerController *)aServerController didFetchUsers:(NSArray *)aUsersArray; {
  _tableDataArray = aUsersArray;
  [_tableView reloadData];
  [_refreshControl endRefreshing];
  
  if(aUsersArray.count > 0){
    User * user = [aUsersArray objectAtIndex:0];
    NSLog(@"User: %@ The Plants: %@", user, user.plants.allObjects);
  }
}

@end