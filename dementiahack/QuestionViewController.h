//
//  QuestionViewController.h
//  dementiahack
//
//  Created by Main on 2015-11-07.
//  Copyright © 2015 Main. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionViewController : UIViewController
    @property (strong, nonatomic) Question * question;
    @property (weak, nonatomic) IBOutlet UILabel *questionTextLabel;
@end
