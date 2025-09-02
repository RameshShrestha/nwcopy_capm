using {
    Currency,
    managed,
    cuid,
} from '@sap/cds/common';

namespace nwcopy;

entity Orders : cuid, managed {
    OrderID        : Int32    @title: 'Order Number' @readonly; //> readable key
    CustomerID     : String   @title: 'Customer ID';
    _Customers  : Association to Customers on _Customers.CustomerID = CustomerID;
    EmployeeID     : Integer  @title: 'Employee ID';
    EmployeeDetail : Association to Employee on EmployeeDetail.EmployeeID = EmployeeID;
    @Common.FieldControl: #ReadOnly
    OrderDate      : Date     @title: 'Order Date';
    RequiredDate   : Date     @title: 'Required Date';
    ShippedDate    : Date     @title: 'Shipped Date';
    ShipVia        : Int16    @title: 'Ship Via';
    Freight        : Decimal  @title: 'Freigth' @Measures.ISOCurrency : Currency_code;
    
    ShipName       : String   @title: 'Ship Name';
    ShipAddress    : String   @title: 'Ship Address' @UI.MultiLineText;
    ShipCity       : String   @title: 'Ship City';
    ShipRegion     : String   @title: 'Ship Region';
    ShipPostalCode : String   @title: 'Ship Postal Code';
    ShipCountry    : String   @title: 'Ship Country';
    virtual orderPlaceVisible : Boolean ;
     virtual orderCancelVisible : Boolean ;
     virtual orderDeliveredVisible : Boolean;
     virtual editable : Boolean;
     virtual deletable : Boolean;
    @Common.FieldControl: #ReadOnly
    TotalOrder     : Decimal  @title: 'Total Order Price' @Measures.ISOCurrency : Currency_code;
    @Common.FieldControl: #ReadOnly
    OrderStatus    : String   @title: 'Order Status';
    criticality    : Integer default 1  @title: 'Criticality Indicator';
    Currency       : Currency @title: 'Currency Code';
    Order_Details  : Composition of many {
                         key ID            : UUID     @(Core.Computed: true);
                             ItemNumber    : Int32    @title         : 'Item Number' @readonly;
                             ProductID     : Int32    @title         : 'Product ID';

                           
                             UnitPrice     : Decimal  @title: 'Unit Price' @Measures.ISOCurrency : Currency_code @readonly;

                           
                             Currency      : Currency @title: 'Currency Code' @readonly;
                             Quantity      : Int16    @title         : 'Quantity' @assert.range: [(0),_];
                             Discount      : Int16    @title         : 'Discount (%)' @assert.range: [0,100] ;
                             Total : Decimal @title: 'Total' @readonly  @Measures.ISOCurrency : Currency_code;
                             ProductDetail : Association to one Products
                                                 on ProductDetail.ProductID = ProductID;

                     };
    Shipper        : Association to Shipper
                         on Shipper.ShipperID = ShipVia;


}
@cds.persistence.skip
entity OrderStatusVH {
 key status: String enum { Initial = 'Initial'; Ordered = 'Ordered';Cancelled = 'Cancelled'; Delivered='Delivered'}
}

// entity Status : CodeList {
//     key code        : String enum {
//             initial = 'N';
//             ordered = 'O';
//             delivered = 'D';
//             cancelled = 'C';
//         };
//         criticality : Integer;
// }

/** This is a stand-in for arbitrary ordered Products */
entity Products {
    key ProductID       : Int32    @title: 'Product ID';
        ProductName     : String   @title: 'Product Name';
        SupplierID      : Int32    @title: 'Supplier ID';
        CategoryID      : Int32    @title: 'Category ID';
        QuantityPerUnit : String   @title: 'Quantity Per Unit';
        UnitPrice       : Decimal  @title: 'Unit Price';
        Currency        : Currency @title: 'Currency';
        UnitsInStock    : Int16    @title: 'Units In Stock';
        UnitsOnOrder    : Int16    @title: 'Units In Order';
        ReorderLevel    : Int16    @title: 'Reorder Level';
        Discontinued    : Boolean  @title: 'Discountinued';

}

entity Employee : cuid, managed {
    key EmployeeID      : Integer @title: 'Employee ID';
        LastName        : String  @title: 'Last Name';
        FirstName       : String  @title: 'First Name';
        Title           : String  @title: 'Title';
        TitleOfCourtesy : String  @title: 'Title of Courtesy';
        BirthDate       : Date    @title: 'Birth Date';
        HireDate        : Date    @title: 'Hire Date';
        Address         : String  @title: 'Address';
        City            : String  @title: 'City';
        Region          : String  @title: 'Region';
        PostalCode      : String  @title: 'Postal Code';
        Country         : String  @title: 'Country';
        HomePhone       : String  @title: 'Home Phone';
        Extension       : String  @title: 'Extension';
        Photo           : Binary  @title: 'Photo';
        Notes           : String  @title: 'Note';
        ReportsTo       : Int32   @title: 'Reports To';
        PhotoPath       : String  @title: 'Photo Path';
        fullName : String  = FirstName || ' ' || LastName ;
        
   
}

entity Customers : cuid, managed {
    key CustomerID   : String @title: 'Customer ID';
        customerName : String @title: 'Customer Name ';

        CompanyName  : String @title: 'Company Name';
        ContactName  : String @title: 'Contact Name';
        ContactTitle : String @title: 'Contact Title';
        Address      : String @title: 'Address';
        City         : String @title: 'City';
        Region       : String @title: 'Region';
        PostalCode   : String @title: 'Postal Code';
        Country      : String @title: 'Country';
        Phone        : String @title: 'Phone';
        Fax          : String @title: 'Fax';
}

entity Shipper : cuid {
    key ShipperID   : Int16  @title: 'Shipper ID';
        CompanyName : String @title: 'Company Name';
        Phone       : String @title: 'Phone';
}

entity Supplier : cuid {
    SupplierID   : Int32  @title: 'Supplier ID';
    CompanyName  : String @title: 'Company Name';
    ContactName  : String @title: 'Contact Name';
    ContactTitle : String @title: 'Contact Title';
    Address      : String @title: 'Address';
    City         : String @title: 'City';
    Region       : String @title: 'Region';
    PostalCode   : String @title: 'PostalCode';
    Country      : String @title: 'Country';
    Phone        : String @title: 'Phone';
    Fax          : String @title: 'Fax';
    HomePage     : String @title: 'Home Page';

}
