*** Settings ***
Documentation        Ações e elementos do componente de caixa de notificação

Library    Browser

*** Keywords ***

Notice should be 
    [Arguments]        ${target}

    ${element}        Set Variable        css=form .notice
    
    Wait For Elements State    
    ...    ${element}    visible    10
    
    Get Text    ${element}    equal    ${target}

    Sleep    3