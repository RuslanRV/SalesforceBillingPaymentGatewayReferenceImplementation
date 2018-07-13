global class PostInstallClass implements InstallHandler
{
	private InstallContext installContext;
    global void onInstall(InstallContext context)
    {
    	InsertBillingConfigCustomSettings();
        InsertPaymentGatewayConfigCustomSettings();
    }

    public void InsertBillingConfigCustomSettings()
    {
    	List<blng__BillingConfig__c> listofConfiguration = new List<blng__BillingConfig__c>();
    	blng__BillingConfig__c invoiceDetail = new blng__BillingConfig__c(Name = 'INVOICE_DETAIL', 
                                                                   blng__StringValue__c = '', 
                                                                   blng__FieldType__c = '', 
                                                                   blng__Description__c = '',
                                                                   blng__PicklistIndicator__c ='',
                                                                   blng__Category__c ='Payment',
                                                                   blng__Sequence__c = 9,
                                                                   blng__BooleanValue__c = false);
    	listofConfiguration.add(invoiceDetail);
    	blng__BillingConfig__c invoiceLineDetail = new blng__BillingConfig__c(Name = 'INVOICE_LINE_DETAIL', 
                                                                   blng__StringValue__c = '', 
                                                                   blng__FieldType__c = '', 
                                                                   blng__Description__c = '',
                                                                   blng__PicklistIndicator__c ='',
                                                                   blng__Category__c ='Payment',
                                                                   blng__Sequence__c = 9,
                                                                   blng__BooleanValue__c = false);
    	listofConfiguration.add(invoiceLineDetail);


    	 //construct a map to hold settings
        map<string,blng__BillingConfig__c> mapOfBillingConfigurationByName = new map<string,blng__BillingConfig__c>();
        
        // iterate the list to add it map
        for(blng__BillingConfig__c billingConfig : listofConfiguration)
        {
          mapOfBillingConfigurationByName.put(billingConfig.name,billingConfig);
        }
        // get the all custom settings to check whether system has already settings or not.
        map<string,blng__BillingConfig__c> mapOfBillingConfigurationValues = blng__BillingConfig__c.getAll();
        // if system has settings then do not touch the existing settings
        for(string sBillingConfigName :  mapOfBillingConfigurationValues.keyset())
        {
            if(mapOfBillingConfigurationByName.containskey(sBillingConfigName))
            {
                mapOfBillingConfigurationByName.remove(sBillingConfigName);
            }
        }

    	// Register new to insert
    	if(mapOfBillingConfigurationByName.size() > 0)
    	{
    		Insert mapOfBillingConfigurationByName.values();
    	}   
    }

    /**
    * @name InsertPaymentGatewayConfigCustomSettings
    * @description creates a payment gateway config record which is basically has the API class name for a gateway
    * @Param NA
    * @return NA
    * @exception NA
    * @author Lopa M
    * @created 2018-07-12
    * @remark
    * @change
    */
    public void InsertPaymentGatewayConfigCustomSettings()
    {
        String gatewayName = 'CyberSource';
        List<blng__PaymentGatewayConfig__c> listofConfiguration = new List<blng__PaymentGatewayConfig__c>();
        blng__PaymentGatewayConfig__c gateway = new blng__PaymentGatewayConfig__c(
                Name = gatewayName,
                blng__ClassName__c = CyberSource.class.getName().substringBefore(gatewayName) + gatewayName + 'API');
        listofConfiguration.add(gateway);

        // get the all custom settings to check whether system has already settings or not
        map<String, blng__PaymentGatewayConfig__c> mapOfConfigurationValues = blng__PaymentGatewayConfig__c.getAll();
        // if system does not have the gateway, then insert it
        if(!mapOfConfigurationValues.containskey(gatewayName)) {
            insert listofConfiguration;
        }
    }

}