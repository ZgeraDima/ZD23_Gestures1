//
//  ViewController.m
//  DZ 23 - Obj_Skut_Gestures1
//
//  Created by mac on 19.11.17.
//  Copyright © 2017 Dima Zgera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property(weak, nonatomic) UIView* humanPicture;
@property (strong, nonatomic) NSMutableArray* keys;
@property (assign, nonatomic) CGFloat humanPictureScale;
@property (assign, nonatomic) CGFloat humanPictureRotation;
@property (assign, nonatomic) CGFloat animationPictureDuration;
@property (assign, nonatomic) CGFloat movePictureDuration;
@property (assign, nonatomic) CGFloat rotatePictureDuration;
@property (assign, nonatomic) CGFloat handlePinchDuration;
@property (assign, nonatomic) CGFloat handleRotateDuration;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.animationPictureDuration = 1.2;
    self.movePictureDuration = 5.0;
    self.rotatePictureDuration = 2.0;
    self.handlePinchDuration = 0.3;
    self.handleRotateDuration = 0.3;

    // Level pupil
    
    UIImage* image1 = [UIImage imageNamed:@"1.png"];
    UIImage* image2 = [UIImage imageNamed:@"2.png"];
    UIImage* image3 = [UIImage imageNamed:@"3.png"];
    UIImage* image4 = [UIImage imageNamed:@"4.png"];
    UIImage* image5 = [UIImage imageNamed:@"5.png"];
    UIImage* image6 = [UIImage imageNamed:@"6.png"];
    UIImage* image7 = [UIImage imageNamed:@"7.png"];
    UIImage* image8 = [UIImage imageNamed:@"8.png"];
    UIImage* image9 = [UIImage imageNamed:@"9.png"];
    UIImage* image10 = [UIImage imageNamed:@"10.png"];
    UIImage* image11 = [UIImage imageNamed:@"11.png"];
    UIImage* image12 = [UIImage imageNamed:@"12.png"];
    UIImage* image13 = [UIImage imageNamed:@"13.png"];
    UIImage* image14 = [UIImage imageNamed:@"14.png"];
    UIImage* image15 = [UIImage imageNamed:@"15.png"];
    UIImage* image16 = [UIImage imageNamed:@"16.png"];
    
    NSArray* images = [NSArray arrayWithObjects:image1, image2, image3, image4, image5, image6, image7, image8, image9, image10, image11, image12, image13, image14, image15, image16, nil];
    
    UIView* view = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - 45, CGRectGetMidY(self.view.bounds) - 90, 90, 140)];
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 140)];
    imgView.animationImages = images;
    imgView.animationDuration = self.animationPictureDuration;
    [imgView startAnimating];
    imgView.autoresizingMask =  UIViewAutoresizingFlexibleTopMargin |
                                UIViewAutoresizingFlexibleBottomMargin |
                                UIViewAutoresizingFlexibleLeftMargin |
                                UIViewAutoresizingFlexibleRightMargin;
    self.humanPicture = view;
    [view addSubview:imgView];
    [self.view addSubview:view];

    // Level student
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    // Level master
    
    self.keys = [NSMutableArray array];
    
    UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipe:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipe:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
    
    UITapGestureRecognizer* doubleTapTouchGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(doubleHandleTapTouch:)];
    doubleTapTouchGesture.numberOfTapsRequired = 2;
    doubleTapTouchGesture.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTapTouchGesture];
    
    [tapGesture requireGestureRecognizerToFail:doubleTapTouchGesture];
    
    // Level superman
    
    UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinchGesture];
    pinchGesture.delegate = self;
    
    UIRotationGestureRecognizer* rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    [self.view addGestureRecognizer:rotateGesture];
    rotateGesture.delegate = self;
    
    
}

# pragma mark - Gestures

// Level student

- (void) handleTap:(UITapGestureRecognizer*) tapGesture {
    
    [UIView animateWithDuration: self.movePictureDuration
                          delay: 0
                        options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.humanPicture.center = [tapGesture locationInView:self.view];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

// Level master

- (void) handleLeftSwipe:(UISwipeGestureRecognizer*) swipeGesture {
    
    for (NSString* key in self.keys) {
        [self.humanPicture.layer removeAnimationForKey:key];
    }
    
    NSMutableArray* keysBefore = [[NSMutableArray alloc] initWithArray: self.humanPicture.layer.animationKeys];
    
    [UIView animateWithDuration: self.rotatePictureDuration
                          delay: 0
                        options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.humanPicture.transform = CGAffineTransformRotate(self.humanPicture.transform, M_PI_2);
                         self.humanPicture.transform = CGAffineTransformRotate(self.humanPicture.transform, M_PI_2);
                         self.humanPicture.transform = CGAffineTransformRotate(self.humanPicture.transform, M_PI_2);
                         self.humanPicture.transform = CGAffineTransformRotate(self.humanPicture.transform, M_PI_2);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
    
    self.keys = [[NSMutableArray alloc] initWithArray: self.humanPicture.layer.animationKeys];
    [self.keys removeObjectsInArray:keysBefore];
    
}

- (void) handleRightSwipe:(UISwipeGestureRecognizer*) swipeGesture {
    
    for (NSString* key in self.keys) {
        [self.humanPicture.layer removeAnimationForKey:key];
    }
    
    NSMutableArray* keysBefore = [[NSMutableArray alloc] initWithArray: self.humanPicture.layer.animationKeys];
    
    [UIView animateWithDuration: self.rotatePictureDuration
                          delay: 0
                        options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.humanPicture.transform = CGAffineTransformRotate(self.humanPicture.transform, -1 * M_PI_2);
                         self.humanPicture.transform = CGAffineTransformRotate(self.humanPicture.transform, -1 * M_PI_2);
                         self.humanPicture.transform = CGAffineTransformRotate(self.humanPicture.transform, -1 * M_PI_2);
                         self.humanPicture.transform = CGAffineTransformRotate(self.humanPicture.transform, -1 * M_PI_2);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
    self.keys = [[NSMutableArray alloc] initWithArray: self.humanPicture.layer.animationKeys];
    [self.keys removeObjectsInArray:keysBefore];
}

- (void) doubleHandleTapTouch:(UITapGestureRecognizer*) tapGesture {
    [self.humanPicture.layer removeAllAnimations];
}

// Level superman

- (void) handlePinch:(UIPinchGestureRecognizer*) pinchGesture {
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.humanPictureScale = 1.0;
    }
    
    CGFloat newScale = 1.0 + pinchGesture.scale - self.humanPictureScale;
    
    [UIView animateWithDuration:self.handlePinchDuration
                     animations:^{
                         self.humanPicture.transform = CGAffineTransformScale(self.humanPicture.transform, newScale, newScale);;
                     }];
    
    self.humanPictureScale = pinchGesture.scale;
}


- (void) handleRotate:(UIRotationGestureRecognizer*) rotationGesture {
    
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.humanPictureRotation = 0.0;
    }
    
    CGFloat newRotation = rotationGesture.rotation - self.humanPictureRotation;
    
    [UIView animateWithDuration:self.handleRotateDuration
                     animations:^{
                         self.humanPicture.transform = CGAffineTransformRotate(self.humanPicture.transform, newRotation);
                     }];
    
    self.humanPictureRotation = rotationGesture.rotation;
    
}

# pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
