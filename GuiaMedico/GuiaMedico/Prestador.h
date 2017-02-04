//
//  Prestador.h
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 11/7/11.
//  Copyright (c) 2011 InHouse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Endereco, Especialidade;

@interface Prestador : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * Telefone;
@property (nonatomic, retain) NSString * Nome;
@property (nonatomic, retain) NSNumber * Codigo;
@property (nonatomic, retain) NSNumber * Favorito;
@property (nonatomic, retain) Endereco * Endereco;
@property (nonatomic, retain) NSSet* Especialidades;

@end
