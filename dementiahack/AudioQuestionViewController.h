//
//  AudioQuestionViewController.h
//  dementiahack
//
//  Created by Main on 2015-11-07.
//  Copyright © 2015 Main. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface AudioQuestionViewController : QuestionViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
@end
