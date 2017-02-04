//
//  PrestadorDetailViewController.m
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/21/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import "PrestadorDetailViewController.h"
#import "MapViewController.h"
#import "ImageViewController.h"



@implementation PrestadorDetailViewController

@synthesize prestador;

-(IBAction) showImage {

    ImageViewController *imageViewController = [[ImageViewController alloc] init];
    imageViewController.prestador = prestador;
    imageViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:imageViewController animated:YES];
    [imageViewController release];

}

-(IBAction) showMap:(id)sender {
    
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.endereco = prestador.Endereco;
    self.tabBarController.selectedIndex = 2;

    // Specific for IOS 5
    NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
    [controllers replaceObjectAtIndex:self.tabBarController.selectedIndex withObject: mapViewController];
    self.tabBarController.viewControllers = controllers;

    self.tabBarController.selectedViewController = mapViewController;

}

-(void) showRecordData {
    
    
    [btnNome setTitle:[NSString stringWithFormat:@"%@", prestador.Nome] forState:UIControlStateNormal];
    
    [btnTelefone setTitle:[NSString stringWithFormat:@"Telefone    %@", prestador.Telefone] forState:UIControlStateNormal];

    [btnEndereco setTitle:[NSString stringWithFormat:@"%@ - %d - %@ - %@ - %@", prestador.Endereco.Rua, [prestador.Endereco.Numero integerValue], prestador.Endereco.Complemento, prestador.Endereco.Bairro.Nome, prestador.Endereco.Bairro.Cidade.Nome ] forState:UIControlStateNormal];
    

    NSEnumerator *enumerator = [prestador.Especialidades objectEnumerator];
    Especialidade *especialidadeObj;
    NSString *especialidade = [[NSString alloc] init];
    int i=0;
    
    while ( ( especialidadeObj = [enumerator nextObject]) )
    {
        
        if (i>0) {
            especialidade = [especialidade stringByAppendingString:@" e "];
            lblEspecialidades.text = especialidade;
        }
        
        if (especialidadeObj) {
            
            especialidade = [especialidade stringByAppendingString:especialidadeObj.Nome];
            lblEspecialidades.text = especialidade;
        }
        
        i++;
        
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    [self showRecordData];

    [super viewDidLoad];
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
