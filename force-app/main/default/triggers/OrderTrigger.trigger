trigger OrderTrigger on Order (before update, after update, after insert, after delete) {

    /**
     * Trigger handler methods for Order object.
     * It checks if an order has an order item and performs actions based on trigger events.
     * 
     * @return void
     */
    
    // Check if order has an order item
    if(Trigger.isUpdate) {
        if(Trigger.isBefore) {
            OrderTriggerHandler.checkOrderHasAnOrderItem(Trigger.new);
            OrderTriggerHandler.activateAccountField(Trigger.new);
        }
        if(Trigger.isAfter) {
            OrderTriggerHandler.disableAccountField(Trigger.old);
        }
    }
    /**
     * Trigger handler method to activate Account.Active_c field.
     * It is executed when new Order records are inserted.
     * 
     * @return void
     */

    // Activate Account.Active_c 
    if(Trigger.isInsert) {
        OrderTriggerHandler.activateAccountField(Trigger.new);
    }
    /**
     * Trigger handler method to deactivate Account.Active_c field.
     * It is executed when existing Order records are deleted.
     * 
     * @return void
     */

    // Deactivate Account.Active_c if there are no more related Order
    if(Trigger.isDelete) {
        OrderTriggerHandler.disableAccountField(Trigger.old);
    }

}