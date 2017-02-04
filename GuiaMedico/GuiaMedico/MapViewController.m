//
//  MapViewController.m
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import "MapViewController.h"
#import "LocationImageView.h"

@implementation MapViewController
@synthesize endereco, rua, encontre_me;

-(IBAction) changeType:(id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl*) sender;
    myMapView.mapType = segmentedControl.selectedSegmentIndex;
}

-(void) closeModal {

    //self.view.bounds = CGRectMake(0, 0, 320, 445);
    //self.view.autoresizesSubviews = TRUE;
    [self dismissModalViewControllerAnimated:YES];
}
  


-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    //MKPinAnnotationView *pinView = (MKPinAnnotationView*) view;
    //MKPlacemark *city = pinView.annotation;
    //NSDictionary *address = city.addressDictionary;
    
    LocationImageView *locationImageView = [[LocationImageView alloc] init];
    locationImageView.imageName = @"predio";
    locationImageView.delegate = self;
    locationImageView.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentModalViewController:locationImageView animated:YES];
    [locationImageView release];
    
}

-(MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString *AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView *pinView = (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    
    if (!pinView && (!self.encontre_me)) {
        
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        
        // add a detail disclosure button to the callout which will open a new view controller page
        UIButton *rigthButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.rightCalloutAccessoryView = rigthButton;
    }
    
    return pinView;
}



- (void)addAnnotations {
    
    if (endereco) {
        
        NSDictionary *address;
        MKPlacemark *city;
        
        CLLocationCoordinate2D	coordinate = {
            [endereco.Latitude doubleValue],[endereco.Longitude doubleValue]
        };
        
        address = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@ - %d", endereco.Rua, [endereco.Numero intValue]], @"Street", endereco.Bairro.Cidade.Nome, @"City", @"Brazil", @"Country", nil];
        city = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:address];
        
        [myMapView addAnnotation:city];
        [myMapView setCenterCoordinate:coordinate animated:YES];
        [city release];
        
        self.encontre_me = FALSE;

    }
    
    
}


- (void)updateUserLocation
{
    MKUserLocation	*userLocation = myMapView.userLocation;
    CLLocationCoordinate2D	coordinate = userLocation.location.coordinate;
    
    [myMapView setCenterCoordinate:coordinate animated:YES];
    
    if (!reverseGeocoder)
    {
        reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:coordinate];
        reverseGeocoder.delegate = self;
        [reverseGeocoder start];
    }
}

- (IBAction)findMe:(id)sender
{
    
    self.encontre_me = TRUE;
    myMapView.showsUserLocation = TRUE;
    
    if (myMapView.showsUserLocation)
        [self updateUserLocation];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    myMapView.userLocation.title = placemark.title;
}


-(void) viewWillAppear:(BOOL)animated {
    
    [self addAnnotations];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Custom TabBarItem
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:[UIImage imageNamed:@"globe.png"] tag:0];
        self.tabBarItem = tabBarItem;

    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{

    [super viewDidLoad];
    self.encontre_me = FALSE;
    // Do any additional setup after loading the view from its nib.

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
