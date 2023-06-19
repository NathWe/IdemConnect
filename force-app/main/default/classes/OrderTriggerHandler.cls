public with sharing class OrderTriggerHandler {

    /**
     * Method that throws an error message if the user tries to update the status of an order to "Activated" without associated products
     * 
     * @param ordersList => List<Order> Trigger.New orders
     * @return void
     */
    public static void checkOrderHasAnOrderItem(List<Order> ordersList) {
        Set<Id> orderWithAllItemIds = new Set<Id>();
        List<Order> orderListActivated = new List<Order>();
    
        for (Order ordr : ordersList) {
            if (ordr.Status == 'Activated') {
                orderListActivated.add(ordr);
            }
        }
    
        for (OrderItem oi : [SELECT Id, OrderId FROM OrderItem WHERE OrderId IN :orderListActivated]) {
            orderWithAllItemIds.add(oi.OrderId);
        }
    
        for (Order ordr : orderListActivated) {
            if (!orderWithAllItemIds.contains(ordr.Id)) {
                ordr.addError('Please add a product to your order before changing the status');
            }
        }
    }


    public static void activateAccountField(List<Order> ordersList) {
        Set<Id> orderAccountIdSet = new Set<Id>();
        List<Account> accountsToUpdateList= new List<Account>();

        // Get all related AccountId
        for (Order ordr : ordersList) {
            orderAccountIdSet.add(ordr.AccountId);
        }

        // Modify all accounts with at least one order and set the Active__c field to true
        for (Account acc : [SELECT Id, Active__c FROM Account WHERE Id IN :orderAccountIdSet]) {
            acc.Active__c = true;
            accountsToUpdateList.add(acc);
        }

        update accountsToUpdateList;
    }


    public static void disableAccountField(List<Order> ordersList) {
        Set<Id> orderAccountIdSet = new Set<Id>();
        List<Account> accountsToUpdateList= new List<Account>();
    
        // Get all related AccountId
        for (Order ordr : ordersList) {
            orderAccountIdSet.add(ordr.AccountId);
        }
    
        // Modify accounts that had at least one order and set Active__c field to false if acc.Orders is empty
        for (Account acc : [SELECT Id, Active__c, (SELECT Id FROM Orders) FROM Account WHERE Id IN :orderAccountIdSet]) {
            if (acc.Orders.isEmpty()) {
                acc.Active__c = false;
                accountsToUpdateList.add(acc);
            }
        }
    
        update accountsToUpdateList;
    }
}