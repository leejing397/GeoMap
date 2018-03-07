#import "MGLTViewController.h"
#import <GeoMap/Geocompass.h>

@implementation MGLTViewController
{
    GCLMapView *_mapView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapView = [[GCLMapView alloc] initWithFrame:self.view.bounds styleURL:[NSURL URLWithString:@"http://ipad.geo-compass.com/styles/tdt_vec_style.json"]];
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//  [_mapView setStyleURL:];
    [self.view addSubview:_mapView];
}

- (void)insetMapView
{
    _mapView.frame = CGRectInset(_mapView.frame, 50, 50);
}

- (void)tinyMapView
{
    _mapView.frame = CGRectMake(20, self.topLayoutGuide.length, self.view.frame.size.width / 2, self.view.frame.size.height / 2);
}

- (void)resetMapView
{
    _mapView.frame = self.view.bounds;
}

@end
