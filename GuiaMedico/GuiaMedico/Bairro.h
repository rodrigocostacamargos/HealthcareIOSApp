//
//  Bairro.h
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright (c) 2011 InHouse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cidade, Endereco, Especialidade;

@interface Bairro : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * Cep;
@property (nonatomic, retain) NSString * Nome;
@property (nonatomic, retain) Cidade * Cidade;
@property (nonatomic, retain) NSSet* Enderecos;
@property (nonatomic, retain) NSSet* Especialidades;

- (void)addEspecialidades:(NSSet *)value;

@end
