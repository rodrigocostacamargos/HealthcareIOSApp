//
//  BairroViewController.h
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/21/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Cidade.h"
#import "EspecialidadeViewController.h"

@interface BairroViewController : UITableViewController {
    
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic,retain) Cidade *cidade;
@end
