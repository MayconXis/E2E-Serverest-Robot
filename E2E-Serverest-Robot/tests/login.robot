*** Settings ***
Library    Browser
Resource   ../resources/base.resource

Test Setup      Start Session
Test Teardown   Close Browser

*** Test Cases ***
Deve validar login com sucesso
    ${timestamp}=    Get Time    epoch

    &{user}=    Create Dictionary
    ...    name=Isa
    ...    email=isa_${timestamp}@gmail.com
    ...    password=123456789

    Go To    ${BASE_URL}/cadastrarusuarios

    Wait For Elements State    id=nome    visible    10s

    Fill Text    css=#nome    ${user}[name]
    Fill Text    css=#email    ${user}[email]
    Fill Text    css=#password    ${user}[password]
    Click    css=button[type=submit]

    Wait For Elements State    id=email    visible    10s
    Fill Text    id=email       ${user}[email]
    Fill Text    id=password    ${user}[password]
    Click    css=button[type=submit]


    Wait For Elements State    button[data-testid=logout]    visible    10s

Não deve cadastrar email duplicado
    ${timestamp}=    Get Time    epoch

    &{user}=    Create Dictionary
    ...    name=Isa Duplicada
    ...    email=isa_duplicada_${timestamp}@gmail.com
    ...    password=123456

    Go To    ${BASE_URL}/cadastrarusuarios
    Wait For Elements State    id=nome    visible    10s
    Fill Text    css=#nome       ${user}[name]
    Fill Text    css=#email      ${user}[email]
    Fill Text    css=#password   ${user}[password]
    Click    css=button[type=submit]
    Wait For Elements State    text="Cadastro realizado com sucesso"    visible    5s

    Go To    ${BASE_URL}/cadastrarusuarios
    Wait For Elements State    id=nome    visible    10s
    Fill Text    css=#nome       ${user}[name]
    Fill Text    css=#email      ${user}[email]
    Fill Text    css=#password   ${user}[password]
    Click    css=button[type=submit]

    Wait For Elements State    text="Este email já está sendo usado"    visible  5s