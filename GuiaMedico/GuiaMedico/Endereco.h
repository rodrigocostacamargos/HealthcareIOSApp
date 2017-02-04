//
//  Endereco.h
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright (c) 2011 InHouse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bairro, Prestador;

@interface Endereco : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * Complemento;
@property (nonatomic, retain) NSNumber * Latitude;
@property (nonatomic, retain) NSNumber * Longitude;
@property (nonatomic, retain) NSNumber * Numero;
@property (nonatomic, retain) NSString * Rua;
@property (nonatomic, retain) Bairro * Bairro;
@property (nonatomic, retain) Prestador * Prestador;

@end
