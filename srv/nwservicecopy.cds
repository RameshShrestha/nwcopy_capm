using {nwcopy} from '../db/schema';

service NWCopyService {
  
    entity Customers as projection on nwcopy.Customers;
 
    entity Employees as projection on nwcopy.Employee;

    entity Orders    as projection on nwcopy.Orders
        actions {
              @Common.SideEffects: {
              TargetEntities: ['_it'], // Refresh related entities
              TargetProperties: ['OrderStatus']// Refresh specific properties
          }
           
             @Core.OperationAvailable : orderPlaceVisible
            action placeOrder(  _it: $self)     returns {
                message : String
            };
                 @Common.SideEffects: {
              TargetEntities: ['_it'], // Refresh related entities
              TargetProperties: ['OrderStatus'] // Refresh specific properties
          }
              @Core.OperationAvailable : orderCancelVisible
            action cancelOrder(  _it: $self)     returns {
                message : String
            };
                 @Common.SideEffects: {
              TargetEntities: ['_it'], // Refresh related entities
              TargetProperties: ['OrderStatus'] // Refresh specific properties
          }
              @Core.OperationAvailable : orderDeliveredVisible
            action orderDelivered(  _it: $self) returns {
                message : String
            };
           

        };


entity Products  as projection on nwcopy.Products;
entity Shippers  as projection on nwcopy.Shipper;
entity Suppliers as projection on nwcopy.Supplier;
entity OrderStatusVH as projection on nwcopy.OrderStatusVH;

annotate Orders with @odata.draft.enabled;
annotate Products with @odata.draft.enabled;
annotate Employees with @odata.draft.enabled;
annotate Customers with @odata.draft.enabled;
annotate Shippers with @odata.draft.enabled;
annotate Suppliers with @odata.draft.enabled;


}
