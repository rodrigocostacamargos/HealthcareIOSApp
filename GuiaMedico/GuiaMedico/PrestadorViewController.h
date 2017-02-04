//
//  PrestadorViewController.h
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import "PrestadorDetailViewController.h"
#import "Especialidade.h"
#import "Bairro.h"

@interface PrestadorViewController : UITableViewController<UISearchDisplayDelegate, UISearchBarDelegate> {
    
    UIImageView *cellAnimationContainer;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) Especialidade *especialidade;
@property (nonatomic, retain) Bairro *bairro;

-(void) addCellToBookmark:(UITableViewCell*) cell indexPath:(NSIndexPath *)indexPath; 
@end
