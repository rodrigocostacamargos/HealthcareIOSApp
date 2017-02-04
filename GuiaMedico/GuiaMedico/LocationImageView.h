//
//  LocationImageView.h
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/28/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@protocol MapViewControllerDelegate;

@interface LocationImageView : UIViewController {
    
    IBOutlet UIImageView *imageView;
    id<MapViewControllerDelegate> delegate;
}

@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, retain) id<MapViewControllerDelegate> delegate;

@end
