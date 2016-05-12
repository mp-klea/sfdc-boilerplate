@IsTest
public class DataFactoryTest {
    
    @IsTest
    public static void testDefault() {
        AccountDataFactory adf = new AccountDataFactory(Account.SObjectType);
        Account a = (Account) adf.getDefaultInstance();
        Account b = (Account) adf.getDefaultInstance();
        System.assertEquals(a, b, 'getDefault() should return the same instance');
    }
    
    @IsTest
    public static void testBuild() {
        AccountDataFactory adf = new AccountDataFactory(Account.SObjectType);
        Account a = (Account) adf.build();
        System.assertEquals(null, a.Id, 'build() should not persist in the database');
    }
   	
   	@IsTest
    public static void testDifferentFactories() {
        AccountDataFactory adf = new AccountDataFactory(Account.SObjectType);
        OpportunityDataFactory odf = new OpportunityDataFactory(Opportunity.SObjectType);
        Account a = (Account) adf.getDefaultInstance();
        System.assertEquals(adf.getInstanceCount(), 1, 'Account data factory has created 1 instance');
        System.assertEquals(odf.getInstanceCount(), 0, 'Opportunity data factory has created 1 instance');
    }
    
    
}