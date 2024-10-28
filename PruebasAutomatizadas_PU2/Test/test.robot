*** Settings ***
Library    SeleniumLibrary
Resource    ../Recursos/keywords.robot
Resource    ../Datos/variables.robot
Test Teardown    Close Browser

*** Test Cases ***
Agregar/Quitar Elementos 1
    Iniciar Navegador   ${URL_1}    ${BROWSER}
    Wait Until Element is Visible               xpath://button  10s
    Dar click N veces                           20     xpath://button
    Sleep                                       2s
    Verificar cantidad botones                  //button[@Class='added-manually']       20
    Dar click N veces                           20     //button[@Class='added-manually']
    Sleep                                       2s
    Verificar cantidad botones                  //button[@Class='added-manually']       0

Autenticacion Basica 2
    Iniciar Navegador   ${URL_2}    ${BROWSER}
    Test Teardown    Close Browser


Drag and Drop 6
    Iniciar Navegador   ${URL_6}    ${BROWSER}
    Sleep                                       2s
    Drag and Drop                               //header[text()='A']    //div[@id='column-b']
    Element Should Contain                      //div[@id='column-b']   A
    Reload Page
    Drag and Drop                               //header[text()='B']    //div[@id='column-a']
    Element Should Contain                      //div[@id='column-a']   B

Autenticación con Formulario 9
    Iniciar Navegador   ${URL_9}    ${BROWSER}
    Inicio Sesion 9                             tomsmith    SuperSecretPassword!
    Element Should Contain                      xpath://div[@id='flash']    You logged into a secure area!
    Click Link                                  //a[@class='button secondary radius']
    Element Should Contain                      xpath://div[@id='flash']    You logged out of the secure area!
    Inicio Sesion 9                             tomsmith1   SuperSecretPassword!
    Element Should Contain                      xpath://div[@id='flash']    Your username is invalid!
    Inicio Sesion 9                             tomsmith    SuperS1ecretPassword!
    Element Should Contain                      xpath://div[@id='flash']    Your password is invalid!
