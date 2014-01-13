//
//  ViewController.m
//  VideoRecordingApp
//
//  Created by Anthony Marchenko on 1/13/14.
//  Copyright (c) 2014 Anthony Marchenko. All rights reserved.
//

#import "ViewController.h"
@import MediaPlayer;
@import MobileCoreServices;

@interface ViewController ()  <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (copy,   nonatomic) NSURL *movieURL;
@property (strong, nonatomic) MPMoviePlayerController *movieController;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (IBAction)takeVideo:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

//this method is called after click "Use" button on video recording
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.movieURL = info[UIImagePickerControllerMediaURL];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

//this method is called when user click "Cancel" button
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)viewDidAppear:(BOOL)animated {
    
    self.movieController = [[MPMoviePlayerController alloc] init];
    
    [self.movieController setContentURL:self.movieURL];
    [self.movieController.view setFrame:self.imageView.frame];
    [self.view addSubview:self.movieController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.movieController];
    
    [self.movieController play];
    
}
- (IBAction)playButtonPressed {
    
    self.movieController = [[MPMoviePlayerController alloc] init];
    
    [self.movieController setContentURL:self.movieURL];
    [self.movieController.view setFrame:self.imageView.frame];
    [self.view addSubview:self.movieController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.movieController];
    
    [self.movieController play];
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [self.movieController stop];
    [self.movieController.view removeFromSuperview];
    self.movieController = nil;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
