const cds = require('@sap/cds');
const e = require('express');
const { handleFieldControls, validateOrder } = require('./Controllers/OrderHandler');
class NWCopyService extends cds.ApplicationService {

  /** register custom handlers */
  init() {
    this.after('READ', 'Orders', each => handleFieldControls(each));
    // this.after('READ', 'Orders', each => {
    //   each.orderPlaceVisible = false;
    //   each.orderCancelVisible = false;
    //   each.orderDeliveredVisible = false;
    //   each.editable = false;
    //   each.deletable = false;
    //   if (each.OrderStatus === "Initial" || each.OrderStatus === "Cancelled") {
    //     each.orderPlaceVisible = true;
    //     each.editable = true;
    //     each.deletable = true;
    //   }
    //   if (each.OrderStatus === "Ordered") {
    //     each.orderCancelVisible = true;
    //     each.orderDeliveredVisible = true;
    //   }
    //   if (each.OrderStatus === "Cancelled") {
    //     each.deletable = true;
    //     each.editable = true;
    //   }

    // });
    // const { 'Orders.Items':OrderItems } = this.entities

    // this.before ('UPDATE', 'Orders', async function(req) {
    //   const { ID, Items } = req.data
    //   if (Items) for (let { product_ID, quantity } of Items) {
    //     const { quantity:before } = await SELECT.one.from (OrderItems, oi => oi.quantity) .where ({up__ID:ID, product_ID})
    //     if (quantity != before) await this.orderChanged (product_ID, quantity-before)
    //   }
    // })


    // this.before ('DELETE', 'Orders', async function(req) {
    //   const { ID } = req.data
    //   const Items = await SELECT.from (OrderItems, oi => { oi.product_ID, oi.quantity }) .where ({up__ID:ID})
    //   if (Items) await Promise.all (Items.map(it => this.orderChanged (it.product_ID, -it.quantity)))
    // })
    //   const {'Orders.Order_Details':Order_Details} = this.entities;
    //    console.log("Entities available ::  ", Order_Details);


    // this.on('UPDATE', 'Orders.drafts', async function (req,next) {
    //     const newOrder = req.data;
    //     console.log("EXecuted here to Update new Order Header Orders.drafts");
    //     console.log("newOrder", newOrder);
    //     await next();
    //     //    if (Order_Details) for (let { product_ID, quantity } of Items) {
    //     //      const { quantity:before } = await SELECT.one.from (OrderItems, oi => oi.quantity) .where ({up__ID:ID, product_ID})
    //     //     if (quantity != before) await this.orderChanged (product_ID, quantity-before)
    //     //   }
    // })
    this.on('UPDATE', 'Orders.Order_Details.drafts', async function (req, next) {
      const newOrder = req.data;
      // console.log("UpdatedOrderItem", newOrder);
      if (req.params[0]) {
        let { ID } = req.params[0];

        const { 'Orders.Order_Details': OrderItems } = this.entities;
        //   const currentItem = await SELECT.one.from(OrderItems.drafts).where({ up__ID: newOrder.up__ID });
        const currentItem = await SELECT.one.from(OrderItems.drafts).where({ ID: ID });
        //   console.log("Current Item", currentItem);
        let quantity = req.data.Quantity || currentItem.Quantity || 0;
        let discount = req.data.Discount || currentItem.Discount || 0;
        let UnitPrice = req.data.UnitPrice || currentItem.UnitPrice || 0;
        let total = UnitPrice * quantity * ((100 - discount) / 100);
        //  console.log("Quantity :", quantity, "Discount : ", discount, "UnitPrice : ", UnitPrice, "Total : ", total);
        newOrder.Total = total;
      }

      //   newOrder.Total = '4234.32';
      //  console.log("EXecuted here to Update new Order Item Order_Details");
      //  console.log("updatedOrder", newOrder);

      await next();

    });
    this.after('UPDATE', 'Orders.Order_Details.drafts', async function (req) {
      const { Orders } = this.entities;
      //  console.log("Current Req", req);
      if (req) {
        let { up__ID } = req;
        const { 'Orders.Order_Details': OrderItems, Orders } = this.entities;
        const currentItems = await SELECT.from(OrderItems.drafts).where({ up__ID: up__ID });

        let totalOrder = 0;
        for (let i = 0; i < currentItems.length; i++) {
          totalOrder = totalOrder + currentItems[i].Total;
        }
        // let updatedOrder = await UPDATE `OrderDraft` .set `TotalOrder = ${totalOrder}` .where `ID=${up__ID}`;
        let udpatedOrder = await UPDATE(Orders.drafts, up__ID).with({
          TotalOrder: totalOrder,       //>  simple value

        });
        //  console.log("udpatedOrder: ", udpatedOrder);
        //  console.log("Current Items list", currentItems);
      }




    });
    this.on('NEW', 'Orders.drafts', async function (req, next) {
      const newOrder = req.data;
      newOrder.criticality = 5;
      newOrder.OrderStatus = "Initial";
      await next();
    });
    this.on('NEW', 'Orders.Order_Details.drafts', async function (req, next) {
      const newOrder = req.data;
      const { 'Orders.Order_Details': OrderItems } = this.entities;
      const existingItems = await SELECT.from(OrderItems.drafts).where({ up__ID: newOrder.up__ID });
      let itemCounter = 1;
      if (existingItems) {
        itemCounter = existingItems.length + 1;
      }
      newOrder.ItemNumber = itemCounter;
      newOrder.Quantity = 0;
      newOrder.Discount = 0;
      newOrder.Total = 0;
      newOrder.Currency_code = 'USD';
      await next();
    });
    // this.on('*', async (req, next) => {
    //   //console.log(`Event received: ${req.event} on entity: ${req.target?.name}`);
    //   //     //     // Add your generic logic here
    //   await next();
    // });

    this.on('placeOrder', async req => {

      //console.log("Request passed", req.params);
      let message = '';
      if (req.params[0]) {
        let { ID } = req.params[0];
        let result = validateOrder(ID);
        const currentOrder = await SELECT.one.from('Orders').where({ ID: ID });
        //console.log(currentOrder);
        if (currentOrder) {
          let currentStatus = currentOrder.OrderStatus;
          if (currentStatus = '' || !currentStatus || currentStatus == 'Initial' || currentStatus == 'Cancelled') {
            let orderItems = await SELECT.one.from('Orders.Order_Details').where({ up__ID: ID });
            //console.log("Order Items to be Ordered", orderItems);
            if (!orderItems || orderItems.length < 0) {
              req.warn("No Order Items available to process the order");
              return;
            }
            let updatedOrder = await UPDATE('Orders', ID).with({
              OrderStatus: 'Ordered',       //>  simple value
              criticality: 2,
              OrderDate: new Date().toISOString().split("T")[0]
            })
            message = 'Order ' + currentOrder.OrderID + ' Ordered Successfully';
            req.notify('Order ' + currentOrder.OrderID + ' Ordered Successfully');
          } else {
            message = 'Order Cannot be Ordered  ';
            req.warn('This Cannot be ordered in current status');
          }
        } else {
          message = 'Order Not found';
          req.warn('This Cannot be ordered');
        }
        //  
      } else {
        console.log("Something went wrong");
      }
      return message;
    });
    this.on('cancelOrder', async req => {
      //console.log("Request passed", req.params);
      let message = '';
      if (req.params[0]) {
        let { ID } = req.params[0];
        const currentOrder = await SELECT.one.from('Orders').where({ ID: ID });
        //console.log(currentOrder);
        if (currentOrder) {
          let currentStatus = currentOrder.OrderStatus;
          if (currentStatus == 'Ordered') {
            //update currentStatus

            //    let updatedOrder = await UPDATE.from ('Orders') .where ({ID:ID});
            // let updatedOrder = await UPDATE `Orders` .set `OrderStatus = 'Ordered'` .where `ID=${ID}`;
            let updatedOrder = await UPDATE('Orders', ID).with({
              OrderStatus: 'Cancelled',       //>  simple value
              criticality: 1,
              OrderDate: ""
            })
            message = 'Order ' + currentOrder.OrderID + ' Cancelled Successfully';
            req.notify('Order ' + currentOrder.OrderID + ' Cancelled Successfully');
          } else {
            message = 'Order Cannot be Cancelled  ';
            req.warn('This Cannot be Cancelled in current status');
          }
        } else {
          message = 'Order Not found';
          req.warn('This Cannot be Cancelled');
        }
        //  
      } else {
        console.log("Something went wrong");
      }
      return message;
    });

    this.on('orderDelivered', async req => {
      //console.log("Request passed", req.params);
      let message = '';
      if (req.params[0]) {
        let { ID } = req.params[0];
        const currentOrder = await SELECT.one.from('Orders').where({ ID: ID });
        //console.log(currentOrder);
        if (currentOrder) {
          let currentStatus = currentOrder.OrderStatus;
          if (currentStatus == 'Ordered') {
            //update currentStatus

            //    let updatedOrder = await UPDATE.from ('Orders') .where ({ID:ID});
            // let updatedOrder = await UPDATE `Orders` .set `OrderStatus = 'Ordered'` .where `ID=${ID}`;
            let updatedOrder = await UPDATE('Orders', ID).with({
              OrderStatus: 'Delivered',       //>  simple value
              criticality: 3,
            })
            message = 'Order ' + currentOrder.OrderID + ' Delivered Successfully';
            req.notify('Order ' + currentOrder.OrderID + ' Delivered Successfully');
          } else {
            message = 'Order Cannot be Delivered  ';
            req.warn('This Cannot be Delivered in current status');
          }
        } else {
          message = 'Order Not found';
          req.warn('This Cannot be Cancelled');
        }
        //  
      } else {
        console.log("Something went wrong");
      }
      return message;
    });

    return super.init()
  }

  /** order changed -> broadcast event */
  //   orderChanged (product, deltaQuantity) {
  //     // Emit events to inform subscribers about changes in orders
  //     console.log ('> emitting:', 'OrderChanged', { product, deltaQuantity }) // eslint-disable-line no-console
  //     return this.emit ('OrderChanged', { product, deltaQuantity })
  //   }

}
module.exports = NWCopyService