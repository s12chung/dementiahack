//
//  AudioQuestionViewController.m
//  dementiahack
//
//  Created by Main on 2015-11-07.
//  Copyright © 2015 Main. All rights reserved.
//

#import "AudioQuestionViewController.h"
#import "AudioQuestion.h"

@interface AudioQuestionViewController ()
@property (weak, nonatomic) IBOutlet UIButton *questionAudioButton;
@property (nonatomic) BOOL questionAudioPlaying;
@property (strong, nonatomic)AVAudioPlayer *questionPlayer;

@property (weak, nonatomic) IBOutlet UIButton *audioRecordingButton;
@property (nonatomic) BOOL audioRecording;
@end

@implementation AudioQuestionViewController

- (AudioQuestion *)audioQuestion {
    return (AudioQuestion *)self.question;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self stopAudioRecording];
    
    self.questionPlayer = [[AVAudioPlayer alloc] initWithData:[self.audioQuestion audioBinary] fileTypeHint:@"mp3" error:nil];
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

- (void)stopAudioRecording {
    [self.audioRecordingButton setTitle:@"Record" forState:UIControlStateNormal];
    self.audioRecording = NO;
}

- (void)recordAudioRecording {
    [self.audioRecordingButton setTitle:@"Stop" forState:UIControlStateNormal];
    self.audioRecording = YES;
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
