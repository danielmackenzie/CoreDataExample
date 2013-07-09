//  ServerController.m

#import "ServerController.h"
#import "SynthesizeSingleton.h"

@interface ServerController (Private)

- (void)configureRestKit;

@end

@implementation ServerController

SYNTHESIZE_SINGLETON_FOR_CLASS(ServerController)

#pragma mark - Init

- (id)init; {
  if((self = [super init])){
    [self configureRestKit];
  }
  return self;
}

#pragma mark - Methods

- (void)fetchUsersWithDelegate:(id<ServerControllerDelegate>)aDelegate; {
  // Send GET request to the server at path users
  [_objectManager getObjectsAtPath:@"users"
                        parameters:nil
                           success:^(RKObjectRequestOperation * operation, RKMappingResult * mappingResult) {
                             // Fetch the mapped objects from CoreData
                             // This is to get the latest version of the objects
                             NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
                             NSFetchRequest * request = [[NSFetchRequest alloc] init];
                             [request setEntity:entityDescription];
                             
                             NSArray * array = [self.managedObjectContext executeFetchRequest:request error:nil];
                             
                             // Inform the delegate that the request succeeded
                             if([(id)aDelegate respondsToSelector:@selector(serverController:didFetchUsers:)]){
                               [aDelegate serverController:self didFetchUsers:array];
                             }
                           } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                             NSLog(@"Response: %@\n", operation.HTTPRequestOperation.responseString);
                             UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Message Fetch Failed" delegate:aDelegate cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                             [alertView show];
                           }];
  
}

@end

#pragma mark - Private Methods

@implementation ServerController (Private)

- (void)configureRestKit; {
  // Configure CoreData
  NSError * error;
  NSURL * modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CoreData" ofType:@"momd"]]; // Point to your CoreData Model file
  NSManagedObjectModel * managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
  RKManagedObjectStore * managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
  
  [managedObjectStore createPersistentStoreCoordinator];
  
  // Create or load the persistent database from disk
  NSArray * searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString * documentPath = [searchPaths objectAtIndex:0];
  NSPersistentStore * persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:[NSString stringWithFormat:@"%@/CoreData.sqlite", documentPath] fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
  
  if(!persistentStore){
    NSLog(@"Failed to add persistent store: %@", error);
  }
  
  [managedObjectStore createManagedObjectContexts];
  
  [RKManagedObjectStore setDefaultStore:managedObjectStore];
  
  _objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://localhost:3000/"]]; // Point to your server address
  _objectManager.managedObjectStore = managedObjectStore;
  _objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
  
  // Object mappings
  RKEntityMapping * messageMapping = [RKEntityMapping mappingForEntityForName:@"Message" inManagedObjectStore:managedObjectStore];
  [messageMapping addAttributeMappingsFromDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"messageID", @"id", @"created_at", @"created_at", @"updated_at", @"updated_at", @"messageText", @"messageText", @"imageData", @"imageData", nil]];
  // Identifier used to update old objects when mapping occurs
  messageMapping.identificationAttributes = [NSArray arrayWithObject:@"messageID"];
  
  RKEntityMapping * userMapping = [RKEntityMapping mappingForEntityForName:@"User" inManagedObjectStore:managedObjectStore];
  [userMapping addAttributeMappingsFromDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"id", @"id", @"created_at", @"created_at", @"updated_at", @"updated_at", @"email", @"email", @"bio", @"bio", @"birth_date", @"birth_date", @"city", @"city", @"first_name", @"first_name", @"last_name", @"last_name", @"password", @"password", @"postal", @"postal", @"profile_picture", @"profile_picture", @"province", @"province", @"user_name", @"user_name", nil]];
  userMapping.identificationAttributes = [NSArray arrayWithObject:@"id"];
  
  // Map relationship between user and plants
  [userMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"messages" toKeyPath:@"messages" withMapping:messageMapping]];
  
  // Response descriptors tells RestKit what mapping to apply to the resource path used to send the request
  // The key path tells RestKit what part of the response to apply the mapping to
  [_objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:userMapping pathPattern:@"users" keyPath:@"users" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
}

@end