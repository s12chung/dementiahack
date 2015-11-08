//
//  QuestionViewController.m
//  dementiahack
//
//  Created by Main on 2015-11-07.
//  Copyright © 2015 Main. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"Question %@", self.question.order];
    [self.questionTextLabel setText:self.question.text];
    self.questionPlayer = [[AVAudioPlayer alloc] initWithData:[self.question audioBinary] fileTypeHint:@"mp3" error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)questionAudioButtonTouchUp:(id)sender {
    [self playQuestionAudio];
}

- (void)playQuestionAudio {
    [self.questionPlayer play];
    self.questionAudioPlaying = YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
