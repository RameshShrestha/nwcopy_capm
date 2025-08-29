sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.ramesh.manageorder',
            componentId: 'OrderDetailObjectPage',
            contextPath: '/Orders/Order_Details'
        },
        CustomPageDefinitions
    );
});