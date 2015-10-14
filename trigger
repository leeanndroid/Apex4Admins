trigger NewProjectTrigger on Opportunity (before update) {
    
    for (Opportunity o : Trigger.new){
        
        if(o.StageName == 'Closed Won'){
            
            try{
                
                Milestone1_Project__c[] existingMilestones = [Select Name From Milestone1_Project__c WHERE Opportunity__c = :o.Id];
                
                if(existingMilestones.size() == 0){
                    Milestone1_Project__c newMilestone = new Milestone1_Project__c(Opportunity__c = o.Id, Name = o.Name);
                    Insert newMilestone;
                }

            }catch(Exception e){
                //Error handling would go here
            }    
        }

    }

}
