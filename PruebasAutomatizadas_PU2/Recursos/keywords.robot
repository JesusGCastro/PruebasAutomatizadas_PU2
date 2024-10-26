*** Keywords ***
Iniciar Navegador
    [Arguments]    ${URL}    ${BROWSER}
    Open Browser    ${URL}  ${BROWSER}
    Maximize browser window

Dar click N veces
    [Arguments]    ${veces}    ${xpath}
    FOR    ${i}    IN RANGE    ${veces}
        Click Element    ${xpath}
        Sleep    0.5s
    END

Verificar cantidad botones
    [Arguments]    ${xpath}    ${cantidad}
    ${CantidadBotones}=     Get Element Count   ${xpath}
    Should Be Equal as Integers                 ${CantidadBotones}  ${cantidad}