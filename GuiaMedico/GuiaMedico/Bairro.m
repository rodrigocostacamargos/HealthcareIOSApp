//
//  Bairro.m
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright (c) 2011 InHouse. All rights reserved.
//

#import "Bairro.h"
#import "Cidade.h"
#import "Endereco.h"
#import "Especialidade.h"


@implementation Bairro
@dynamic Cep;
@dynamic Nome;
@dynamic Cidade;
@dynamic Enderecos;
@dynamic Especialidades;


- (void)addEnderecosObject:(Endereco *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Enderecos" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Enderecos"] addObject:value];
    [self didChangeValueForKey:@"Enderecos" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeEnderecosObject:(Endereco *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Enderecos" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Enderecos"] removeObject:value];
    [self didChangeValueForKey:@"Enderecos" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addEnderecos:(NSSet *)value {    
    [self willChangeValueForKey:@"Enderecos" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Enderecos"] unionSet:value];
    [self didChangeValueForKey:@"Enderecos" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeEnderecos:(NSSet *)value {
    [self willChangeValueForKey:@"Enderecos" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Enderecos"] minusSet:value];
    [self didChangeValueForKey:@"Enderecos" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addEspecialidadesObject:(Especialidade *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Especialidades"] addObject:value];
    [self didChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeEspecialidadesObject:(Especialidade *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Especialidades"] removeObject:value];
    [self didChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addEspecialidades:(NSSet *)value {    
    [self willChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Especialidades"] unionSet:value];
    [self didChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeEspecialidades:(NSSet *)value {
    [self willChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Especialidades"] minusSet:value];
    [self didChangeValueForKey:@"Especialidades" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
