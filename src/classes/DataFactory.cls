public abstract class DataFactory {

	private static Set<SObjectField> fieldsToPatch = new Set<SObjectField>();
	private static sObjectType objectType;
    private static SObject defaultInstance;
    private Integer countInstances = 0;
    
    public DataFactory(SObjectType anObjectType) {
        objectType = anObjectType;        
        init();
    }
    
    private void init() {
    	Schema.DescribeSObjectResult dsr = objectType.getDescribe();
    	Map<String, Schema.SObjectField> fieldMap = dsr.fields.getMap();
        for (String fieldName : fieldMap.keySet()){
   			SObjectField sField = fieldMap.get(fieldName);
            Schema.DescribeFieldResult dField = sField.getDescribe();
            Schema.DisplayType fldType = dField.getType();            
            if (Schema.DisplayType.STRING.equals(fldType) || Schema.DisplayType.TextArea.equals(fldType)) {
            	fieldsToPatch.add(sField);
            }
        }
    }
    
    private void prePopulate(SObject item) {    	
        Integer i = 0;
        for (Schema.SObjectField sField : fieldsToPatch) {
        	String value = (String) item.get(sField);
        	if (value!=null) {
        		List<String> fillers = new List<String> { String.valueOf(countInstances + i) };
				String formatted = String.format(value, fillers);
				item.put(sField, formatted);
        	}
		}
		i++;
    }
	
	public SObject getDefaultInstance() {
		if (defaultInstance == null) {
			defaultInstance = create();
		}
		return defaultInstance;
	}
    
    abstract SObject build();
    
	public SObject create() {
        SObject item = build();
        countInstances++;
        prePopulate(item);
        insert item;
        return item;
    }
    
    public Integer getInstanceCount() {
    	return countInstances;
    }
    

}