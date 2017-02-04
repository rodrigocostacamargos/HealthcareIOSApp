//
//  Cidade.h
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright (c) 2011 InHouse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bairro;

@interface Cidade : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * IBGE;
@property (nonatomic, retain) NSString * Nome;
@property (nonatomic, retain) NSString * UF;
@property (nonatomic, retain) NSSet* Bairros;

@end
