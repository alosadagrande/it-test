*** Settings ***
Documentation  Verify SMO get 405 while sending o2ims APIs with unsupported method
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

${ORAN_O2IMS_ENDPOINT}      ${ocloud.oran_o2_app.api.protocol}://${ORAN_HOST_EXTERNAL_IP}:${ORAN_SERVICE_NODE_PORT}
${RESOURCETYPE_NAME}        ${ocloud.oran_o2_app.resourcetype_name}
${SMO_INV_OBSERVER_URL}     ${smo.service.protocol}://${smo.service.host}:${smo.service.port}${smo.o2ims_inventory_observer.path}

*** Test Cases ***
s1, Operate resourceTypes with unsupported method
    [documentation]  This test case verifies Operate resourceTypes with unsupported method
    [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

    # Clear Expectations
    # Expect Response Body        ${CURDIR}/schemas/unsupported_method_properties.json
    # ${res}     POST   ${ORAN_O2IMS_ENDPOINT}/o2ims-infrastructureInventory/v1/resourceTypes
    # # Output Schema   response body   ${CURDIR}/schemas/.output/unsupported_method_properties.json
    # # Clear Expectations
    # log      ${res}   level=DEBUG
    # Integer  response status    405
    # Object   response body

    ${resourceTypeId}   input   3d19af47-e20d-40f9-ae74-f8cc988a045f
    Expect Response Body        ${CURDIR}/schemas/unsupported_method_properties.json
    ${res}     GET   ${ORAN_O2IMS_ENDPOINT}/o2ims-infrastructureInventory/v1/resourceTypes/${resourceTypeId}
    # Output Schema   response body   ${CURDIR}/schemas/.output/unsupported_method_properties.json
    Clear Expectations
    log      ${res}   level=DEBUG
    Integer  response status    404

    ${resouceTypeData}      input   {'description': 'An ethernet resource of the physical server', 'name': '5af55345-enp61s0f0', 'parentId': '5af55345-134a-406c-93b6-c5e10318afa5', 'resourceId': '016977ee-c0c3-4e5d-9e53-2bf1d6448aa5', 'resourcePoolId': 'ce2eec13-24b0-4cca-aa54-548be6cc985b','resourceTypeId': '3d19af47-e20d-40f9-ae74-f8cc988a045f'}

    ${res}     POST   ${ORAN_O2IMS_ENDPOINT}/o2ims-infrastructureInventory/v1/resourceTypes/${resourceTypeId}       ${resouceTypeData}
    # Clear Expectations
    log      ${res}   level=DEBUG
    Integer  response status    405
    Object   response body

# s2, Operate resourcePool with unsupported method
#     [documentation]  This test case verifies Operate resourcePool with unsupported method
#     [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

s2, Operate resourcePool with unsupported method
    [documentation]  This test case verifies Operate Ocloud with unsupported method
    [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

    Clear Expectations
    # Expect Response Body        ${CURDIR}/schemas/unsupported_method_properties.json
    ${res}     POST   ${ORAN_O2IMS_ENDPOINT}/o2ims-infrastructureInventory/v1/resourcePools
    # Output Schema   response body   ${CURDIR}/schemas/.output/unsupported_method_properties.json
    # Clear Expectations
    log      ${res}   level=DEBUG
    Integer  response status    405
    Object   response body

# s3, Operate Resource with unsupported method
#     [documentation]  This test case verifies Operate resourcePool with unsupported method
#     [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

s3, Operate Resource with unsupported method
    [documentation]  This test case verifies Operate Ocloud with unsupported method
    [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

    Clear Expectations
    GET   ${ORAN_O2IMS_ENDPOINT}/o2ims-infrastructureInventory/v1/resourcePools
    ${resourcePoolId}      output   $[0].resourcePoolId
    # Clear Expectations
    # Expect Response Body        ${CURDIR}/schemas/unsupported_method_properties.json
    ${res}     POST   ${ORAN_O2IMS_ENDPOINT}/o2ims-infrastructureInventory/v1/resourcePools/${resourcePoolId}/resources
    # Output Schema   response body   ${CURDIR}/schemas/.output/unsupported_method_properties.json
    # Clear Expectations
    log      ${res}   level=DEBUG
    Integer  response status    405
    Object   response body

# s4, Operate DeploymentManager with unsupported method
#     [documentation]  This test case verifies Operate resourcePool with unsupported method
#     [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

s4, Operate DeploymentManager with unsupported method
    [documentation]  This test case verifies Operate Ocloud with unsupported method
    [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

    Clear Expectations
    # Expect Response Body        ${CURDIR}/schemas/unsupported_method_properties.json
    ${res}     POST   ${ORAN_O2IMS_ENDPOINT}/o2ims-infrastructureInventory/v1/deploymentManagers
    # Output Schema   response body   ${CURDIR}/schemas/.output/unsupported_method_properties.json
    # Clear Expectations
    log      ${res}   level=DEBUG
    Integer  response status    405
    Object   response body

# s5, Operate Ocloud with unsupported method
#     [documentation]  This test case verifies Operate resourcePool with unsupported method
#     [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

s5, Operate Ocloud with unsupported method
    [documentation]  This test case verifies Operate Ocloud with unsupported method
    [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

    Clear Expectations
    # Expect Response Body        ${CURDIR}/schemas/unsupported_method_properties.json
    ${res}     POST   ${ORAN_O2IMS_ENDPOINT}/o2ims-infrastructureInventory/v1
    # Output Schema   response body   ${CURDIR}/schemas/.output/unsupported_method_properties.json
    # Clear Expectations
    log      ${res}   level=DEBUG
    Integer  response status    405
    Object   response body

# s6, Operate Inventory Subscription with unsupported method
#     [documentation]  This test case verifies Operate resourcePool with unsupported method
#     [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

s6, Operate Inventory Subscription with unsupported method
    [documentation]  This test case verifies Operate Ocloud with unsupported method
    [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

    ${subscription_data}   input   {"filter":"(eq,extensions/country,US);","callback":"${SMO_INV_OBSERVER_URL}","consumerSubscriptionId":"69253c4b-8398-4602-855d-783865f5f25c","subscriptionId":"167351c9-74e8-440c-aeed-80ca2a5707aa"}
    Clear Expectations
    # Expect Response Body        ${CURDIR}/schemas/unsupported_method_properties.json
    ${res}     PATCH   ${ORAN_O2IMS_ENDPOINT}/o2ims-infrastructureInventory/v1/subscriptions     ${subscription_data}
    # Output Schema   response body   ${CURDIR}/schemas/.output/unsupported_method_properties.json
    # Clear Expectations
    log      ${res}   level=DEBUG
    Integer  response status    405
    Object   response body

# s7, Operate Alarm with unsupported method
#     [documentation]  This test case verifies Operate resourcePool with unsupported method
#     [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

s7, Operate Alarm with unsupported method
    [documentation]  This test case verifies Operate Ocloud with unsupported method
    [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

    Clear Expectations
    # Expect Response Body        ${CURDIR}/schemas/unsupported_method_properties.json
    ${res}     POST   ${ORAN_O2IMS_ENDPOINT}/o2ims-infrastructureInventory/v1/alarms
    # Output Schema   response body   ${CURDIR}/schemas/.output/unsupported_method_properties.json
    # Clear Expectations
    log      ${res}   level=DEBUG
    Integer  response status    405
    Object   response body

# s8, Operate Alarm Subscription with unsupported method
#     [documentation]  This test case verifies Operate resourcePool with unsupported method
#     [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

s8, Operate Alarm Subscription with unsupported method
    [documentation]  This test case verifies Operate Ocloud with unsupported method
    [tags]  ORAN_Compliance     ORAN_O2     ORAN_O2IMS     ORAN_O2IMS_Unsupported_Method

    Clear Expectations
    # Expect Response Body        ${CURDIR}/schemas/unsupported_method_properties.json
    ${res}     PATCH   ${ORAN_O2IMS_ENDPOINT}/o2ims-infrastructureInventory/v1/alarmSubscriptions
    # Output Schema   response body   ${CURDIR}/schemas/.output/unsupported_method_properties.json
    # Clear Expectations
    log      ${res}   level=DEBUG
    Integer  response status    405
    Object   response body

*** Keywords ***
Set REST Headers
    Set Headers     {"accept": "application/json"}
    Set Headers     {"Content-Type": "application/json"}
    Set Headers     {"Authorization": "Bearer ${SMO_TOKEN_DATA}"}
    Set Client Cert   ${CURDIR}/../certs/client.pem
