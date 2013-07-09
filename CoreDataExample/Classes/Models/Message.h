//
//  Message.h
//  CoreDataExample
//
//  Created by Daniel MacKenzie on 2013-07-09.
//  Copyright (c) 2013 Daniel MacKenzie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSNumber * messageID;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSString * messageText;
@property (nonatomic, retain) NSString * imageData;
@property (nonatomic, retain) User *user;

@end
