using NWCopyService as service from '../../srv/nwservicecopy';

annotate service.Orders with @(
    UI.SelectionPresentationVariant #Default: {
        Text               : 'All Books',
        PresentationVariant: {
            Visualizations: ['@UI.LineItem'],
            SortOrder     : [{
                $Type     : 'Common.SortOrderType',
                Property  : modifiedAt,
                Descending: true
            }]
        }
    },
    UI.SelectionFields                      : [
        OrderID,
        EmployeeID,
        OrderDate,
        ShipVia
    ],
    UI.HeaderInfo                           : {
        TypeName      : '{i18n>Order}',
        TypeNamePlural: '{i18n>Orders}',
        Title         : {
            Label: 'Order ID ',
            //A label is possible but it is not considered on the ObjectPage yet
            Value: OrderID
        },
        Description   : {
            Label      : 'Order Status',
            Value      : OrderStatus,
            Criticality: criticality
        }
    },
    UI.Identification                       : [

        {
            $Type  : 'UI.DataFieldForAction',
            Action : 'NWCopyService.placeOrder',
            Label  : 'Place Order',
            IconUrl: 'sap-icon://cart-approval',
          //  ![@UI.Hidden] : true
        
            

        },
        {
            $Type  : 'UI.DataFieldForAction',
            Action : 'NWCopyService.cancelOrder',
            Label  : 'Cancel Order',
            IconUrl: 'sap-icon://cart-approval',
             ![@UI.Hidden] : orderCancelVisible

        },
        {
            $Type  : 'UI.DataFieldForAction',
            Action : 'NWCopyService.orderDelivered',
            Label  : 'Order Delivered',
            IconUrl: 'sap-icon://cart-approval',
              ![@UI.Hidden] : orderDeliveredVisible

        },
        {
            $Type: 'UI.DataField',
            Value: OrderID,
        },
        {
            $Type: 'UI.DataField',
            Value: CustomerID,
        },

        {
            $Type: 'UI.DataField',
            Value: EmployeeID,
        },
        {
            $Type: 'UI.DataField',
            Value: OrderDate,
        },
        {
            $Type: 'UI.DataField',
            Value: RequiredDate,
        },
        {
            $Type: 'UI.DataField',
            Value: ShippedDate,
        },
        {
            $Type: 'UI.DataField',
            Value: ShipVia,
        },
        {
            $Type: 'UI.DataField',
            Value: Freight,
        },
        {
            $Type: 'UI.DataField',
            Value: ShipName,
        },
        {
            $Type: 'UI.DataField',
            Value: ShipAddress,
        },
        {
            $Type: 'UI.DataField',
            Value: ShipCity,
        },
        {
            $Type: 'UI.DataField',
            Value: ShipRegion,
        },
        {
            $Type: 'UI.DataField',
            Value: ShipPostalCode,
        },
        {
            $Type: 'UI.DataField',
            Value: ShipCountry,
        },
        {
            $Type: 'UI.DataField',
            Value: TotalOrder,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Currency Code',
            Value: Currency_code,
        },
        {
            $Type      : 'UI.DataField',
            Label      : 'Order Status',
            Value      : OrderStatus,
            Criticality: criticality
        },
    ],
    UI.FieldGroup #GeneratedGroup           : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: OrderID,
            },
            {
                $Type: 'UI.DataField',
                Value: CustomerID,
            },
            {
                $Type: 'UI.DataField',
                Value: EmployeeID,
            },
            {
                $Type: 'UI.DataField',
                Value: OrderDate,
            },
            {
                $Type: 'UI.DataField',
                Value: RequiredDate,
            },
            {
                $Type: 'UI.DataField',
                Value: ShippedDate,
            },
            {
                $Type: 'UI.DataField',
                Value: ShipVia,
            },
            {
                $Type: 'UI.DataField',
                Value: Freight,
            },
            {
                $Type: 'UI.DataField',
                Value: ShipName,
            },
            {
                $Type: 'UI.DataField',
                Value: ShipAddress,
            },
            {
                $Type: 'UI.DataField',
                Value: ShipCity,
            },
            {
                $Type: 'UI.DataField',
                Value: ShipRegion,
            },
            {
                $Type: 'UI.DataField',
                Value: ShipPostalCode,
            },
            {
                $Type: 'UI.DataField',
                Value: ShipCountry,
            },
            {
                $Type: 'UI.DataField',
                Value: TotalOrder,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Currency Code',
                Value: Currency_code,
            },
        ],
    },
    UI.Facets                               : [
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     ID    : 'GeneratedFacet1',
        //     Label : 'General Information',
        //     Target: '@UI.FieldGroup#GeneratedGroup',
        // },

        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            Target: '@UI.Identification'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Order Items',
            Target: 'Order_Details/@UI.LineItem'
        },

    ],
    UI.LineItem                             : [
        {
            $Type             : 'UI.DataFieldForAction',
            Action            : 'NWCopyService.placeOrder',
            Label             : 'Place Order',
            IconUrl           : 'sap-icon://cart-approval',
            InvocationGrouping: #Isolated,
           // ![@UI.Hidden] : orderPlaceVisible
        
        },
        {
            $Type  : 'UI.DataFieldForAction',
            Action : 'NWCopyService.cancelOrder',
            Label  : 'Cancel Order',
            IconUrl: 'sap-icon://cart-approval',
              ![@UI.Hidden] : orderCancelVisible

        },
        {
            $Type  : 'UI.DataFieldForAction',
            Action : 'NWCopyService.orderDelivered',
            Label  : 'Order Delivered',
            IconUrl: 'sap-icon://cart-approval',
              ![@UI.Hidden] : orderDeliveredVisible

        },

        {
            $Type             : 'UI.DataField',
            Value             : OrderID,
            @HTML5.CssDefaults: {width: '10rem'} // Set the desired width

        },
        {
            $Type             : 'UI.DataField',
            Value             : CustomerID,
            @HTML5.CssDefaults: {width: '10rem'} // Set the desired width

        },
        {
            $Type: 'UI.DataField',
            Value: OrderDate,
        },
        {
            $Type: 'UI.DataField',
            Value: RequiredDate,
        },
        {
            $Type             : 'UI.DataField',
            Value             : ShipCountry,
            @HTML5.CssDefaults: {width: '10rem'} // Set the desired width
        },
        {
            $Type: 'UI.DataField',
            Value: TotalOrder,
        },
        {
            $Type: 'UI.DataField',
            Value: modifiedAt,
        },

        {
            $Type             : 'UI.DataField',
            Value             : OrderStatus,
            Criticality       : criticality,
            @HTML5.CssDefaults: {width: '10rem'} // Set the desired width
        },
    ],
);

