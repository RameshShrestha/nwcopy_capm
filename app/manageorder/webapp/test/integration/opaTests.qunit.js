sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/ramesh/manageorder/test/integration/FirstJourney',
		'com/ramesh/manageorder/test/integration/pages/OrdersList',
		'com/ramesh/manageorder/test/integration/pages/OrdersObjectPage',
		'com/ramesh/manageorder/test/integration/pages/OrderDetailObjectPage'
    ],
    function(JourneyRunner, opaJourney, OrdersList, OrdersObjectPage, OrderDetailObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/ramesh/manageorder') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheOrdersList: OrdersList,
					onTheOrdersObjectPage: OrdersObjectPage,
					onTheOrderDetailObjectPage: OrderDetailObjectPage
                }
            },
            opaJourney.run
        );
    }
);