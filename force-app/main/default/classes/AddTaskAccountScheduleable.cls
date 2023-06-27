global with sharing class AddTaskAccountScheduleable implements Schedulable {
    /**
    * Method executed when the scheduled job is run.
    * It executes the batch job to add tasks to accounts.
    * 
    * @param ctx => SchedulableContext object containing information about the scheduled job
    * @return void
    */
    global void execute(SchedulableContext ctx) {
        AddTaskAccountBatch accountsBatch = new AddTaskAccountBatch ();
        Database.executeBatch(accountsBatch);
    }
}