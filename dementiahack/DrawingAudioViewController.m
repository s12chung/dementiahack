//
//  DrawingAudioViewController.m
//  dementiahack
//
//  Created by Main on 2015-11-08.
//  Copyright © 2015 Main. All rights reserved.
//

#import "DrawingAudioViewController.h"
#import "DrawingAudioQuestion.h"

@interface DrawingAudioViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *referenceImage;
@end

@implementation DrawingAudioViewController

- (DrawingAudioQuestion *)drawingAudioQuestion {
    return (DrawingAudioQuestion *)self.question;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.referenceImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.referenceImage setImage:[UIImage imageWithData:self.drawingAudioQuestion.drawingBinary]];
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
