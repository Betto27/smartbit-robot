*** Settings ***
Documentation        Cenários de testes do Login SAC

Resource          ../resources/Base.resource

Test Setup        Start session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve logar como Gestor de Academia

    Go To login page 
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com 

Não deve logar com senha incorreta
    [Tags]    inv_pass

    Go to login page
    Submit login form      sac@smartbit.com    abc123
    Toast should be        As credenciais de acesso fornecidas são inválidas. Tente novamente!

Não deve logar com email incorreto
    [Tags]    email_404_pass

    Go to login page
    Submit login form      404@smartbit.com    abc123
    Toast should be        As credenciais de acesso fornecidas são inválidas. Tente novamente!

Tentativa de login com dados incorretos
    [Tags]        temp
    [Template]    Login with verify notice

    ${EMPTY}            ${EMPTY}        Os campos email e senha são obrigatórios.
    ${EMPTY}            pwd123          Os campos email e senha são obrigatórios.
    sac@smartbit.com    ${EMPTY}        Os campos email e senha são obrigatórios.
    www.teste.com.br    pwd123          Oops! O email informado é inválido
    kndfsllslkkks       pwd123          Oops! O email informado é inválido
    jula$hotmail.com    pwd123          Oops! O email informado é inválido
    54981513515         pwd123          Oops! O email informado é inválido
    hotmail.com@#       pwd123          Oops! O email informado é inválido
    
*** Keywords ***
Login with verify notice
    [Arguments]        ${email}        ${password}        ${output_message}

    Go to login page
    Submit login form    ${email}    ${password}
    Notice should be    ${output_message}
