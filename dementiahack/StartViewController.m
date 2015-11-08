//
//  StartViewController.m
//  dementiahack
//
//  Created by Main on 2015-11-07.
//  Copyright © 2015 Main. All rights reserved.
//

#import "StartViewController.h"
#import "AudioQuestion.h"
#import <MagicalRecord/MagicalRecordShorthandMethodAliases.h>

#import "AudioQuestionViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startNewInterviewButtonTouched:(id)sender {
    UINavigationController * navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationView"];
    navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navigationController animated:YES completion:nil];
    
    Question * question = [Question findFirstByAttribute:@"order" withValue: FIRST_QUESTION_ORDER];
    QuestionViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:question.storyboardId];
    viewController.question = question;
    [navigationController pushViewController:viewController animated:YES];
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
