//
//  PrestadorDetailViewController.h
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/21/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Prestador.h"
#import "Endereco.h"
#import "Bairro.h"
#import "Especialidade.h"

@interface PrestadorDetailViewController : UIViewController {
 
    IBOutlet UILabel *lblEspecialidades;
    
    IBOutlet UIButton *btnTelefone;
    IBOutlet UIButton *btnEndereco;
    IBOutlet UIButton *btnNome;
}

@property (nonatomic, retain) Prestador *prestador;

-(IBAction) showMap:(id) sender;
-(IBAction) showImage;
@end
