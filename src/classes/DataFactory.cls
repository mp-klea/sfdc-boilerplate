public abstract class DataFactory {

	private Set<SObjectField> fieldsToReplace = new Set<SObjectField>();
	private sObjectType objectType;
    private static SObject defaultInstance;
    
    public DataFactory(SObjectType objectType) {
        this.objectType = objectType;
        
        init();
    }
    
    private void init() {
    	Schema.DescribeSObjectResult dsr = objectType.getDescribe();
    	Map<String, Schema.SObjectField> fieldMap = dsr.fields.getMap();
        Integer i = 1;
        for (String fieldName : fieldMap.keySet()){
   			SObjectField sField = fieldMap.get(fieldName);
            Schema.DescribeFieldResult dField = sField.getDescribe();
            Schema.DisplayType fldType = dField.getType();            
            if (Schema.DisplayType.STRING.equals(fldType) || Schema.DisplayType.TextArea.equals(fldType)) {
            	fieldsToReplace.add(sField);
            }
        }
    }
    
    private void prePopulate(SObject item) {
    	prePopulate(new List<SObject> {item});
    }
    
    private void prePopulate(List<SObject> items) {    	
        Integer i = 1;
        for (SObject item : items) {
	        for (Schema.SObjectField sField : fieldsToReplace) {
	        	String value = (String) item.get(sField);
	        	if (value!=null) {
	        		List<String> fillers = new List<String> { String.valueOf(i) };
					String formatted = String.format(value, fillers);
					item.put(sField, formatted);
	        	}
			}
			i++;
        }
    }
	
	public SObject getDefault() {
		if (defaultInstance == null) {
			defaultInstance = create();
		}
		return defaultInstance;
	}
    
    abstract SObject build();
    
	public SObject create() {
        SObject item = build();
        prePopulate(item);
        insert item;
        return item;
    }
    

}