//  ServerController.h

#import "CoreDataStackController.h"
#import <RestKit/RestKit.h>

@class ServerController;

@protocol ServerControllerDelegate

@optional
- (void)serverController:(ServerController *)aServerController didFetchUsers:(NSArray *)aUsersArray;

@end

@interface ServerController : CoreDataStackController {
  RKObjectManager * _objectManager;
}

+ (ServerController *)sharedServerController;

- (void)fetchUsersWithDelegate:(id<ServerControllerDelegate>)aDelegate;

@end