const cds = require('@sap/cds');
function handleFieldControls(each) {
      each.orderPlaceVisible = false;
      each.orderCancelVisible = false;
      each.orderDeliveredVisible = false;
      each.editable = false;
      each.deletable = false;
      if (each.OrderStatus === "Initial" || each.OrderStatus === "Cancelled") {
        each.orderPlaceVisible = true;
        each.editable = true;
        each.deletable = true;
      }
      if (each.OrderStatus === "Ordered") {
        each.orderCancelVisible = true;
        each.orderDeliveredVisible = true;
      }
      if (each.OrderStatus === "Cancelled") {
        each.deletable = true;
        each.editable = true;
      }

    }
    function validateOrder (ID){
        return ({message:"Successful"});
    }
    module.exports = { handleFieldControls,validateOrder };