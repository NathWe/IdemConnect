global with sharing class AddTaskAccountBatch implements Database.Batchable<SObject> {
    /**
     * Method that returns the query locator for selecting accounts that are not activated and have a related task with the subject "Call".
     *
     * @param context The batchable context
     * @return Database.QueryLocator representing the accounts to be processed in the batch
     */
    global Database.QueryLocator start(Database.BatchableContext context) {
        // Return Accounts that are not Activated (that don't have an Order), and check if there is a related Task with Subject == Call
        return Database.getQueryLocator(
            [SELECT Id, OwnerId, 
            (SELECT Id FROM Tasks WHERE Subject = 'Call' LIMIT 1) 
             FROM Account WHERE Active__c = false]
            );
    }
    /**
     * Method that performs the batch processing logic for the current batch scope.
     *
     * @param context The batchable context
     * @param scope The list of accounts to be processed in the batch
     */
    global void execute(Database.BatchableContext context, List<Account> scope) {
        // Logique d'exécution du traitement par lots pour le lot actuel (scope)
        List<Task> tastList = new List<Task>();

        for (Account acc : scope) {
            if(acc.Tasks.size() == 0) {
                Task tsk = new Task(
                    OwnerId = acc.OwnerId,
                    WhatId = acc.Id,
                    Subject = 'Call',
                    Status = 'New',
                    Priority = 'Normal',
                    IsReminderSet = true,
                    ReminderDateTime = System.now() + 5
                );
                tastList.add(tsk);
            }
        }
        insert tastList;
    }
    /**
     * Method that performs any finishing operations after the batch processing is complete.
     *
     * @param context The batchable context
     */
    global void finish(Database.BatchableContext context) {
        // No finish
    }
}