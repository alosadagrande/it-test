*** Settings ***
Documentation   Event pull status notification
# Library  REST       ssl_verify=False    loglevel=DEBUG
Library  REST       ssl_verify=False
Variables              ${EXECDIR}${/}test_configs.yaml

Suite Setup            Set REST Headers

*** Variables ***
${ORAN_HOST_EXTERNAL_IP}    ${ocloud.oran_o2_app.api.host}
${ORAN_SERVICE_NODE_PORT}   ${ocloud.oran_o2_app.api.node_port}
${GLOBAL_OCLOUD_ID1}        ${ocloud.oran_o2_app.g_ocloud_id}
${SMO_TOKEN_DATA}           ${ocloud.oran_o2_app.smo_token_data}
${globalLocationId}         ${ocloud.oran_o2_app.g_location_id}
${ENDPOINT_URI}             ${ocloud.oran_o2_notification.endpoint_uri}
${RESOURCE_ADDRESS}         ${ocloud.oran_o2_notification.resource_address}      
${PTP_EVENT_ENDPOINT}       ${ocloud.oran_o2_notification.publisher_endpoint}

*** Test Cases ***
s1, The return code is “200 OK” when event notification resource is available on this node.
    [documentation]  This test case verifies the capability of successfully pulling of the event from an event consumer
    [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Event_Notification

    Clear Expectations
    Set Headers     {"Content-Type": "application/json"}
    ${subscriptionRequest}      input   {"EndpointUri": "${ENDPOINT_URI}", "ResourceAddress": "${RESOURCE_ADDRESS}"}
    ${res}     POST   ${PTP_EVENT_ENDPOINT}/api/ocloudNotifications/v2/subscriptions       ${subscriptionRequest}
    log      ${res}   level=DEBUG
    Integer  response status    201
    Object   response body

    Clear Expectations
    Expect Response Body        ${CURDIR}/schemas/subscription_event_data.json
    ${res}     GET   ${PTP_EVENT_ENDPOINT}/api/ocloudNotifications/v2${RESOURCE_ADDRESS}/CurrentState
    Integer     response status    200
    Object       response body

s2, Return code is “404 Not Found” when event notification resource is not available on this node.
    [documentation]  This test case verifies the capability of unsuccessfully pulling of the event from an event consumer
    [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Event_Notification

    Clear Expectations
    ${res}     GET   ${PTP_EVENT_ENDPOINT}/api/ocloudNotifications/v2/resourceDoesNotExist/CurrentState
    Integer     response status    404

*** Keywords ***
Set REST Headers
    Set Headers     {"accept": "application/json"}
    Set Headers     {"Content-Type": "application/json"}
    Set Headers     {"Authorization": "Bearer ${SMO_TOKEN_DATA}"}
    Set Client Cert   ${CURDIR}/../certs/client.pem
