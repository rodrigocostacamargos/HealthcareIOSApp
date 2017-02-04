//
//  MapViewController.h
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Endereco.h"
#import "Bairro.h"
#import "Cidade.h"

@protocol MapViewControllerDelegate <NSObject>

-(void) closeModal;

@end

@interface MapViewController : UIViewController<MKMapViewDelegate, MKReverseGeocoderDelegate, MapViewControllerDelegate> {
    
    IBOutlet MKMapView *myMapView;
    MKReverseGeocoder	*reverseGeocoder;
}

@property (nonatomic, retain) Endereco *endereco;
@property (nonatomic, retain) NSString *rua;
@property (nonatomic,) BOOL encontre_me;

-(IBAction) changeType:(id) sender;
- (IBAction)findMe:(id)sender;
-(void) closeModal;
@end
