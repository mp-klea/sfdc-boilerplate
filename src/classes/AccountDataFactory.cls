@IsTest
public class AccountDataFactory extends DataFactory {
    
    public AccountDataFactory(SObjectType objectType) {
        super(objectType);
    }
    
    public SObject build() {
        Account a = new Account();
        a.Name = 'My test account {0}';
        a.Description = '50130000000014C';
        return a;
    }
    
}