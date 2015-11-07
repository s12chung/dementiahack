//
//  AudioQuestionViewController.m
//  dementiahack
//
//  Created by Main on 2015-11-07.
//  Copyright © 2015 Main. All rights reserved.
//

#import "AudioQuestionViewController.h"

@interface AudioQuestionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionTextLabel;

@property (weak, nonatomic) IBOutlet UIButton *questionAudioButton;
@property (nonatomic) BOOL questionAudioPlaying;


@property (weak, nonatomic) IBOutlet UIButton *audioRecordingButton;
@property (nonatomic) BOOL audioRecording;
@end

@implementation AudioQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pauseQuestionAudio];
    [self stopAudioRecording];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)questionAudioButtonTouchUp:(id)sender {
    [self playQuestionAudio];
}

- (void)pauseQuestionAudio {
    [self.questionAudioButton setTitle:@"Play" forState:UIControlStateNormal];
    [self setQuestionAudioPlaying:YES];
}

- (void)playQuestionAudio {
    [self.questionAudioButton setTitle:@"Pause" forState:UIControlStateNormal];
    [self setQuestionAudioPlaying:NO];
}

- (void)stopAudioRecording {
    [self.audioRecordingButton setTitle:@"Record" forState:UIControlStateNormal];
    [self setAudioRecording:NO];
}

- (void)recordAudioRecording {
    [self.audioRecordingButton setTitle:@"Stop" forState:UIControlStateNormal];
    [self setAudioRecording:YES];
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
