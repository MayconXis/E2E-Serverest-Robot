*** Settings ***
Resource  ../resources/base.resource

Test Setup  Start Session
Test Teardown  Browser.Take Screenshot

*** Keywords ***
Verificar Produto Excluido
    ${texto}=    Get Text    xpath=//table
    Should Not Contain  ${texto}  Teclado

*** Test Cases ***
Deve excluir produto
    [Documentation]  Testa a exclusão de um produto existente
    Go To  ${BASE_URL}/login

    #Login
    Fill text  css=input[name=email]     fulano123@qa.com
    Fill text  css=input[name=password]  teste123
    Click      css=button[type=submit]

    Click      css=[data-testid=listarProdutos]
    Click      xpath=//table//tr[td[text()="Teclado"]]//button[contains(@class,"btn-danger")]

    Sleep  1s
    Wait Until Keyword Succeeds    5x    1s    Verificar Produto Excluido

Deve Clicar no Botão Editar
    [Documentation]  Testa a edição de um produto existente
    Go To  ${BASE_URL}/login

    #Login
    Fill text  css=input[name=email]  fulano123@qa.com
    Fill text  css=input[name=password]  teste123
    Click      css=button[type=submit]

    Click      css=[data-testid=listarProdutos]
    Click      xpath=//table//tr[td[text()="Mouse"]]//button[contains(@class,"btn-info")]
