//
//  DrawingQuestionViewController.m
//  dementiahack
//
//  Created by Main on 2015-11-07.
//  Copyright © 2015 Main. All rights reserved.
//

#import "DrawingQuestionViewController.h"

@interface DrawingQuestionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *referenceImage;
@property (weak, nonatomic) IBOutlet UIImageView *drawImage;

@property (nonatomic) CGPoint lastPoint;
@property (nonatomic) CGPoint moveBackTo;
@property (nonatomic) CGPoint currentPoint;
@property (nonatomic) CGPoint location;
@property (strong, nonatomic) NSDate *lastClick;
@property (nonatomic) BOOL mouseSwiped;
@end

@implementation DrawingQuestionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:NO];
    // Do any additional setup after loading the view, typically from a nib.
}
//DRAW IMAGE SECTION///
- (void) touchesBegan:(NSSet *)touches withEvent: (UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    
    //Double Tap to Clear Screen
    if([touch tapCount]==2)
    {
        
        NSString* outFile = [NSHomeDirectory() stringByAppendingPathComponent:@"%@/drawImage.png"];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        NSData *imageData = UIImagePNGRepresentation(image);
        [imageData writeToFile:outFile atomically:NO];
        self.drawImage.image=nil;
    }
    
    
    self.location = [touch locationInView:touch.view];
    self.lastClick = [NSDate date];
    
    self.lastPoint = [touch locationInView:self.view];
    [super touchesBegan: touches withEvent: event];
    
}
- (void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event {
    self.mouseSwiped = YES;
    UITouch *touch=[touches anyObject];
    
    self.currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext((CGSizeMake(320, 568)));
    [self.drawImage.image drawInRect:CGRectMake(0,0,320,568)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(),5.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0,0,1);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.currentPoint.x, self.currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    [self.drawImage setFrame:CGRectMake(0,0, 320, 568)];
    self.drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.lastPoint = self.currentPoint;
    [self.view addSubview: self.drawImage];
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
