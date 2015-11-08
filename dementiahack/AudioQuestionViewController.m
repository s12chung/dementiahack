//
//  AudioQuestionViewController.m
//  dementiahack
//
//  Created by Main on 2015-11-07.
//  Copyright © 2015 Main. All rights reserved.
//

#import "AudioQuestionViewController.h"
#import "AudioQuestion.h"
#import "AudioAnswer.h"
#import <MagicalRecord/MagicalRecord.h>
#import <AFHTTPRequestOperation.h>

@interface AudioQuestionViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveAnswerButton;
@property (weak, nonatomic) IBOutlet UIButton *audioRecordingButton;
@property (weak, nonatomic) IBOutlet UIButton *recordingPlayButton;

@property (nonatomic) BOOL audioRecorded;

@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) AVAudioPlayer *player;
@end

@implementation AudioQuestionViewController

- (AudioQuestion *)audioQuestion {
    return (AudioQuestion *)self.question;
}

- (void)viewDidLoad {
    [self.recordingPlayButton setEnabled:NO];
    [self.saveAnswerButton setEnabled:NO];
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    gesture.minimumPressDuration = 0.1;
    gesture.allowableMovement = 600;
    [self.audioRecordingButton addGestureRecognizer:gesture];
    
    
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"MyAudioMemo.wav",
                               nil];
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPathComponents:pathComponents] settings:recordSetting error:nil];
    self.recorder.delegate = self;
    self.recorder.meteringEnabled = YES;
    [self.recorder prepareToRecord];
    
    [super viewDidLoad];
}

- (void)handleGesture:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [self.recorder record];
        [self.audioRecordingButton setTitle:@"Recording" forState:UIControlStateNormal];
    }
    else if (gesture.state == UIGestureRecognizerStateCancelled ||
             gesture.state == UIGestureRecognizerStateFailed ||
             gesture.state == UIGestureRecognizerStateEnded)
    {
        [self.recorder stop];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
        
        [self.recordingPlayButton setEnabled:YES];
        [self.saveAnswerButton setEnabled:YES];
        [self.audioRecordingButton setTitle:@"Hold to Record" forState:UIControlStateNormal];
    }
}
- (IBAction)playRecording:(id)sender {
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recorder.url error:nil];
    [self.player setDelegate:self];
    [self.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAnswerButton:(id)sender {
    AudioAnswer * answer = [AudioAnswer MR_createEntity];
    answer.audioBinary = [NSData dataWithContentsOfURL:self.recorder.url];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://api.wit.ai/speech?v=20141022"]];
    [request setHTTPMethod:@"POST"];
    
    //set headers
    [request addValue:@"audio/wav" forHTTPHeaderField: @"Content-Type"];
    [request addValue:@"Bearer DBAVAREA426NVTIDZBY47X2SJJK7QIO2" forHTTPHeaderField: @"Authorization"];
    
    //body - just file
    [request setHTTPBody:[NSData dataWithContentsOfURL:self.recorder.url]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL correct;
        NSString * text = responseObject[@"_text"];
        if ([self.question.order intValue] == 6) {
            correct = [text containsString:@"rhino"];
        }
        else {
            correct = [@"247" caseInsensitiveCompare:text] == NSOrderedSame;
        }
        answer.correct = [NSNumber numberWithBool:correct];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
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
