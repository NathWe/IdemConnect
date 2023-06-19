@IsTest
public with sharing class AddTaskAccountScheduleableTest {

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