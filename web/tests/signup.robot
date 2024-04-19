*** Settings ***
Documentation        Cenários de testes de pré-cadastro de clientes


Resource        ../resources/Base.resource
Resource    ../resources/pages/Welcome.resource

Test Setup        Start session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve iniciar o cadastro do cliente
    [Tags]        smoke

    #${Account}    Get Fake Account
    ${Account}     Create Dictionary        name=Tony Stark        email=stark@gmail.com.br        cpf=06097411871

    Delete Account By Email        ${Account}[email]
    
    Submit signup form    ${Account}
    Verify welcome message
    

    

# Campo nome deve ser obrigatório
#     [Tags]    required
    
#     ${account}        Create Dictionary        name=${EMPTY}        email=papito@teste.com.br        cpf=39831866029

  
#     Submit signup form    ${account}

#     Notice should be    Por favor informe o seu nome completo
    

# Campo email deve ser obrigatório
#     [Tags]    required
    
#     ${account}        Create Dictionary        name=Fernando Papito        email=${EMPTY}         cpf=39831866029

    
#     Submit signup form    ${Account}

#     Notice should be    Por favor, informe o seu melhor e-mail
    
    


# Campo CPF deve ser obrigatório
#     [Tags]    required
    
#     ${account}        Create Dictionary        name=Fernando Papito        email=papito@teste.com.br        cpf=${EMPTY} 

    
#     Submit signup form    ${Account}

#     Notice should be    Por favor, informe o seu CPF
    
    

# Email no formato inválido
#     [Tags]    inv
    
#     ${account}        Create Dictionary        name=Fernando Papito        email=papito*teste.com.br        cpf=39831866029 

    
#     Submit signup form    ${Account} 

#     Notice should be   Oops! O email informado é inválido
    

# CPF no formato inválido
#     [Tags]    inv
    

#     ${account}        Create Dictionary        name=Fernando Papito        email=papito@teste.com.br        cpf=3983186602aa

    
#     Submit signup form    ${Account}

#     Notice should be        Oops! O CPF informado é inválido


Tentativa de pré-cadastro
    [Template]        Attempt signup
    ${EMPTY}           papito@gmail.com       39831866029        Por favor informe o seu nome completo
    Fernando Papito    ${EMPTY}               39831866029        Por favor, informe o seu melhor e-mail
    Julia Mendes       julia@gmail.com        ${EMPTY}           Por favor, informe o seu CPF   
    Fernando Papito    papito*teste.com.br    39831866029        Oops! O email informado é inválido
    Fernando Papito    papito@teste.com.br    3983186602aa       Oops! O CPF informado é inválido

*** Keywords ***

Attempt signup
    [Arguments]    ${nome}    ${email}    ${cpf}    ${output_message}  

    ${account}      Create Dictionary    name=${nome}    email=${email}    cpf=${cpf}
    
    Submit signup form        ${account}
    Notice should be          ${output_message}
    Take Screenshot