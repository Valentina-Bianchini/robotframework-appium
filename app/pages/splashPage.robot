***Settings***

Library           AppiumLibrary
Resource          ../../app/base/helpers.robot

*** Variables ***
# No hay elementos específicos del splash, solo esperamos que cargue


***Keywords***
Wait For Splash To Load
    [Documentation]    Espera 3 segundos para que el splash cargue
    Sleep    3s
