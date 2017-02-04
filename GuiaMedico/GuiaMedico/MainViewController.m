//
//  MainViewController.m
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import "MainViewController.h"
#import "EspecialidadeViewController.h"
#import "PrestadorViewController.h"
#import "CidadeViewController.h"


@implementation MainViewController

-(IBAction) showCidade {
    
    CidadeViewController *cidadeViewController = [[CidadeViewController alloc] init];
    cidadeViewController.title = @"Cidades";
    [self.navigationController pushViewController:cidadeViewController animated:YES];
    [cidadeViewController release];
}

-(IBAction) showEspecialidade{
    EspecialidadeViewController *especialidadeViewController = [[EspecialidadeViewController alloc] init];
    especialidadeViewController.title = @"Especialidades";
    [self.navigationController pushViewController:especialidadeViewController animated:YES];
    [especialidadeViewController release];
}

-(IBAction) showPrestador {

    PrestadorViewController *prestadorViewController = [[PrestadorViewController alloc] initWithNibName:@"PrestadorViewController" bundle:nil]; //mandatory init with nibname when using search bar
    prestadorViewController.title = @"Prestadores";
    [self.navigationController pushViewController:prestadorViewController animated:YES];
    [prestadorViewController release];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Custom TabBarItem
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Guia" image:[UIImage imageNamed:@"33-cabinet"] tag:0];
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
    
    
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"Voltar";
    self.navigationItem.backBarButtonItem = backButton;

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
