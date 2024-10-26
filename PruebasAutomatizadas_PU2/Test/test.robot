*** Settings ***
Library    SeleniumLibrary
Resource    ../Recursos/keywords.robot
Resource    ../Datos/variables.robot
Test Teardown    Close Browser

#//button[@Class='added-manually']
*** Test Cases ***
Agregar/Quitar Elementos
    Iniciar Navegador   ${URL_1}    ${BROWSER}
    Wait Until Element is Visible               xpath://button  10s
    Dar click N veces                           20     xpath://button
    Sleep                                       2s
    Verificar cantidad botones                  //button[@Class='added-manually']       20
    Dar click N veces                           20     //button[@Class='added-manually']
    Sleep                                       2s
    Verificar cantidad botones                  //button[@Class='added-manually']       0
