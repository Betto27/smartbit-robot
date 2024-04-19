*** Settings ***

Documentation        Suite de testes de adesões de planos

Resource        ../resources/Base.resource

Test Setup        Start session
Test Teardown     Take Screenshot
Library    XML

*** Test Cases ***
Deve poder realizar uma nova adesão

    ${data}        Get Json fixture      memberships    create

    # ${account}        Create Dictionary         name=Paulo Cintura        email=paulo@cintura.com.br        cpf=05138356011   

    # ${plan}        Set Variable        Plano Black

    # ${credit_card}        Create Dictionary        number=4242424242424242        holder=Paulo Cintura       month=12        
    # ...    year=2030        cvv=123 
    
    #Deleta a conta
    Delete Account By Email    ${data}[account][email]
    #Cria a conta
    Insert Account             ${data}[account]
    
    SignIn admin    
    #Pagina de matriculas
    Go to memberships
    #Go to Erolls
    Create new memberships        ${data}          
    #Valida a confirmação do cadastro
    Toast should be    Matrícula cadastrada com sucesso.
    

    Sleep    5

Não deve realizar adesão duplicada
    [Tags]    dup

    ${data}        Get Json fixture      memberships    duplicate

    #Deleta a conta
    #Delete Account By Email    ${data}[account][email]
    #Cria a conta
    #Insert Account             ${data}[account]

    Insert Memberships        ${data}

    SignIn admin    
    #Pagina de matriculas
    Go to memberships
    #Go to Erolls
    #Create new memberships        ${data}     
    #Sleep    10
    Create new memberships        ${data}     
    #Valida a confirmação do cadastro
    Toast should be    O usuário já possui matrícula.
    
    Sleep    3

Deve buscar por nome
    [Tags]         search

    ${data}        Get Json fixture        memberships        search

    Insert Memberships           ${data}
    
    SignIn admin
    Go to memberships
    Search by name               ${data}[account][name]
    Should filter by name        ${data}[account][name]
    
Deve excluir uma matricula
    [Tags]         remove

    ${data}        Get Json fixture        memberships        remove

    Insert Memberships           ${data}
    
    SignIn admin
    Go to memberships
    Request removal                          ${data}[account][name]
    Confirm removal
    Memberships should not be visible        ${data}[account][name]
    


    
    