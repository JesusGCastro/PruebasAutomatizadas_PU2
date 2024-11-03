*** Settings ***
Library    SeleniumLibrary
Resource    ../Recursos/keywords.robot
Resource    ../Datos/variables.robot
Test Teardown    Cerrar Navegador

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
    Iniciar Navegador   ${URL_2_0}   ${BROWSER}
    Wait Until Element is Visible   xpath://div[@id="content"]
    Page Should Contain        Basic Auth
    Close Browser
    Iniciar Navegador   ${URL_2_1}    ${BROWSER}
    Page Should Not Contain        Basic Auth

Checkboxes 3
    Iniciar Navegador    ${URL_3}   ${BROWSER}
    Wait Until Element is Visible   xpath://form[@id="checkboxes"]
    Unselect Checkbox               xpath://form[@id="checkboxes"]/input[2]
    Select Checkbox                 xpath://form[@id="checkboxes"]/input[1]
    Checkbox Should Be Selected     xpath://form[@id="checkboxes"]/input[1]
    Select Checkbox                 xpath://form[@id="checkboxes"]/input[2]
    Checkbox Should Be Selected     xpath://form[@id="checkboxes"]/input[2]

Context Menu 4
    Iniciar Navegador    ${url_4}   ${BROWSER}
    Wait Until Element is Visible   xpath://div[@id="hot-spot"]
    Execute Javascript    var element = document.evaluate("//div[@id='hot-spot']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; var evt = new MouseEvent('contextmenu', {bubbles: true, cancelable: true, view: window}); element.dispatchEvent(evt);
    Alert Should Be Present
    Alert Should Not Be Present

Elementos que desaparecen
    Iniciar Navegador    ${url_10}   ${BROWSER}
        Maximize Browser Window

    #Actualizar hasta que el botón sea visible
    ${visible} =    Run Keyword And Return Status    Element Should Be Visible    ${GALLERY_BUTTON_XPATH}
    WHILE    not ${visible}
        Reload Page
        Sleep    1s
        ${visible} =    Run Keyword And Return Status    Element Should Be Visible    ${GALLERY_BUTTON_XPATH}
    END

    Element Should Be Visible    ${GALLERY_BUTTON_XPATH}

    #Actualizar hasta que el botón no sea visible
    ${visible} =    Run Keyword And Return Status    Element Should Be Visible    ${GALLERY_BUTTON_XPATH}
    WHILE    ${visible}
        Reload Page
        Sleep    1s
        ${visible} =    Run Keyword And Return Status    Element Should Be Visible    ${GALLERY_BUTTON_XPATH}
    END

    Element Should Not Be Visible    ${GALLERY_BUTTON_XPATH}

Drag and Drop 6
    Iniciar Navegador   ${URL_6}    ${BROWSER}
    Sleep                                       2s
    Drag and Drop                               //header[text()='A']    //div[@id='column-b']
    Element Should Contain                      //div[@id='column-b']   A
    Reload Page
    Drag and Drop                               //header[text()='B']    //div[@id='column-a']
    Element Should Contain                      //div[@id='column-a']   B

Controles dinamicos
    Open Browser    ${URL_11}    ${BROWSER}
    Maximize Browser Window

    #Remover el checkbox
    Click Element    //button[text()="Remove"]

    ${checkbox_exists} =    Run Keyword And Return Status    Element Should Be Visible    //input[@type="checkbox"]
    WHILE    ${checkbox_exists}
        Sleep    1s
        ${checkbox_exists} =    Run Keyword And Return Status    Element Should Be Visible    //input[@type="checkbox"]
    END

    #Habilitar el input
    Click Element    //button[text()="Enable"]
    Wait Until Element Is Enabled    //input[@type="text"]    timeout=10s

Menú Flotante 8
    Iniciar Navegador   ${URL_8}    ${BROWSER}
    Scroll Element Into View        xpath://*[@id="page-footer"]
    Wait Until Element is Visible   xpath://*[@id="menu"]
    Element Should Be Visible       xpath://*[@id="menu"]
    Element Should Be Visible       xpath://*[@id="menu"]/ul/li[1]/a
    Element Should Be Visible       xpath://*[@id="menu"]/ul/li[2]/a
    Element Should Be Visible       xpath://*[@id="menu"]/ul/li[3]/a
    Element Should Be Visible       xpath://*[@id="menu"]/ul/li[4]/a

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

Teclas Presionadas 10
    Iniciar Navegador  ${URL_12}    ${BROWSER}
    Wait Until Element is Visible   xpath://*[@id="target"]
    Click Element                   xpath://*[@id="target"]

    # Presionar la tecla ESC y validar el mensaje
    Press Keys                      xpath://*[@id="target"]    ESCAPE
    Element Text Should Be          xpath://*[@id="result"]    You entered: ESCAPE

    # Presionar la barra espaciadora y validar el mensaje
    Press Keys                      xpath://*[@id="target"]    SPACE
    Element Text Should Be          xpath://*[@id="result"]    You entered: SPACE

    Cerrar Navegador