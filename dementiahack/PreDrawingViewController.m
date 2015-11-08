//
//  PreDrawingViewController.m
//  dementiahack
//
//  Created by Main on 2015-11-08.
//  Copyright © 2015 Main. All rights reserved.
//

#import "PreDrawingViewController.h"

@interface PreDrawingViewController ()

@end

@implementation PreDrawingViewController
- (IBAction)beginDrawingTouched:(id)sender {
    [self performSegueWithIdentifier:@"LoadDrawing" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LoadDrawing"]) {
        QuestionViewController * destinationViewController = segue.destinationViewController;
        destinationViewController.question = self.question;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