// annotate service.Orders.Order_Details with @(
//     );
annotate service.Orders.Order_Details with @(
    Common.SideEffects #ItemChanged: {
        SourceProperties: [
            'ProductID',
            'Discount'
        ],
        TargetProperties: ['Total']
    },

    UI.HeaderInfo                  : {
        TypeName      : 'Order Item',
        TypeNamePlural: 'Order Items',
        Title         : {
            Label: 'Item No. ',
            //A label is possible but it is not considered on the ObjectPage yet
            Value: ItemNumber
        },
        Description   : {Value: ProductID}
    },
    UI.FieldGroup #GeneratedGroup  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: ItemNumber,
            },
            {
                $Type: 'UI.DataField',
                Value: ProductID,
            },
            {
                $Type: 'UI.DataField',
                Value: UnitPrice,
            },
            {
                $Type: 'UI.DataField',
                Value: Quantity,
            },

            {
                $Type: 'UI.DataField',
                Value: Discount,
            },
            {
                $Type             : 'UI.DataField',
                Label             : 'Currency Code',
                Value             : Currency_code,
                @HTML5.CssDefaults: {width: '10rem'} // Set the desired width
            },
            {
                $Type             : 'UI.DataField',
                Label             : 'Total',
                Value             : Total,
                @HTML5.CssDefaults: {width: '10rem'} // Set the desired width
            },
        ],
    },
    UI.Identification              : [ //Is the main field group
        {Value: ItemNumber},
        {Value: ProductID},

        {Value: Quantity},
        {Value: UnitPrice},
        {Value: Discount},

        {
            $Type             : 'UI.DataField',
            Label             : 'Currency Code',
            Value             : Currency_code,
            @HTML5.CssDefaults: {width: '10rem'} // Set the desired width
        },
        {
            $Type             : 'UI.DataField',
            Label             : 'Total',
            Value             : Total,
            @HTML5.CssDefaults: {width: '10rem'} // Set the desired width
        },
    ],
    UI.Facets                      : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.Identification',
    }

    ],
    UI.LineItem                    : [
        {
            $Type: 'UI.DataField',
            Value: ItemNumber,
        },
        {
            $Type: 'UI.DataField',
            Value: ProductID,
        },
         {
            $Type: 'UI.DataField',
            Value: UnitPrice,
        },
        {
            $Type: 'UI.DataField',
            Value: UnitPrice,
        },
        {
            $Type: 'UI.DataField',
            Value: Quantity,
        },

        {
            $Type: 'UI.DataField',
            Value: Discount,
        },
        {
            $Type             : 'UI.DataField',
            Label             : 'Currency Code',
            Value             : Currency_code,
            @HTML5.CssDefaults: {width: '10rem'}
        },
        {
            $Type             : 'UI.DataField',
            Label             : 'Total',
            Value             : Total,
            @HTML5.CssDefaults: {width: '10rem'}
        },
    ],
);

annotate service.Orders with {
    ShipVia    @Common.ValueListWithFixedValues: true  @Common.ValueList: {
        CollectionPath: 'Shippers',
        Label         : 'Shipper',
        SearchSupported,
        FetchValues   : 2,
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: ShipVia,
                ValueListProperty: 'ShipperID',
                ![@UI.Importance]: #High,
            },

            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'CompanyName',
                ![@UI.Importance]: #High,
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Phone'
            }
        ]
    };
    EmployeeID @Common.ValueList: {
        CollectionPath: 'Employees',
        Label         : 'Employees',
        SearchSupported,
        FetchValues   : 2,
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: EmployeeID,
                ValueListProperty: 'EmployeeID',
                ![@UI.Importance]: #High,
            },

            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'FirstName',
                ![@UI.Importance]: #High,
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'LastName'
            }
        ]
    };
    CustomerID @Common.ValueList: {
        CollectionPath: 'Customers',
        Label         : 'Customers',

        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: CustomerID,
                ValueListProperty: 'CustomerID',
                ![@UI.Importance]: #High,
            },

            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'CompanyName',
                ![@UI.Importance]: #High,
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Phone'
            }
        ]
    };
};

annotate service.Orders.Order_Details with {
    ProductID @Common.ValueList: {
        CollectionPath: 'Products',
        Label         : 'Products',

        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: ProductID,
                ValueListProperty: 'ProductID',
                ![@UI.Importance]: #High,
            },

            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'ProductName',
                ![@UI.Importance]: #High,
            },

            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: UnitPrice,
                ValueListProperty: 'UnitPrice'
            },
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: Currency_code,
                ValueListProperty: 'Currency_code',

            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'UnitsInStock'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Discontinued'
            }
        ]
    };
};
