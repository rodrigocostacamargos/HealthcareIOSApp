//
//  GuiaMedicoAppDelegate.h
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface GuiaMedicoAppDelegate : NSObject <UIApplicationDelegate> {

    UINavigationController *navigationController;
    UITabBarController *tabBarController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
