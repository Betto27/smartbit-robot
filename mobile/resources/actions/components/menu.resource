*** Settings ***
Documentation        Açõese e elementos dos componentes menu de navegação

Library        AppiumLibrary

*** Keywords ***
Touch my body
    Click Element         xpath=//android.widget.TextView[@text="Meu corpo"]

Touch my account
    Click Element         xpath=//android.widget.TextView[@text="Minha conta"]