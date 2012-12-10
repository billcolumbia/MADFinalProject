//
//  MapViewController.m
//  DCEZ
//
//  Created by Bill Columbia on 12/8/12.
//
//

#import "MapViewController.h"

@interface MapViewController ()

@property (nonatomic, strong) UIView *containerView;

- (void)centerScrollViewContents;

@end

@implementation MapViewController

@synthesize mapScrollView = _scrollView;
@synthesize containerView = _containerView;


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
    [super viewWillAppear:animated];
    
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.mapScrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.mapScrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.mapScrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.mapScrollView.minimumZoomScale = minScale;
    self.mapScrollView.maximumZoomScale = 1.0f;
    self.mapScrollView.zoomScale = 1.0f;
    
    [self centerScrollViewContents];
}
- (void)centerScrollViewContents {
    CGSize boundsSize = self.mapScrollView.bounds.size;
    CGRect contentsFrame = self.containerView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.containerView.frame = contentsFrame;
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the container view to hold your custom view hierarchy
    CGSize containerSize = CGSizeMake(640.0f, 640.0f);
    self.containerView = [[UIView alloc] initWithFrame:(CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=containerSize}];
    [self.mapScrollView addSubview:self.containerView];
    
    // Set up your custom view hierarchy
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 640.0f, 80.0f)];
    redView.backgroundColor = [UIColor redColor];
    [self.containerView addSubview:redView];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 560.0f, 640.0f, 80.0f)];
    blueView.backgroundColor = [UIColor blueColor];
    [self.containerView addSubview:blueView];
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(160.0f, 160.0f, 320.0f, 320.0f)];
    greenView.backgroundColor = [UIColor greenColor];
    [self.containerView addSubview:greenView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CustomMetroMap.png"]];
    imageView.center = CGPointMake(320.0f, 320.0f);
    [self.containerView addSubview:imageView];
    
    // Tell the scroll view the size of the contents
    self.mapScrollView.contentSize = containerSize;
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MetroBackground.png"]];
    //mapScrollView.contentSize = CGSizeMake(1200, 1200);
    //zoom stuff
    //self.mapScrollView.minimumZoomScale=0.5;
    //self.mapScrollView.maximumZoomScale=2.0;
    //self.mapScrollView.contentSize=CGSizeMake(800, 800);
    //self.mapScrollView.delegate=self;
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
