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
  [_objectManager getObjectsAtPath:@"users"
                        parameters:nil
                           success:^(RKObjectRequestOperation * operation, RKMappingResult * mappingResult) {
                             NSEntityDescription * entityDescription = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
                             NSFetchRequest * request = [[NSFetchRequest alloc] init];
                             [request setEntity:entityDescription];
                             
                             NSArray * array = [self.managedObjectContext executeFetchRequest:request error:nil];
                             
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
  NSError * error;
  NSURL * modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CoreData" ofType:@"momd"]];
  NSManagedObjectModel * managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
  RKManagedObjectStore * managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
  
  [managedObjectStore createPersistentStoreCoordinator];
  
  NSArray * searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString * documentPath = [searchPaths objectAtIndex:0];
  NSPersistentStore * persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:[NSString stringWithFormat:@"%@/CoreData.sqlite", documentPath] fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
  
  if(!persistentStore){
    NSLog(@"Failed to add persistent store: %@", error);
  }
  
  [managedObjectStore createManagedObjectContexts];
  
  [RKManagedObjectStore setDefaultStore:managedObjectStore];
  
  _objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://localhost:3000/"]];
  _objectManager.managedObjectStore = managedObjectStore;
  _objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
  
  RKEntityMapping * plantMapping = [RKEntityMapping mappingForEntityForName:@"Plant" inManagedObjectStore:managedObjectStore];
  [plantMapping addAttributeMappingsFromDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"id", @"id", @"created_at", @"created_at", @"updated_at", @"updated_at", @"common_name", @"common_name", @"have_want", @"have_want", @"latin_name", @"latin_name", @"note", @"note", @"plant_photo", @"plant_photo", @"plant_type", @"plant_type", @"user", @"user", nil]];
  plantMapping.identificationAttributes = [NSArray arrayWithObject:@"id"];
  
  RKEntityMapping * userMapping = [RKEntityMapping mappingForEntityForName:@"User" inManagedObjectStore:managedObjectStore];
  [userMapping addAttributeMappingsFromDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"id", @"id", @"created_at", @"created_at", @"updated_at", @"updated_at", @"email", @"email", @"bio", @"bio", @"birth_date", @"birth_date", @"city", @"city", @"first_name", @"first_name", @"last_name", @"last_name", @"password", @"password", @"postal", @"postal", @"profile_picture", @"profile_picture", @"province", @"province", @"type_of_garden", @"type_of_garden", @"user_name", @"user_name", nil]];
  userMapping.identificationAttributes = [NSArray arrayWithObject:@"id"];
  
  [userMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"plants" toKeyPath:@"plants" withMapping:plantMapping]];
  
  [_objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:userMapping pathPattern:@"users" keyPath:@"users" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
}

@end