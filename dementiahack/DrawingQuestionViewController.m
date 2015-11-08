//
//  DrawingQuestionViewController.m
//  dementiahack
//
//  Created by Main on 2015-11-07.
//  Copyright © 2015 Main. All rights reserved.
//

#import "DrawingQuestionViewController.h"
#import "DrawingQuestion.h"
#import "DrawingAnswer.h"
#import <MagicalRecord/MagicalRecord.h>
#import <AFHTTPRequestOperation.h>
#import <AFNetworking.h>

@interface DrawingQuestionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *referenceImage;
@property (weak, nonatomic) IBOutlet UIImageView *drawImage;

@property (nonatomic) CGPoint lastPoint;
@property (nonatomic) CGPoint currentPoint;
@property (nonatomic) BOOL createdDrawing;
@end

@implementation DrawingQuestionViewController

- (DrawingQuestion *)drawingQuestion {
    return (DrawingQuestion *)self.question;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:NO];
    
    if (self.drawingQuestion.drawingBinary) {
        self.referenceImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.referenceImage setImage:[UIImage imageWithData:self.drawingQuestion.drawingBinary]];
    }
}
//DRAW IMAGE SECTION///
- (void) touchesBegan:(NSSet *)touches withEvent: (UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    
    //Double Tap to Clear Screen
    if([touch tapCount]==2) {
        [self saveImage];
        self.drawImage.image=nil;
    }
    
    self.lastPoint = [touch locationInView:self.drawImage];
    [super touchesBegan: touches withEvent: event];
    
}

- (NSData *)imageData {
    return UIImagePNGRepresentation(self.drawImage.image);
}
-(NSURL *)saveImage {
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               @"drawImage.png",
                               nil];
    NSURL * url = [NSURL fileURLWithPathComponents:pathComponents];
    [self.imageData writeToURL:url atomically:NO];
    return url;
}

- (void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event {
    self.createdDrawing = YES;
    UITouch *touch=[touches anyObject];
    
    self.currentPoint = [touch locationInView:self.drawImage];
    
    CGSize frameSize = self.drawImage.frame.size;
    UIGraphicsBeginImageContext(CGSizeMake(frameSize.width, frameSize.height));
    [self.drawImage.image drawInRect:CGRectMake(0,0,frameSize.width,frameSize.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(),5.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0,0,1);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.currentPoint.x, self.currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    [self.drawImage setFrame:CGRectMake(0,0, frameSize.width, frameSize.height)];
    self.drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.lastPoint = self.currentPoint;
    [self.view addSubview: self.drawImage];
}
- (IBAction)saveAnswer:(id)sender {
    DrawingAnswer * answer = [DrawingAnswer MR_createEntity];
    answer.drawingBinary = self.imageData;

    NSString * token = @{ @2:  @"4af42c57c08b4210", @3: @"17623eb080054ba0" }[self.question.order];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"https://search.craftar.net/v1/search" parameters:@{ @"token": token } constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
//        NSURL *filePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"png"]];
//        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
        
        [formData appendPartWithFileData:answer.drawingBinary name:@"image" fileName:@"image.png" mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Success: %@", responseObject);
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSString *value = responseObject[@"results"][0][@"score"];
                int threashold = [@{ @2: @10, @3: @20 }[self.question.order] intValue];
                answer.correct = [NSNumber numberWithBool:[value intValue] > threashold];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

//    [self pushNextQuestion];
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
