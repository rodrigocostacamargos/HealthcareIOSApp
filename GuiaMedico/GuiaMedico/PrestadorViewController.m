//
//  PrestadorViewController.m
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import "PrestadorViewController.h"
#import "DataAccessObject.h"
#import "Prestador.h"
#import "BookmarksViewController.h"
#import "GuiaMedicoAppDelegate.h"


@implementation PrestadorViewController

@synthesize fetchedResultsController, especialidade, bairro;

- (void) listRecords:(NSPredicate*) predicate {
    
    DataAccessObject *dao = [DataAccessObject sharedInstance];
    self.fetchedResultsController = [dao fetchedResultsControllerForEntity:@"Prestador" withPredicate:predicate keyName:@"Nome"];
    
    
    NSError *error;
    [self.fetchedResultsController performFetch:&error];
    [self.tableView reloadData];
}

-(NSUInteger) countBookmarks {

    DataAccessObject *dao = [DataAccessObject sharedInstance];
    NSArray *arrayFavoritos = [dao fetchManagedObjectsForEntity:@"Prestador" withPredicate:[NSPredicate predicateWithFormat:@"Favorito = 1"]];

    return [arrayFavoritos count];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

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
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"Voltar";
    self.navigationItem.backBarButtonItem = backButton;

    
    if (especialidade && bairro) {
        
        [self listRecords:[NSPredicate predicateWithFormat:@"ANY Especialidades.Nome like %@ and Endereco.Bairro.Nome like %@", self.especialidade.Nome, bairro.Nome]];
    }
    else{
        
        if (especialidade) {
            [self listRecords:[NSPredicate predicateWithFormat:@"ANY Especialidades.Nome like %@", self.especialidade.Nome]];
            
        }
        else {
            [self listRecords:nil];
        }
        
    }
    
    
    [self.tableView reloadData];
    self.tableView.scrollEnabled = YES;

    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.fetchedResultsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}
     
- (UITableViewCell *) customizeCell:(UITableViewCell *) cell indexPath:(NSIndexPath *)indexPath {
         
    Prestador *prestador = [fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = prestador.Nome;
    
    NSEnumerator *enumerator = [prestador.Especialidades objectEnumerator];
    Especialidade *especialidadeObj;
    NSString *especialidadeNome = [[NSString alloc] init];
    int i=0;
    
    while ( ( especialidadeObj = [enumerator nextObject]) )
    {
        
        if (i>0) {
            especialidadeNome = [especialidadeNome stringByAppendingString:@" e "];
            cell.detailTextLabel.text = especialidadeNome;
        }
        
        if (especialidadeObj) {
            
            especialidadeNome = [especialidadeNome stringByAppendingString:especialidadeObj.Nome];
            cell.detailTextLabel.text = especialidadeNome;
        }
        
        i++;
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"omintmedico" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    cell.imageView.image = image;

         
    return cell;
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {

    if ([self.fetchedResultsController.fetchedObjects count] > 0) {
        
        Prestador *prestador = [self.fetchedResultsController objectAtIndexPath:indexPath];
        PrestadorDetailViewController *prestadorViewController = [[PrestadorDetailViewController alloc] init];
        prestadorViewController.prestador = prestador;
        prestadorViewController.title = @"Prestador";
        [self.navigationController pushViewController:prestadorViewController animated:YES];
        [prestadorViewController release];
        
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    return [self customizeCell:cell indexPath:indexPath];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

-(void) updateBadgeValue:(NSUInteger) count {

    BookmarksViewController *bookmarksViewController = [self.tabBarController.viewControllers objectAtIndex:1];
    if (count > 0) {
        bookmarksViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", count];
    }
    else{
        bookmarksViewController.tabBarItem.badgeValue = nil;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    if ([self.fetchedResultsController.fetchedObjects count] > 0) {

        
        DataAccessObject *dao = [DataAccessObject sharedInstance];
        Prestador *prestador = [self.fetchedResultsController objectAtIndexPath:indexPath];
        prestador.Favorito = [[NSNumber alloc] initWithInt:1];
        [dao.managedObjectContext save:nil];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self addCellToBookmark:[tableView cellForRowAtIndexPath:indexPath] indexPath:indexPath];
        

    }
}

-(void) addCellToBookmark:(UITableViewCell*) cell indexPath:(NSIndexPath *)indexPath {
    
    UIGraphicsBeginImageContextWithOptions(cell.bounds.size, cell.opaque, [[UIScreen mainScreen] scale]);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:indexPath];
    CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];

    cellAnimationContainer = [[UIImageView alloc] initWithFrame:rectInSuperview];
    [cellAnimationContainer setFrame:CGRectMake(cellAnimationContainer.frame.origin.x, cellAnimationContainer.frame.origin.y+50 , cellAnimationContainer.frame.size.width, cellAnimationContainer.frame.size.height)];
    [cellAnimationContainer setImage:img];

    GuiaMedicoAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:cellAnimationContainer];
    
    [UIView beginAnimations:@"addBookmark-Step1" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.2];
    [cellAnimationContainer setFrame:CGRectMake(20,cellAnimationContainer.frame.origin.y-10, cellAnimationContainer.frame.size.width, cellAnimationContainer.frame.size.height)];
    [cellAnimationContainer setAlpha:0.7];
    [UIView commitAnimations];

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if([anim isEqual:@"addBookmark-Step1"])
    {

        [UIView beginAnimations:@"addBookmark-Step2" context:nil]; 
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelegate:self]; 
        [cellAnimationContainer setAlpha:0.4];
        [cellAnimationContainer setFrame:CGRectMake(150, 420, 20, 20)];
        [UIView commitAnimations];

    }
    else if([anim isEqual:@"addBookmark-Step2"])
    {
        [self updateBadgeValue:0];

        [cellAnimationContainer removeFromSuperview];
        [cellAnimationContainer release];  
        
        [self updateBadgeValue:self.countBookmarks];
    }

    
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
 
    if ([searchString length] > 0) {
        [self listRecords:[NSPredicate predicateWithFormat:@"Nome contains[cd] %@", searchString]];
    }
    else{
        [self listRecords:nil];
    }
    return YES;
}



@end
