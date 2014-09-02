public class TestNewProj2 {
static testMethod void myTest2() {
	
	//test when there is a project connected to the Opportunity
	Account a = new Account(Name = 'Test');
	insert a;
	Opportunity o = new Opportunity(AccountId = a.Id, Name = 'Test', StageName = 'Prospecting', CloseDate = Date.newInstance(2007,10,10));	
	insert o;
	SFL5_Projects__c p = new SFL5_Projects__c(Client__c = a.Id, Name = 'Test', Opportunity__c = o.Id);
	insert p;
	o.StageName = 'Prospecting';
	update o;
	
	//now when there IS no project connected to the Opportunity
	Account a2 = new Account(Name = 'Test');
	insert a2;
	Opportunity o2 = new Opportunity(AccountId = a2.Id, Name = 'Test', StageName = 'Prospecting', CloseDate = Date.newInstance(2007,10,10));	
	insert o2;
	SFL5_Projects__c p2 = new SFL5_Projects__c(Client__c = a.Id, Name = 'Test');
	insert p2;
	o2.StageName = 'Closed Won';
	update o2;
}
}

trigger NewProj2 on Opportunity (before update) {
for (Opportunity o : Trigger.new)
{
	if(o.StageName == 'Closed Won')
	{
		try
		{
				SFL5_Projects__c[] proj = [Select Name From SFL5_Projects__c
						WHERE Opportunity__c = :o.Id];
				Integer i = 0;
				for(SFL5_Projects__c p1:proj)
				{
					i++;
				}
				if(i == 0)
				{
					SFL5_Projects__c p2 = new SFL5_Projects__c(Client__c = o.AccountId, Opportunity__c = o.Id, Name = o.Name);
					Insert p2;
				}
		}
		catch(Exception e){}	
	}
}
}
