@IsTest
public class DataFactoryTest {
    
    @IsTest
    public static void testDefault() {
        AccountDataFactory adf = new AccountDataFactory(Account.SObjectType);
        Account a = (Account) adf.getDefault();
        Account b = (Account) adf.getDefault();
        System.assertEquals(a, b, 'getDefault() should return the same instance');
    }
    
    @IsTest
    public static void testBuild() {
        AccountDataFactory adf = new AccountDataFactory(Account.SObjectType);
        Account a = (Account) adf.build();
        System.assertEquals(null, a.Id, 'build() should not persist in the database');
    }
    
    
}