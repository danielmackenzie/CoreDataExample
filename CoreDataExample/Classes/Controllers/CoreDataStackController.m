//  CoreDataStackViewController.m

#import "CoreDataStackController.h"

@implementation CoreDataStackController

@synthesize managedObjectContext = _managedObjectContext;

#pragma mark - Core Data Stack Getters

- (NSManagedObjectContext *)managedObjectContext; {
  return [RKObjectManager sharedManager].managedObjectStore.mainQueueManagedObjectContext;
}

#pragma mark - Methods

- (void)saveContext; {
  NSError * error = nil;
  NSManagedObjectContext * managedObjectContext = self.managedObjectContext;
  
  if(managedObjectContext != nil){
    if([managedObjectContext hasChanges] && ![managedObjectContext save:&error]){
      NSLog(@"ERROR: Could not save changes to Core Data!");
    }
  }
}

- (NSArray *)fetchLocalObjectsOfClass:(NSString *)aClass searchPredicate:(NSPredicate *)aPredicate; {
  NSEntityDescription * entityDescription = [NSEntityDescription entityForName:aClass inManagedObjectContext:self.managedObjectContext];
  NSFetchRequest * request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDescription];
  
  NSPredicate * predicate = aPredicate;
  [request setPredicate:predicate];
  
  NSError * error;
  NSArray * array = [self.managedObjectContext executeFetchRequest:request error:&error];
  
  if(error){
    NSLog(@"Error occured when fetching objects from CoreData: %@", error);
  }
  return array;
}

#pragma mark - Application's Documents Directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory; {
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end