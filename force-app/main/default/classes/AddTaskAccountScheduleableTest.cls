@IsTest
public with sharing class AddTaskAccountScheduleableTest {
    /**
     * Test method to validate the scheduling of the AddTaskAccountScheduleable.
     * It verifies that the scheduled job is created with the correct cron expression and initial TimesTriggered value.
     * 
     * @return void
     */
    @isTest
    public static void addAccountScheduleableTest() {

        Test.startTest();
        // Execution du schedulable dans 1 minute
        String cronExp = '0 0 0/1 * * ?';
        String jobId = System.schedule('add task to account', cronExp, new AddTaskAccountScheduleable());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobId];
        Test.stopTest();
        System.assertEquals(cronExp, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
}