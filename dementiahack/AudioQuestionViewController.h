//
//  AudioQuestionViewController.h
//  dementiahack
//
//  Created by Main on 2015-11-07.
//  Copyright © 2015 Main. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioQuestion.h"
#import <AVFoundation/AVFoundation.h>


@interface AudioQuestionViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
    @property (strong, nonatomic) AudioQuestion * audioQuestion;
@end
