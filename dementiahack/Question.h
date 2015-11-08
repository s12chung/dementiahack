//
//  Question.h
//  dementiahack
//
//  Created by Main on 2015-11-07.
//  Copyright © 2015 Main. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define FIRST_QUESTION_ORDER @6

NS_ASSUME_NONNULL_BEGIN

@interface Question : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (NSString *)storyboardId;

@end

NS_ASSUME_NONNULL_END

#import "Question+CoreDataProperties.h"
