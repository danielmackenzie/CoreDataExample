//  User.h

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSDate * birth_date;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * postal;
@property (nonatomic, retain) NSString * profile_picture;
@property (nonatomic, retain) NSString * province;
@property (nonatomic, retain) NSString * type_of_garden;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSString * user_name;
@property (nonatomic, retain) NSSet *plants;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPlantsObject:(NSManagedObject *)value;
- (void)removePlantsObject:(NSManagedObject *)value;
- (void)addPlants:(NSSet *)values;
- (void)removePlants:(NSSet *)values;

@end