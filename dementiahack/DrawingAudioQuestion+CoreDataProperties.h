//
//  DrawingAudioQuestion+CoreDataProperties.h
//  dementiahack
//
//  Created by Main on 2015-11-08.
//  Copyright © 2015 Main. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DrawingAudioQuestion.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrawingAudioQuestion (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *drawingBinary;

@end

NS_ASSUME_NONNULL_END
