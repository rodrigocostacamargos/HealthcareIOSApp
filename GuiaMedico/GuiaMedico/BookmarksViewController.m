//
//  BookmarksViewController.m
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 11/7/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import "BookmarksViewController.h"
#import "DataAccessObject.h"
#import "Prestador.h"
#import "Especialidade.h"
#import "PrestadorViewController.h"
#import "AddressBook/AddressBook.h"
#import "AddressBookUI/AddressBookUI.h"


@implementation BookmarksViewController
@synthesize fetchedResultsController;

- (void) listRecords:(NSPredicate*) predicate {
    
    DataAccessObject *dao = [DataAccessObject sharedInstance];
    self.fetchedResultsController = [dao fetchedResultsControllerForEntity:@"Prestador" withPredicate:predicate keyName:@"Nome"];
    
    
    NSError *error;
    [self.fetchedResultsController performFetch:&error];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Custom TabBarItem
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Favoritos" image:[UIImage imageNamed:@"96-book.png"] tag:0];
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
    [self listRecords:[NSPredicate predicateWithFormat:@"Favorito = 1"]];
    [self.tableView reloadData];


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
    [super viewDidDisappear:animated];
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
    
    if ([sectionInfo numberOfObjects] > 0) {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", [sectionInfo numberOfObjects]];
    }
    else{
        self.tabBarItem.badgeValue = nil;
    }
    
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    return [self customizeCell:cell indexPath:indexPath];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        DataAccessObject *dao = [DataAccessObject sharedInstance];
        Prestador *prestador = [self.fetchedResultsController objectAtIndexPath:indexPath];
        prestador.Favorito = [[NSNumber alloc] initWithInt:0];
        [dao.managedObjectContext save:nil];
        [self listRecords:[NSPredicate predicateWithFormat:@"Favorito = 1"]];

        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Prestador *prestador = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //NSLog(@"prestador.nome: %@", prestador.Nome);
    
    // Call Address Book to insert new contact
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    ABRecordRef PersonAB = ABPersonCreate();
    ABRecordSetValue(PersonAB, kABPersonFirstNameProperty, prestador.Nome, NULL);
    //ABRecordSetValue(PersonAB, kABPersonAddressProperty, prestador.Endereco.Rua, NULL);
    //ABRecordSetValue(PersonAB, kABPersonPhoneProperty, prestador.Telefone, NULL);
    personViewController.displayedPerson = PersonAB;
    CFRelease(PersonAB);
    personViewController.allowsEditing = TRUE;
    personViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:personViewController animated:YES];
    //[self.navigationController pushViewController:personViewController animated:YES];
    //[personViewController release];

    
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
