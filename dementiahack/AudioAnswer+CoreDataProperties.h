//
//  AudioAnswer+CoreDataProperties.h
//  dementiahack
//
//  Created by Main on 2015-11-08.
//  Copyright © 2015 Main. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AudioAnswer.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioAnswer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *audioBinary;

@end

NS_ASSUME_NONNULL_END
