//
//  User.h
//  CoreDataExample
//
//  Created by Daniel MacKenzie on 2013-07-09.
//  Copyright (c) 2013 Daniel MacKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message;

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
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSString * user_name;
@property (nonatomic, retain) NSSet *messages;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

@end
