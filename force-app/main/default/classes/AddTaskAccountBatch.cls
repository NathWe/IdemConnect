global with sharing class AddTaskAccountBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext context) {
        // Return Accounts that are not Activated (that don't have an Order), and check if there is a related Task with Subject == Call
        return Database.getQueryLocator(
            [SELECT Id, OwnerId, 
            (SELECT Id FROM Tasks WHERE Subject = 'Call' LIMIT 1) 
             FROM Account WHERE Active__c = false]
            );
    }

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

    global void finish(Database.BatchableContext context) {
        // No finish
    }
}