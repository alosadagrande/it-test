*** Settings ***
Documentation   Delete individual subscription resources.
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
${PTP_EVENT_ENDPOINT}       ${ocloud.oran_o2_notification.publisher_endpoint}

*** Test Cases ***
s1, The return code is “204 DELETE”, without Response message body content.
    [documentation]  This test case verifies the capability to delete a subscription of event notifications.
    [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Event_Subscription

    ${res}     GET   ${PTP_EVENT_ENDPOINT}/api/ocloudNotifications/v2/subscriptions
    @{res}     output  $
    Expect Response Body        ${CURDIR}/schemas/subscriptions_resource_properties.json
    Integer     response status    200
    Array       response body
    Array       $   minItems=1  uniqueItems=true
    
    Clear Expectations
    ${subscriptionId}       input       ${res}[0][SubscriptionId]
    ${res}     DELETE   ${PTP_EVENT_ENDPOINT}/api/ocloudNotifications/v2/subscriptions/${subscriptionId}
    log      ${res}   level=DEBUG
    Integer     response status    204

*** Keywords ***
Set REST Headers
    Set Headers     {"accept": "application/json"}
    Set Headers     {"Content-Type": "application/json"}
    Set Headers     {"Authorization": "Bearer ${SMO_TOKEN_DATA}"}
    Set Client Cert   ${CURDIR}/../certs/client.pem
