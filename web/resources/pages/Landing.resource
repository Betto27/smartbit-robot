*** Settings ***
Documentation        Ações e elementos da Landing Page

Library        Browser

*** Keywords ***

Submit signup form
    [Arguments]        ${account}
    
    Get Text    css=#signup h2        
    ...    equal    Faça seu cadastro e venha para a Smartbit!

    Fill Text    id=name         ${Account}[name]
    Fill Text    id=email        ${Account}[email]
    Fill Text    id=cpf          ${Account}[cpf]
    
    #Click    xpath=//button[text()="Cadastrar"]
    Click    css=button >> text=Cadastrar
    #Click    text=Cadastrar

