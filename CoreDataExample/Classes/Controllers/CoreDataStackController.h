//  CoreDataStackController.h

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface CoreDataStackController : NSObject {
  NSManagedObjectContext       * _managedObjectContext;
}

@property (readonly, strong, nonatomic) NSManagedObjectContext       * managedObjectContext;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSArray *)fetchLocalObjectsOfClass:(NSString *)aClass searchPredicate:(NSPredicate *)aPredicate;

@end