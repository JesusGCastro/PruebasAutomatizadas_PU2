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

Drag and Drop
    Iniciar Navegador   ${URL_6}    ${BROWSER}
    Sleep                                       2s
    Drag and Drop                               //header[text()='A']    //div[@id='column-b']
    Element Should Contain                      //div[@id='column-b']   A
    Reload Page
    Drag and Drop                               //header[text()='B']    //div[@id='column-a']
    Element Should Contain                      //div[@id='column-a']   B