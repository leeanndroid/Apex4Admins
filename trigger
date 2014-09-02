trigger NewProjectTrigger on Opportunity (before update) {
for (Opportunity o : Trigger.new)
{
    if(o.StageName == 'Closed Won')
    {
        try
        {
                Milestone1_Project__c[] proj = [Select Name From Milestone1_Project__c
                        WHERE Opportunity__c = :o.Id];
                Integer i = 0;
                for(Milestone1_Project__c p1:proj)
                {
                    i++;
                }
                if(i == 0) //instead of all of this, you could just do proj[0]
                //but why only operate on this one?  Why not all the projects?
                {
                    Milestone1_Project__c p2 = new Milestone1_Project__c(Opportunity__c = o.Id, Name = o.Name);
                    Insert p2;
                }
        }
        catch(Exception e){}    
    }
}
}
