*** Settings ***

Documentation        Ações e elementos da página de Matrículas

Library        Browser

*** Keywords ***
Create new memberships
    [Arguments]        ${data}

    #Preenche o formulario e faz a matricula
    Go to memberships form
    #Go to enroll form
    Select account        ${data}[account][name]          ${data}[account][cpf]
    Selec plan            ${data}[plan][name]
    Fill payment          ${data}[credit_card]   

    Click    css=button[type=submit] >> text=Cadastrar

Go to memberships form
#Go to enroll form
    
        Sleep    1
    Click        css=a[href="/memberships/new"]
    Sleep    1

    Wait For Elements State        css=h1 >> text=Nova Matrícula        visible        5

Select account
    [Arguments]        ${name}        ${cpf}

    Fill Text    css=input[aria-label=select_account]        ${name} 
    Click        css=[data-testid="${cpf}"]

Selec plan
    [Arguments]        ${plan_name}

    Fill Text       css=input[aria-label=select_plan]        ${plan_name}
    #Click            css=div[id*=option] >> text=Plano Black
    Click        css=div[class$=option] >> text=${plan_name}

Fill payment
    [Arguments]        ${card}

    Fill Text    css=input[name=card_number]        ${card}[number]    
    Fill Text    css=input[name=card_holder]        ${card}[holder]
    Fill Text    css=input[name=card_month]         ${card}[month]
    Fill Text    css=input[name=card_year]          ${card}[year]
    Fill Text    css=input[name=card_cvv]           ${card}[cvv]


Search by name
    [Arguments]         ${name}

    Fill Text                      css=input[placeholder^=Busque]            ${name}
    
    Wait For Elements State        css=strong >> text=Total: 1               visible        5
    

Should filter by name
    [Arguments]        ${name}
    
    Wait For Elements State        css=table tbody tr >> text=${name}        visible        5

Request removal
    [Arguments]        ${name}

    Click        xpath=//td[text()="${name}"]/..//button

Memberships should not be visible
    [Arguments]                    ${name}

    Wait For Elements State        css=table tbody tr >> text=${name}        detached         5

    Sleep    3

