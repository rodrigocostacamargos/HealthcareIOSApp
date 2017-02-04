//
//  Especialidade.h
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/25/11.
//  Copyright (c) 2011 InHouse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bairro, Prestador;

@interface Especialidade : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * Nome;
@property (nonatomic, retain) NSNumber * Codigo;
@property (nonatomic, retain) NSSet* Bairros;
@property (nonatomic, retain) NSSet* Prestadores;

@end
