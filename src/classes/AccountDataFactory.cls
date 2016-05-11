//@IsTest
public class AccountDataFactory extends DataFactory {
    
    public AccountDataFactory(SObjectType objectType) {
        super(objectType);
    }
    
    public SObject build() {
        Account a = new Account();
        a.Name = 'My test account {0}';
        a.Description = 'My test account description {0}';
        return a;
    }
    
}