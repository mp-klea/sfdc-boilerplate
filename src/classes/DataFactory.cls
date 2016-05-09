public abstract class DataFactory {

	private Schema.DescribeSObjectResult dsr;
	private sObjectType objectType;
    private static SObject defaultInstance;
    
    public DataFactory(SObjectType objectType) {
        this.objectType = objectType;
        this.dsr = objectType.getDescribe();
    }
	
	public SObject getDefault() {
		if (defaultInstance == null) {
			defaultInstance = create();
		}
		return defaultInstance;
	}
    
    abstract SObject build();
    
	SObject create() {
        SObject item = build();
        insert item;
        return item;
    }
    

}