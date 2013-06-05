//  Plant.h

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Plant : NSManagedObject

@property (nonatomic, retain) NSString * common_name;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * have_want;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * latin_name;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * plant_photo;
@property (nonatomic, retain) NSString * plant_type;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) User *user;

@end