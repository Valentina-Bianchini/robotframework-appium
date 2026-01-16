*** Settings ***
Documentation    🎯 Localizadores de elementos para BlazeDemo.com
...             Todos los XPaths, IDs, CSS Selectors organizados por página

*** Variables ***
# 🏠 HOME PAGE - Página principal de selección de vuelos
${HOME_DEPARTURE_SELECT}        name:fromPort
${HOME_DESTINATION_SELECT}      name:toPort
${HOME_FIND_FLIGHTS_BTN}        css:input[type='submit']
${HOME_PAGE_HEADING}            xpath://h1[contains(text(),'Simple Travel Agency')]
${HOME_VACATION_LINK}           xpath://a[contains(@href,'vacation')]

# ✈️ FLIGHT LIST PAGE - Lista de vuelos disponibles
${FLIGHTS_PAGE_HEADING}         xpath://h3[contains(text(),'Flights from')]
${FLIGHTS_TABLE}                xpath://table[@class='table']
${FLIGHTS_TABLE_ROWS}           xpath://table[@class='table']//tbody//tr
${FLIGHT_SELECT_BTN}            css:input[type='submit']
${FLIGHT_PRICE}                 xpath://td[1]
${FLIGHT_NUMBER}                xpath://td[2]
${FLIGHT_AIRLINE}               xpath://td[3]
${FLIGHT_DEPARTURE}             xpath://td[4]
${FLIGHT_ARRIVAL}               xpath://td[5]

# 💳 PURCHASE PAGE - Formulario de compra
${PURCHASE_PAGE_HEADING}        xpath://h2[contains(text(),'Your flight from')]
${PURCHASE_FLIGHT_DETAILS}      xpath://p[contains(text(),'Airline:')]
${PURCHASE_TOTAL_COST}          xpath://p[contains(@id,'price')]/em

# Campos del formulario de compra
${PURCHASE_NAME_INPUT}          id:inputName
${PURCHASE_ADDRESS_INPUT}       id:address
${PURCHASE_CITY_INPUT}          id:city
${PURCHASE_STATE_INPUT}         id:state
${PURCHASE_ZIP_INPUT}           id:zipCode
${PURCHASE_CARD_TYPE_SELECT}    id:cardType
${PURCHASE_CARD_NUMBER_INPUT}   id:creditCardNumber
${PURCHASE_CARD_MONTH_INPUT}    id:creditCardMonth
${PURCHASE_CARD_YEAR_INPUT}     id:creditCardYear
${PURCHASE_NAME_ON_CARD_INPUT}  id:nameOnCard
${PURCHASE_REMEMBER_CHECKBOX}   id:rememberMe
${PURCHASE_SUBMIT_BTN}          css:input[type='submit']

# ✅ CONFIRMATION PAGE - Página de confirmación
${CONFIRM_PAGE_HEADING}         xpath://h1[contains(text(),'Thank you')]
${CONFIRM_SUCCESS_MESSAGE}      xpath://div[@class='container']//h1
${CONFIRM_CONFIRMATION_CODE}    xpath://tr[1]/td[2]
${CONFIRM_STATUS}               xpath://tr[2]/td[2]
${CONFIRM_AMOUNT}               xpath://tr[3]/td[2]
${CONFIRM_CARD_NUMBER}          xpath://tr[4]/td[2]
${CONFIRM_EXPIRATION}           xpath://tr[5]/td[2]
${CONFIRM_AUTH_CODE}            xpath://tr[6]/td[2]
${CONFIRM_TIMESTAMP}            xpath://tr[7]/td[2]
${CONFIRM_TABLE}                xpath://table[@class='table']

# 🔗 NAVIGATION - Enlaces de navegación
${NAV_HOME_LINK}                xpath://a[contains(text(),'home')]
${NAV_TRAVEL_LINK}              xpath://a[contains(text(),'Travel The World')]

# 📱 RESPONSIVE - Elementos específicos mobile
${MOBILE_MENU_TOGGLE}           css:.navbar-toggle
${MOBILE_DROPDOWN}              css:.dropdown-menu
