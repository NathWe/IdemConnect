global with sharing class AddTaskAccountScheduleable implements Schedulable {

    global void execute(SchedulableContext ctx) {
        AddTaskAccountBatch accountsBatch = new AddTaskAccountBatch ();
        Database.executeBatch(accountsBatch);
    }
}