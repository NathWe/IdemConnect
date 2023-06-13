trigger OrderTrigger on Order (before update, after update, after insert, after delete) {


    // Check if order has an order item
    if(Trigger.isUpdate) {
        if(Trigger.isBefore) {
            OrderTriggerHandler.checkOrderHasOrderItem(Trigger.new);
            OrderTriggerHandler.activateAccountField(Trigger.new);
        }
        if(Trigger.isAfter) {
            OrderTriggerHandler.disableAccountField(Trigger.old);
        }
    }

    // Activate Account.Active_c 
    if(Trigger.isInsert) {
        OrderTriggerHandler.activateAccountField(Trigger.new);
    }

    // Deactivate Account.Active_c if there are no more related Order
    if(Trigger.isDelete) {
        OrderTriggerHandler.disableAccountField(Trigger.old);
    }

}