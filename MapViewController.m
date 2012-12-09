//
//  MapViewController.m
//  DCEZ
//
//  Created by Bill Columbia on 12/8/12.
//
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapScrollView, customMetroMap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)mapScrollView
{
    return self.customMetroMap;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MetroBackground.png"]];
    //mapScrollView.contentSize = CGSizeMake(1200, 1200);
    //zoom stuff
    self.mapScrollView.minimumZoomScale=0.5;
    self.mapScrollView.maximumZoomScale=2.0;
    self.mapScrollView.contentSize=CGSizeMake(800, 800);
    self.mapScrollView.delegate=self;
    //UIColor *background = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CustomMetroMap.png"]];
    //UIScrollView *mapScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 600)];
    //mapScrollView.backgroundColor = [UIColor blackColor];
    
    //mapScrollView = new UIScrollView (new RectangleF (0, 0, 320, 450));
    //mapScrollView.ContentSize = CGSizeEqualToSize(320, 640 + 508 + 1000);
    //scrollView.BackgroundColor = UIColor.FromPatternImage (UIImage.FromFile ("Images/About-bg0.jpg"));
    //mapScrollView.BackgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
