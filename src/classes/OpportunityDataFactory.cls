public with sharing class OpportunityDataFactory extends DataFactory {
	
	AccountDataFactory adf = new AccountDataFactory(Account.SObjectType);
	
	 public OpportunityDataFactory(SObjectType objectType) {
        super(objectType);
    }
    
    public SObject build() {
    	return build((Account) adf.getDefaultInstance());
    }
    
    public SObject build(Account a) {
    	Opportunity o = new Opportunity();
        o.Name = 'My test oppotunity {0}';
        o.Description = 'My test opportunity description {0}';
        o.StageName = 'Open';
        o.CloseDate = System.today().addDays(30);
        o.accountId = a.id;
        return o;
    }
    
}