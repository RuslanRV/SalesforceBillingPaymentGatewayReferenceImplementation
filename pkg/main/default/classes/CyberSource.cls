// ============================================================================================= 
//  Object: CyberSource 
//  Company: Salesforce
//  Author: Himanshu Kapoor/ Vinod KR/ Devender / Manigandan SA
//  Purpose: This class is for all the functionality of CyberSource payment gateway
//  Methods: Following are the methods and one line description
//              
//  Created: 2016-07-14
// ============================================================================================= 
//  Use Cases or Requirements: 
//  @UseCase number - @requirement Description      
// ============================================================================================= 
//  Changes: @Date Author
//           @Description
// ============================================================================================= 
public class CyberSource
{
    // 
    // ============================================================================
    // CONSTANT 
    // ============================================================================
        // CyberSource Endpoint URL Sandbox
        private static final String CYBER_SOURCE_ENDPOINT_URL_SANDBOX = 'https://ics2wstesta.ic3.com/commerce/1.x/transactionProcessor/';

        // CyberSource Endpoint URL Production
        private static final String CYBER_SOURCE_ENDPOINT_URL_PRODUCTION = 'https://ics2wsa.ic3.com/commerce/1.x/transactionProcessor/';

        private static final String ACCEPT = 'ACCEPT';
        private static final String REJECT = 'REJECT';
        private static final String PENDING = 'PENDING';
        private static final String SUCCESS = 'SUCCESS';
        private static final String FAILURE = 'FAILURE';
        private static final String DECISION = 'decision';
    	private static final String EMAIL_MISSING = 'Email is Missing';
        private static final String SUBSCRIPTIONID = 'subscriptionID';
        private static final String REASONCODE = 'reasonCode';
        private static final String REQUEST_ID = 'requestID';
        private static final String INVALID_FIELD = 'invalidField';
        private static final String PAYMENTTYPE_CREDITCARD = 'Credit Card';
        private static final String PAYMENTTYPE_ACH = 'ACH';
        public static String TEST_REQUEST_BODY_CYBER_SOURCE = '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Header><wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"><wsu:Timestamp xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" wsu:Id="Timestamp-501816472"><wsu:Created>2015-09-28T07:46:09.286Z</wsu:Created></wsu:Timestamp></wsse:Security></soap:Header><soap:Body><c:replyMessage xmlns:c="urn:schemas-cybersource-com:transaction-data-1.115"><c:merchantReferenceCode>acertiscloud_23</c:merchantReferenceCode><c:requestID>4436893298465000001516</c:requestID><c:decision>ACCEPT</c:decision><c:reasonCode>100</c:reasonCode><c:invalidField>Invalid Field X</c:invalidField><c:subscriptionID>123456</c:subscriptionID><c:requestToken>Ahj//wSR4QyHBpJLFB/YIkGLdq1auG7adFqsbNmRST+D2l0cU2T+D2l0cXSBs4NSahk0ky3SA7msQMJEjwhkODSSWKD+wAAASgCk</c:requestToken><c:purchaseTotals><c:currency>USD</c:currency></c:purchaseTotals><c:ccAuthReply><c:reasonCode>100</c:reasonCode><c:amount>49.95</c:amount><c:authorizationCode>888888</c:authorizationCode><c:avsCode>X</c:avsCode><c:avsCodeRaw>I1</c:avsCodeRaw><c:authorizedDateTime>2015-10-01T08:48:50Z</c:authorizedDateTime><c:processorResponse>100</c:processorResponse><c:reconciliationID>17555876NEU1YYHR</c:reconciliationID></c:ccAuthReply><c:ccCaptureReply><c:reasonCode>100</c:reasonCode><c:requestDateTime>2015-10-01T08:48:50Z</c:requestDateTime><c:amount>49.95</c:amount><c:reconciliationID>17555876NEU1YYHR</c:reconciliationID></c:ccCaptureReply></c:replyMessage></soap:Body></soap:Envelope>';
        private static final String GENERATE_TOKEN = 'generateToken ';
        private static final String POPULATE_GENERATE_TOKEN = 'populateTransactionResultForToken ';
        private static final String AUTHORIZE_TRANSACTION = 'authorizeTransaction ';
        private static final String POPULATE_AUTHORIZE_TRANSACTION = 'populateTransactionResultForAuthorize ';
        private static final String CHARGE_TRANSACTION = 'chargeTransaction ';
        private static final String POPULATE_CHARGE_TRANSACTION = 'populateTransactionResultForCharge ';
        private static final String VOID_TRANSACTION = 'voidTransaction ';
        private static final String POPULATE_VOID_TRANSACTION = 'populateTransactionResultForVoid ';
        private static final String REFUND_TRANSACTION = 'refundTransaction ';
        private static final String POPULATE_REFUND_TRANSACTION = 'populateTransactionResultForRefund ';
    // ============================================================================
    // STATIC VARIABLES
    // ============================================================================    
        // private Attribute to implement singleton pattern for transaction Service class
        private static CyberSource cyberSourceInstance;
        //Gateway Status related variables
        private static Map<string, blng.TransactionResult.GatewayStatusType> mapGatewayStatusEnumTypesByStrings =
                new Map<string, blng.TransactionResult.GatewayStatusType>();
        static {
            List<blng.TransactionResult.GatewayStatusType> enumValues = blng.TransactionResult.GatewayStatusType.values();
            for (Integer i = 0; i < enumValues.size(); i++) {
                mapGatewayStatusEnumTypesByStrings.put(enumValues.get(i).name(), enumValues.get(i));
            }
        }
        // default Gateway Status
        private static final blng.TransactionResult.GatewayStatusType defaultGatewayStatus = blng.TransactionResult.GatewayStatusType.Indeterminate;
    // ============================================================================
    // EXCEPTION CONSTANTS
    // ============================================================================
    private static final String FAILED_GATEWAY_SETTINGS = 'Gateway is missing required settings';
    private static final String FAILED_CUSTOMER_VALIDATION = 'Customer validation failed';
    private static final String FAILED_XML_GENERATION = 'XML generation failed';
    private static final String FAILED_CALLOUT = 'Gateway callout failed';
    private static final String FAILED_POPULATING_RESULT = 'Error in populating transaction result';
    private static final String FAILED_IN_CATCH_ALL = 'Error in gateway API service';
    // ============================================================================
    // Methods
    // ============================================================================

    /**
    * @name getInstance
    * @description get an Instance of Service class
    * @param NA
    * @return CyberSource Instance
    * @exception To do
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-22
    * @remark 
    * @change
    */ 
    public static CyberSource getInstance() 
    {
        if (NULL == cyberSourceInstance) 
        {
            cyberSourceInstance = new CyberSource();
        }
        return cyberSourceInstance;
    }

    /**
    * @name generateToken
    * @description Method to process Token Transaction request
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */  
    public Map<String, blng.TransactionResult> generateToken(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try {
             Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
            if(!mapOfTransactionParameterById.isEmpty())
            {
                // check validate Customer Details
                CyberSourceUtils.validateCustomerDetails(mapOfTransactionParameterById.Values());
                // Calling CyberSourceUtils class to populate the Request for generate Token XML
                CyberSourceUtils.getInstance().generateTokenXML(mapOfTransactionParameterById.Values());
                for(blng.TransactionParameter transactionParameterToProcess : mapOfTransactionParameterById.Values())
                {
                    try {
                        // Calling CyberSourceHttpService class to send a Request
                        if(!String.IsBlank(transactionParameterToProcess.getPaymentMethod().blng__BillingEmail__c) )
                        {
                            try {
                                CyberSourceHttpService sendHttpRequest = CyberSourceHttpService.getInstance();
                                sendHttpRequest.addHeader('Content-type', 'text/xml');
                                sendHttpRequest.setTokenisationHeader(transactionParameterToProcess.getGateWay().MerchantId__c, transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                                // Sends the request to payment gateway
                                sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION, transactionParameterToProcess.getRequestBody());

                                if (!Test.isRunningTest()) {
                                    // Populating the map of Response for transaction parameter class from the response received by payment gateway
                                    transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(sendHttpRequest.getResponse().getBodyDocument().getRootElement()));

                                } else {
                                    Dom.Document doc = new Dom.Document();
                                    doc.load(TEST_REQUEST_BODY_CYBER_SOURCE);
                                    transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(doc.getRootElement()));
                                }
                            } catch (Exception e) {
                                handleError(transactionParameterToProcess.transactionResult, FAILED_CALLOUT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
                            }
                        } else {
                            string idToProcess = (new list<string>(mapOfTransactionParameterById.keySet())[0]);
                            transactionParameterToProcess.transactionResult.setResponseToValidate('FAILURE');
                            transactionParameterToProcess.transactionResult.setIsSuccess(false);
                            transactionParameterToProcess.transactionResult.setResponseMessage('FAILURE');
                            transactionParameterToProcess.transactionResult.setResponseCode('ERROR');
                            transactionParameterToProcess.transactionResult.setResponseCodeMessage('Missing Information: Email');
                            transactionParameterToProcess.transactionResult.setGatewayId(NULL);
                            transactionParameterToProcess.transactionResult.setGatewayStatus(blng.TransactionResult.GatewayStatusType.ValidationError);
                            mapOfTransactionResultById.put(idToProcess,transactionParameterToProcess.transactionResult);
                            return mapOfTransactionResultById;
                        }
                    }
                    catch (Exception e) 
                    {
                        transactionParameterToProcess.transactionResult.setIsSuccess(false);
                        transactionParameterToProcess.transactionResult.setError(e.getMessage());
                    }    
                }
            } 
            // Calling populate Transaction Result For token class to Return map of transaction results
            return populateTransactionResultForToken(mapOfTransactionParameterById);
        }
        catch (Exception e) 
        {
            throw e;
        }    
    }
    
    /**
    * @name populateTransactionResultForToken
    * @description Method to populate Transaction Result for CyberSource Token
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */ 
    public Map<String, blng.TransactionResult> populateTransactionResultForToken(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
        for(String idToProcess : mapOfTransactionParameterById.KeySet())
        {
            blng.TransactionParameter transactionParameterToProcess;
            try {
                transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                //Populating the transaction Parameter class based on the response is success or failure
                if (transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT) {
                    // The response is success
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                } else if (transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT) {
                    // The response is FAILURE
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setId(idToProcess);
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));

                if (NULL != transactionParameterToProcess.transactionResult.getResponseCode()) {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setPaymentToken(transactionParameterToProcess.getResponseValueByKey().get(SUBSCRIPTIONID));
                //Populate gateway status
                populateGatewayStatus(transactionParameterToProcess.transactionResult);
                mapOfTransactionResultById.put(idToProcess, transactionParameterToProcess.transactionResult);
            } catch (Exception e) {
                handleError(transactionParameterToProcess.transactionResult, FAILED_POPULATING_RESULT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
            }
        }
        //Return map of transaction results
        return mapOfTransactionResultById;
    } 
   /**
    * @name voidTokenTransaction
    * @description Method to process Void Token Transaction request
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Dhanalakshmi
    * @created 2017-06-02
    * @remark 
    * @change
    */  
    public Map<String, blng.TransactionResult> voidTokenTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try {
            if(!mapOfTransactionParameterById.IsEmpty())
            {
                // check validate Customer Details
                //CyberSourceUtils.validateCustomerDetails(mapOfTransactionParameterById.Values());
                // Calling CyberSourceUtils class to populate the Request for generate void token XML
                CyberSourceUtils.getInstance().generateVoidTokenXML(mapOfTransactionParameterById.Values());
                for(blng.TransactionParameter transactionParameterToProcess : mapOfTransactionParameterById.Values())
                {
                    try {
                        // Calling CyberSourceHttpService class to send a Request
                        CyberSourceHttpService sendHttpRequest = CyberSourceHttpService.getInstance();
                        sendHttpRequest.addHeader('Content-type', 'text/xml');
                        sendHttpRequest.setTokenisationHeader(transactionParameterToProcess.getGateWay().MerchantId__c, transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                        // Sends the request to payment gateway
                        sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
                        if(!Test.isRunningTest())
                        {
                            // Populating the map of Response for transaction parameter class from the response received by payment gateway
                            transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(sendHttpRequest.getResponse().getBodyDocument().getRootElement()));
                             
                        }
                        else
                        {
                            Dom.Document doc = new Dom.Document();
                            doc.load(TEST_REQUEST_BODY_CYBER_SOURCE);     
                            transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(doc.getRootElement()));
                        }
                    } catch (Exception e) {
                        handleError(transactionParameterToProcess.transactionResult, FAILED_CALLOUT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
                    }
                }
            } 
            // Calling populate Transaction Result For Void Token class to Return map of transaction results
            return populateTransactionResultForVoidToken(mapOfTransactionParameterById);
        }
        catch (Exception e) 
        {
            throw e; 
        }    
    }
    
    /**
    * @name populateTransactionResultForVoidToken
    * @description Method to populate Transaction Result for CyberSource Void Token
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Dhanalakshmi
    * @created 2017-06-02
    * @remark 
    * @change
    */ 
    public Map<String, blng.TransactionResult> populateTransactionResultForVoidToken(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
        for(String idToProcess : mapOfTransactionParameterById.KeySet())
        {
            blng.TransactionParameter transactionParameterToProcess;
            try {
                transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                //Populating the transaction Parameter class based on the response is success or failure
                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    //The response is success
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    //The response is failure
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setId(idToProcess);
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));

                if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setPaymentToken(transactionParameterToProcess.getResponseValueByKey().get(SUBSCRIPTIONID));
                //Populate gateway status
                populateGatewayStatus(transactionParameterToProcess.transactionResult);
            } catch (Exception e) {
                handleError(transactionParameterToProcess.transactionResult, FAILED_POPULATING_RESULT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
            }
        }
        //Return map of transaction results
        return mapOfTransactionResultById;
    } 
    /**
    * @name authorizeTransaction
    * @description Method to process Authorize Transaction request
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Balachary
    * @created 2017-06-02
    * @remark 
    * @change
    */  
    public Map<String, blng.TransactionResult> authorizeTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try {
            // Calling CyberSourceUtils class to populate the Request for generate Authorize XML
            CyberSourceUtils.getInstance().generateAuthorizeXML(mapOfTransactionParameterById);
            for(blng.TransactionParameter transactionParameterToProcess : mapOfTransactionParameterById.Values())
            {
                try {
                    // Calling CyberSourceHttpService class to send a Request
                    CyberSourceHttpService sendHttpRequest = CyberSourceHttpService.getInstance();
                    sendHttpRequest.addHeader('Content-type', 'text/xml');
                    sendHttpRequest.setAuthorizationHeader(transactionParameterToProcess.getGateWay().MerchantId__c,transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                    // Sends the request to payment gateway
                    sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
                    // Populating the map of Response for transaction parameter class from the response received by payment gateway
                    if(!Test.isRunningTest())
                    {

                        transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(sendHttpRequest.getResponse().getBodyDocument().getRootElement()));
                    }
                    else
                    {
                        Dom.Document doc = new Dom.Document();
                        doc.load(TEST_REQUEST_BODY_CYBER_SOURCE);     
                        transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(doc.getRootElement()));
                    }
                } catch (Exception e) {
                    handleError(transactionParameterToProcess.transactionResult, FAILED_CALLOUT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
                }
            }
            // Calling populate Transaction Result For Authorize class to Return map of transaction results
			
            return populateTransactionResultForAuthorize(mapOfTransactionParameterById);
        }
        
        catch (Exception e) 
        {
            throw e; 
        }    
    }
    
    /**
    * @name populateTransactionResultForAuthorize
    * @description Method to populate Transaction Result for CyberSource Authorize
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String,Value => TransactionResult]
    * @exception Throw Exception
    * @author Balachary
    * @created 2017-06-02
    * @remark 
    * @change
    */ 
    public Map<String, blng.TransactionResult> populateTransactionResultForAuthorize(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
        for(String idToProcess : mapOfTransactionParameterById.KeySet()) {
            blng.TransactionParameter transactionParameterToProcess;
            try {
                transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                //Populating the transaction Parameter class based on the response is success or failure
                if (transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT) {
                    // The response is success
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                } else if (transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT) {
                    // The response is failure
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                } else if (transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING) {
                    // The response is PENDING
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                } else {
                    transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setId(idToProcess);
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
                if (NULL != transactionParameterToProcess.transactionResult.getResponseCode()) {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setGatewayId(transactionParameterToProcess.getResponseValueByKey().get(REQUEST_ID));
                transactionParameterToProcess.transactionResult.setResponseMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                //Populate gateway status
                populateGatewayStatus(transactionParameterToProcess.transactionResult);
                mapOfTransactionResultById.put(idToProcess, transactionParameterToProcess.transactionResult);
            } catch (Exception e) {
                handleError(transactionParameterToProcess.transactionResult, FAILED_POPULATING_RESULT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
            }
        }
        //Return map of transaction results
        return mapOfTransactionResultById;
    } 
    /**
    * @name captureTransaction
    * @description Method to process capture Transaction request
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Manigandan SA
    * @created 2017-05-31
    * @remark 
    * @change
    */  
    public Map<String, blng.TransactionResult> captureTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try {
            String invoiceDetailAPIValue = blng__BillingConfig__c.getValues('INVOICE_DETAIL').blng__StringValue__c;
            Map<String, blng.TransactionResult> mapOfTransactionResultById = CyberSourceUtils.validateInvoiceConfig(mapOfTransactionParameterById, invoiceDetailAPIValue);
            if (!mapOfTransactionResultById.isEmpty()) {
                return mapOfTransactionResultById;
            }
            for(String idToProcess : mapOfTransactionParameterById.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                try {
                    if (transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_CREDITCARD) {
                        if (NULL != invoiceDetailAPIValue) {
                            CyberSourceUtils.getInstance().generateCaptureLevel3XML(new Map<String, blng.TransactionParameter>{
                                    idToProcess => transactionParameterToProcess
                            });
                        } else {
                            // Calling CyberSourceUtils class to populate the Request for generate Capture XML for Credit card
                            CyberSourceUtils.getInstance().generateCaptureXML(new Map<String, blng.TransactionParameter>{
                                    idToProcess => transactionParameterToProcess
                            });
                        }
                    }
                } catch (Exception e) {
                    handleError(transactionParameterToProcess.transactionResult, FAILED_XML_GENERATION, blng.TransactionResult.GatewayStatusType.SystemError, e);
                }
                try {
                    // Calling CyberSourceHttpService class to send a Request
                    CyberSourceHttpService sendHttpRequest = CyberSourceHttpService.getInstance();
                    sendHttpRequest.addHeader('Content-type', 'text/xml');
                    sendHttpRequest.setAuthorizationHeader(transactionParameterToProcess.getGateWay().MerchantId__c,transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                    // Sends the request to payment gateway
                    sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
                    // Populating the map of Response for transaction parameter class from the response received by payment gateway
                    if(!Test.isRunningTest())
                    {
                        transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(sendHttpRequest.getResponse().getBodyDocument().getRootElement()));
                    }
                    else
                    {
                        Dom.Document doc = new Dom.Document();
                        doc.load(TEST_REQUEST_BODY_CYBER_SOURCE);
                        transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(doc.getRootElement()));
                    }
                } catch (Exception e) {
                    handleError(transactionParameterToProcess.transactionResult, FAILED_CALLOUT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
                }
            }
            // Calling populate Transaction Result For Capture class to Return map of transaction results
            return populateTransactionResultForCapture(mapOfTransactionParameterById);
        }
        catch (Exception e) 
        {
            
            throw  e; 
        }
    }
    /**
    * @name populateTransactionResultForCapture
    * @description Method to populate Transaction Result for CyberSource Capture
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Manigandan SA
    * @created 2017-05-31
    * @remark 
    * @change
    */ 
    public Map<String, blng.TransactionResult> populateTransactionResultForCapture(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
        for (String idToProcess : mapOfTransactionParameterById.KeySet()) {
            blng.TransactionParameter transactionParameterToProcess;
            try {
                transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                //Populating the transaction Parameter class based on the response is success or failure
                if (transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT) {
                    //The response is success
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                    transactionParameterToProcess.transactionResult.setResponseMessage('SUCCESS');
                } else if (transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT) {
                    //The response is failure
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                    transactionParameterToProcess.transactionResult.setResponseMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                } else if (transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING) {
                    //The response is Pending
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                } else {
                    transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setId(idToProcess);
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
                if (NULL != transactionParameterToProcess.transactionResult.getResponseCode()) {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setGatewayId(transactionParameterToProcess.getResponseValueByKey().get(REQUEST_ID));
                //Populate gateway status
                populateGatewayStatus(transactionParameterToProcess.transactionResult);
                mapOfTransactionResultById.put(idToProcess, transactionParameterToProcess.transactionResult);
            } catch (Exception e) {
                handleError(transactionParameterToProcess.transactionResult, FAILED_POPULATING_RESULT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
            }
        }
        //Return map of transaction results
        return mapOfTransactionResultById;
    } 
    /**
    * @name chargeTransaction
    * @description Method to process Charge Transaction request
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-26
    * @remark
    * @change
    */  
    public Map<String, blng.TransactionResult> chargeTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try {
            String invoiceDetailAPIValue = blng__BillingConfig__c.getValues('INVOICE_DETAIL').blng__StringValue__c;
            Map<String, blng.TransactionResult> mapOfTransactionResultById = CyberSourceUtils.validateInvoiceConfig(mapOfTransactionParameterById, invoiceDetailAPIValue);
            if (!mapOfTransactionResultById.isEmpty()) {
                return mapOfTransactionResultById;
            }
            for(String idToProcess : mapOfTransactionParameterById.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                if(!String.IsBlank(transactionParameterToProcess.getPaymentMethod().blng__BillingEmail__c))
                {
                    try {
                        if(transactionParameterToProcess.getPaymentMethod().blng__PaymentType__c == PAYMENTTYPE_CREDITCARD )
                        {
                            if(NULL != invoiceDetailAPIValue)
                            {
                             CyberSourceUtils.getInstance().generateChargeLevel3XML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
                            } else
                            {
                             // Calling CyberSourceUtils class to populate the Request for generate Capture XML for Credit card
                             CyberSourceUtils.getInstance().generateChargeXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
                            }
                            // Calling CyberSourceUtils class to populate the Request for generate charge XML for credit card
                        }
                        else if(transactionParameterToProcess.getPaymentMethod().blng__PaymentType__c == PAYMENTTYPE_ACH )
                        {
                            // Calling CyberSourceUtils class to populate the Request for generate charge XML for ACH
                            CyberSourceUtils.getInstance().generateACHChargeXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
                        }
                    } catch (Exception e) {
                       handleError(transactionParameterToProcess.transactionResult, FAILED_XML_GENERATION, blng.TransactionResult.GatewayStatusType.SystemError, e);
                    }
                    try {
                         // Calling CyberSourceHttpService class to send a Request
                         CyberSourceHttpService sendHttpRequest = CyberSourceHttpService.getInstance();
                         sendHttpRequest.addHeader('Content-type', 'text/xml');
                         sendHttpRequest.setAuthorizationHeader(transactionParameterToProcess.getGateWay().MerchantId__c,transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                         // Sends the request to payment gateway
                         sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
                         // Populating the map of Response for transaction parameter class from the response received by payment gateway

                         if(!Test.isRunningTest())
                         {
                             transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(sendHttpRequest.getResponse().getBodyDocument().getRootElement()));
                         }
                         else
                         {
                             Dom.Document doc = new Dom.Document();
                             doc.load(TEST_REQUEST_BODY_CYBER_SOURCE);
                             transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(doc.getRootElement()));
                         }
                    } catch (Exception e) {
                        handleError(transactionParameterToProcess.transactionResult, FAILED_CALLOUT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
                    }
                } else
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(EMAIL_MISSING);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                    transactionParameterToProcess.transactionResult.setResponseMessage(EMAIL_MISSING);
                    transactionParameterToProcess.transactionResult.setId(idToProcess);
                    transactionParameterToProcess.transactionResult.setResponseCode('ERROR');
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage('Missing Information: Email');
                    transactionParameterToProcess.transactionResult.setGatewayId(NULL);
                    transactionParameterToProcess.transactionResult.setGatewayStatus(blng.TransactionResult.GatewayStatusType.ValidationError);
                    mapOfTransactionResultById.put(idToProcess,transactionParameterToProcess.transactionResult);
                    return mapOfTransactionResultById;
                }
            }
            // Calling populate Transaction Result For Charge class to Return map of transaction results
            return populateTransactionResultForCharge(mapOfTransactionParameterById);
        }
        catch (Exception e) 
        {
            
            throw  e; 
        }
    }
    
    /**
    * @name populateTransactionResultForCharge
    * @description Method to populate Transaction Result for CyberSource charge
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */ 
    public Map<String, blng.TransactionResult> populateTransactionResultForCharge(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
        for(String idToProcess : mapOfTransactionParameterById.KeySet())
        {
            blng.TransactionParameter transactionParameterToProcess;
            try {
                transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                //Populating the transaction Parameter class based on the response is success or failure or pending
                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    //The response is success
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                    transactionParameterToProcess.transactionResult.setResponseMessage('SUCCESS');
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    //The response is failure
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                    transactionParameterToProcess.transactionResult.setResponseMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    //The response is pending
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setId(idToProcess);
                if (transactionParameterToProcess.transactionResult.getResponseToValidate() != EMAIL_MISSING)
                {
                   transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
                }
                if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
                if(transactionParameterToProcess.getPaymentMethod().blng__PaymentType__c == 'ACH')
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                }
                if(transactionParameterToProcess.getPaymentMethod().blng__PaymentType__c == 'Credit Card' 
                   && transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD) != NULL )
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setGatewayId(transactionParameterToProcess.getResponseValueByKey().get(REQUEST_ID));
                //Populate gateway status
                populateGatewayStatus(transactionParameterToProcess.transactionResult);
            } catch (Exception e) {
                handleError(transactionParameterToProcess.transactionResult, FAILED_POPULATING_RESULT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
            }
        }
        //Return map of transaction results
        return mapOfTransactionResultById;
    } 

    /**
    * @name voidTransaction
    * @description Method to process Void Transaction request
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Raghavendra Reddy
    * @created 2017-05-30
    * @remark 
    * @change
    */  
    public Map<String, blng.TransactionResult> voidTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try {
            for(String idToProcess : mapOfTransactionParameterById.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                try {
                    if(transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_CREDITCARD)
                    {
                        // Calling Utils class to populate the Request for generate void for credit card XML
                        CyberSourceUtils.getInstance().generateVoidXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});  
                    }
                    else if(transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_ACH)
                    {
                        // Calling Utils class to populate the Request for generate void for ACH XML
                        CyberSourceUtils.getInstance().generateVoidXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
                    }
                } catch (Exception e) {
                    handleError(transactionParameterToProcess.transactionResult, FAILED_XML_GENERATION, blng.TransactionResult.GatewayStatusType.SystemError, e);
                }
                try {
                    // Calling CyberSourceHttpService class to send a Request
                    CyberSourceHttpService sendHttpRequest = CyberSourceHttpService.getInstance();
                    sendHttpRequest.addHeader('Content-type', 'text/xml');
                    sendHttpRequest.setAuthorizationHeader(transactionParameterToProcess.getGateWay().MerchantId__c,transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                    // Sends the request to payment gateway
                    sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
                    // Populating the map of Response for transaction parameter class from the response received by payment gateway
                    if(!Test.isRunningTest())
                    {
                        transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(sendHttpRequest.getResponse().getBodyDocument().getRootElement()));
                    }
                    else
                    {
                        Dom.Document doc = new Dom.Document();
                        doc.load(TEST_REQUEST_BODY_CYBER_SOURCE);
                        transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(doc.getRootElement()));
                    }
                } catch (Exception e) {
                    handleError(transactionParameterToProcess.transactionResult, FAILED_CALLOUT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
                }
            }
            // Calling populate Transaction Result For void class to Return map of transaction results
            return populateTransactionResultForVoid(mapOfTransactionParameterById);
        }
        catch (Exception e)
        {
            throw  e;
        }
    }
    
     /**
    * @name populateTransactionResultForVoid
    * @description Method to populate Transaction Result for CyberSource void
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Raghavendra Reddy
    * @created 2017-05-30
    * @remark 
    * @change
    */ 
    public Map<String, blng.TransactionResult> populateTransactionResultForVoid(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
        for(String idToProcess : mapOfTransactionParameterById.KeySet())
        {
            blng.TransactionParameter transactionParameterToProcess;
            try {
                transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                //Populating the transaction Parameter class based on the response is success or failure or Pending
                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    //Response is success
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    //Response is failure
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    //Response is Pending
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else
                {
                   transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setId(idToProcess);
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
                if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setGatewayId(transactionParameterToProcess.getResponseValueByKey().get(REQUEST_ID));
                transactionParameterToProcess.transactionResult.setResponseMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                //Populate gateway status
                populateGatewayStatus(transactionParameterToProcess.transactionResult);
            } catch (Exception e) {
                handleError(transactionParameterToProcess.transactionResult, FAILED_POPULATING_RESULT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
            }
        }
        //Return map of transaction results
        return mapOfTransactionResultById;
    } 

    /**
    * @name refundTransaction
    * @description Method to process Refund Transaction request
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception 
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-26
    * @remark 
    * @change
    */  
    public Map<String, blng.TransactionResult> refundTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try {
            String invoiceDetailAPIValue = blng__BillingConfig__c.getValues('INVOICE_DETAIL').blng__StringValue__c;
            Map<String, blng.TransactionResult> mapOfTransactionResultById = CyberSourceUtils.validateInvoiceConfig(mapOfTransactionParameterById, invoiceDetailAPIValue);
            if (!mapOfTransactionResultById.isEmpty()) {
                return mapOfTransactionResultById;
            }
            for(String idToProcess : mapOfTransactionParameterById.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                try {
                   if(NULL != transactionParameterToProcess.getTransaction())
                   {
                        if(transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_CREDITCARD)
                        {
                            // Calling CyberSourceUtils class to populate the Request for generate Refund XML for Credit card
                            CyberSourceUtils.getInstance().generateRefundXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
                        }
                        else if(transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_ACH)
                        {
                            // Calling CyberSourceUtils class to populate the Request for generate Refund XML for ACH
                            CyberSourceUtils.getInstance().generateACHRefundXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
                        }
                    }
                } catch (Exception e) {
                    handleError(transactionParameterToProcess.transactionResult, FAILED_XML_GENERATION, blng.TransactionResult.GatewayStatusType.SystemError, e);
                }
                try {
                    // Calling CyberSourceHttpService class to send a Request
                    CyberSourceHttpService sendHttpRequest = CyberSourceHttpService.getInstance();
                    sendHttpRequest.addHeader('Content-type', 'text/xml');
                    sendHttpRequest.setAuthorizationHeader(transactionParameterToProcess.getGateWay().MerchantId__c,transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                    // Sends the request to payment gateway
                    sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
                    // Populating the map of Response for transaction parameter class from the response received by payment gateway
                    if(!Test.isRunningTest())
                    {
                        transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(sendHttpRequest.getResponse().getBodyDocument().getRootElement()));
                    }
                    else
                    {
                        Dom.Document doc = new Dom.Document();
                        doc.load(TEST_REQUEST_BODY_CYBER_SOURCE);
                        transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(doc.getRootElement()));
                    }
                } catch (Exception e) {
                    handleError(transactionParameterToProcess.transactionResult, FAILED_CALLOUT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
                }
            }
            // Calling populate Transaction Result For Refund class to Return map of transaction results
            return populateTransactionResultForRefund(mapOfTransactionParameterById);
        }
        catch (Exception e)
        {
            throw  e;
        }
    }

     /**
    * @name populateTransactionResultForRefund
    * @description method to populate Transaction Result for CyberSource refund
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception 
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */ 
    public Map<String, blng.TransactionResult> populateTransactionResultForRefund(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
        for(String idToProcess : mapOfTransactionParameterById.KeySet())
        {
            blng.TransactionParameter transactionParameterToProcess;
            try {
                transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                //Populating the transaction Parameter class based on the response is success or failure or Pending
                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    //The response is success
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    //The response is failure
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    //The response is Pending
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setId(idToProcess);
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
                if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setGatewayId(transactionParameterToProcess.getResponseValueByKey().get(REQUEST_ID));
                transactionParameterToProcess.transactionResult.setResponseMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                //Populate gateway status
                populateGatewayStatus(transactionParameterToProcess.transactionResult);
            } catch (Exception e) {
                handleError(transactionParameterToProcess.transactionResult, FAILED_POPULATING_RESULT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
            }
        }
        //Return map of transaction results
        return mapOfTransactionResultById;
    } 
    /**
    * @name nonReferencedRefund
    * @description Method to process Non Referred Refund Transaction request
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception 
    * @author Manigandan SA
    * @created 2017-05-30
    * @remark 
    * @change
    */  
    public Map<String, blng.TransactionResult> nonReferencedRefund(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try {
            for(String idToProcess : mapOfTransactionParameterById.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                try {
                   if(NULL != transactionParameterToProcess.getTransaction())
                   {
                        if(transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_CREDITCARD)
                        {
                            // Calling CyberSourceUtils class to populate the Request for generate non Referenced Refund XML for credit card
                            CyberSourceUtils.getInstance().generateCardnonReferencedRefundXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});  
                        }
                        else if(transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_ACH)
                        {
                            // Calling CyberSourceUtils class to populate the Request for generate non Referenced Refund XML for ACH
                            CyberSourceUtils.getInstance().generateACHnonReferencedRefundXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
                        }
                    } 
                    else if(NULL != transactionParameterToProcess.getPaymentMethod())
                    {
                        if(transactionParameterToProcess.getPaymentMethod().blng__PaymentType__c == PAYMENTTYPE_CREDITCARD)
                        {
                            // Calling Utils class to populate the Request for CC Payment
                            CyberSourceUtils.getInstance().generateCardnonReferencedRefundXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
                        }
                        else
                        {
                            // Calling Utils class to populate the Request for ACH Payment
                            CyberSourceUtils.getInstance().generateACHnonReferencedRefundXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
                        }
                    }
                } catch (Exception e) {
                    handleError(transactionParameterToProcess.transactionResult, FAILED_XML_GENERATION, blng.TransactionResult.GatewayStatusType.SystemError, e);
                }
                try {
                    // Calling CyberSourceHttpService class to send a Request  
                    CyberSourceHttpService sendHttpRequest = CyberSourceHttpService.getInstance();
                    sendHttpRequest.addHeader('Content-type', 'text/xml');
                    sendHttpRequest.setAuthorizationHeader(transactionParameterToProcess.getGateWay().MerchantId__c,transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                    // Sends the request to payment gateway
                    sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
                    System.debug('sendHttpRequest.getResponse().getbody()->'+sendHttpRequest.getResponse().getbody());
                    // Populating the map of Response for transaction parameter class from the response received by payment gateway
                    if(!Test.isRunningTest())
                    {
                        transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(sendHttpRequest.getResponse().getBodyDocument().getRootElement()));
                    }
                    else
                    {
                        Dom.Document doc = new Dom.Document();
                        doc.load(TEST_REQUEST_BODY_CYBER_SOURCE);     
                        transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(doc.getRootElement()));
                    }
                } catch (Exception e) {
                    handleError(transactionParameterToProcess.transactionResult, FAILED_CALLOUT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
                }
            }
            // Calling populate Transaction Result For non Referenced Refund class to Return map of transaction results
            return populateTransactionResultFornonReferencedRefund(mapOfTransactionParameterById);
        }
        catch (Exception e) 
        {
            throw  e; 
        }     
    }

     /**
    * @name populateTransactionResultForRefund
    * @description method to populate Transaction Result for CyberSource Non Referred Refund
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception 
    * @author Manigandan SA
    * @created 2017-05-30
    * @remark 
    * @change
    */ 
    public Map<String, blng.TransactionResult> populateTransactionResultFornonReferencedRefund(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
        for(String idToProcess : mapOfTransactionParameterById.KeySet())
        {
            blng.TransactionParameter transactionParameterToProcess;
            try {
                transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                //Populating the transaction Parameter class based on the response is success or failure or Pending
                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    //The response is success
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    //The response is failure
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    //The response is Pending
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setId(idToProcess);
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
                if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setGatewayId(transactionParameterToProcess.getResponseValueByKey().get(REQUEST_ID));
                transactionParameterToProcess.transactionResult.setResponseMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                //Populate gateway status
                populateGatewayStatus(transactionParameterToProcess.transactionResult);
            } catch (Exception e) {
                handleError(transactionParameterToProcess.transactionResult, FAILED_POPULATING_RESULT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
            }
        }
        //Return map of transaction results
        return mapOfTransactionResultById;
    } 

    /**
    * @name voidRefundTransaction
    * @description Method to process Void Refund Transaction request
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Raghavendra Reddy
    * @created 2017-05-30
    * @remark 
    * @change
    */  
    public Map<String, blng.TransactionResult> voidRefundTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try {
            for(String idToProcess : mapOfTransactionParameterById.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                try {
                    if(transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_CREDITCARD)
                    {
                        // Calling Utils class to populate the Request for generate Void Refund for credit card XML
                        CyberSourceUtils.getInstance().generateVoidRefundXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});  
                    }
                    else if(transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_ACH)
                    {
                        // Calling Utils class to populate the Request for generate Void Refund for ACH XML
                        CyberSourceUtils.getInstance().generateVoidRefundXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
                    }
                } catch (Exception e) {
                    handleError(transactionParameterToProcess.transactionResult, FAILED_XML_GENERATION, blng.TransactionResult.GatewayStatusType.SystemError, e);
                }
                try {
                    // Calling CyberSourceHttpService class to send a Request
                    CyberSourceHttpService sendHttpRequest = CyberSourceHttpService.getInstance();
                    sendHttpRequest.addHeader('Content-type', 'text/xml');
                    sendHttpRequest.setAuthorizationHeader(transactionParameterToProcess.getGateWay().MerchantId__c,transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                    // Sends the request to payment gateway
                    sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
                    // Populating the map of Response for transaction parameter class from the response received by payment gateway
                    if(!Test.isRunningTest())
                    {
                        transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(sendHttpRequest.getResponse().getBodyDocument().getRootElement()));
                    }
                    else
                    {
                        Dom.Document doc = new Dom.Document();
                        doc.load(TEST_REQUEST_BODY_CYBER_SOURCE);     
                        transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(doc.getRootElement()));
                    }
                } catch (Exception e) {
                    handleError(transactionParameterToProcess.transactionResult, FAILED_CALLOUT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
                }
            }
            // Calling populate Transaction Result For void refund class to Return map of transaction results
            return populateTransactionResultForvoidRefund(mapOfTransactionParameterById);
        }
        catch (Exception e) 
        {
            throw  e; 
        }         
    }
    
    /**
    * @name populateTransactionResultForvoidRefund
    * @description Method to populate Transaction Result for CyberSource void Refund
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Raghavendra Reddy
    * @created 2017-05-30
    * @remark 
    * @change
    */ 
    public Map<String, blng.TransactionResult> populateTransactionResultForvoidRefund(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
        for(String idToProcess : mapOfTransactionParameterById.KeySet())
        {
            blng.TransactionParameter transactionParameterToProcess;
            try {
                transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                //Populating the transaction Parameter class based on the response is success or failure or pending
                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    //Response is success
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    //The response is failure
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    //The response pending
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else
                {
                   transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setId(idToProcess);
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
                if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setGatewayId(transactionParameterToProcess.getResponseValueByKey().get(REQUEST_ID));
                transactionParameterToProcess.transactionResult.setResponseMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                //Populate gateway status
                populateGatewayStatus(transactionParameterToProcess.transactionResult);
            } catch (Exception e) {
                handleError(transactionParameterToProcess.transactionResult, FAILED_POPULATING_RESULT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
            }
        }
        // Return map of transaction results
        return mapOfTransactionResultById;
    }

    /**
    * @name getPaymentStatus
    * @description Method to get Payment Status Transaction request
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Ramachandran
    * @created 2017-05-30
    * @remark 
    * @change
    */  
    public Map<String, blng.TransactionResult> getPaymentStatus(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try {
            if(!mapOfTransactionParameterById.isEmpty())
            {
                CyberSourceUtils.validateCustomerDetails(mapOfTransactionParameterById.Values());
                // Calling CyberSourceUtils class to populate the Request for generate get Payment Status XML
                CyberSourceUtils.getInstance().generateGetPaymentStatusXML(mapOfTransactionParameterById.Values());
                for(blng.TransactionParameter transactionParameterToProcess : mapOfTransactionParameterById.Values())
                {
                    try {
                        // Calling CyberSourceHttpService class to send a Request
                        CyberSourceHttpService sendHttpRequest = CyberSourceHttpService.getInstance();
                        sendHttpRequest.addHeader('Content-type', 'text/xml');
                        sendHttpRequest.setTokenisationHeader(transactionParameterToProcess.getGateWay().MerchantId__c, transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                        // Sends the request to payment gateway
                        sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
                        system.debug('sendHttpRequest.getResponse()-->'+sendHttpRequest.getResponse());
                        // Populating the map of Response for transaction parameter class from the response received by payment gateway
                        if(!Test.isRunningTest())
                        {
                            transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(sendHttpRequest.getResponse().getBodyDocument().getRootElement()));
                             
                        }
                        else
                        {
                            Dom.Document doc = new Dom.Document();
                            doc.load(TEST_REQUEST_BODY_CYBER_SOURCE);     
                            transactionParameterToProcess.mapOfResponseValueByKey.putAll(CyberSourceUtils.getElements(doc.getRootElement()));
                        }
                    } catch (Exception e) {
                        handleError(transactionParameterToProcess.transactionResult, FAILED_CALLOUT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
                    }
                } 
            } 
            // Calling populate Transaction Result For get Payment Status class to Return map of transaction results
            return populateTransactionResultForgetPaymentStatus(mapOfTransactionParameterById);
        }
        catch (Exception e) 
        {
            throw e; 
        }    
    }
    
    /**
    * @name populateTransactionResultForgetPaymentStatus
    * @description Method to populate Transaction Result for CyberSource get Payment Status 
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Ramachandran
    * @created 2017-05-30
    * @remark 
    * @change
    */ 
    public Map<String, blng.TransactionResult> populateTransactionResultForgetPaymentStatus(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
        for(String idToProcess : mapOfTransactionParameterById.KeySet())
        {
            blng.TransactionParameter transactionParameterToProcess;
            try {
                transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                //Populating the transaction Parameter class based on the response is success or failure
                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    //The response is success
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    //The response is failure
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setId(idToProcess);
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
                
                if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                } 
                //Populating payment gateway response
                transactionParameterToProcess.transactionResult.setPaymentToken(transactionParameterToProcess.getResponseValueByKey().get(SUBSCRIPTIONID));
                //Populate gateway status
                populateGatewayStatus(transactionParameterToProcess.transactionResult);
            } catch (Exception e) {
                handleError(transactionParameterToProcess.transactionResult, FAILED_POPULATING_RESULT, blng.TransactionResult.GatewayStatusType.Indeterminate, e);
            }
        }
        //Return map of transaction results
        return mapOfTransactionResultById;
    }

    /**
     * Does a SOQL lookup on the mapper table and gets the gateway status mapped to the return code
     * Returns the default enum if no match is found
     * @param transactionResult
     */
     public void populateGatewayStatus(blng.TransactionResult transactionResult) {
         blng.TransactionResult.GatewayStatusType gatewayStatus = defaultGatewayStatus;
         String returnCode = transactionResult.getResponseCode();
         if (returnCode != null) {
             List<GatewayStatusMapping__mdt> gatewayStatusMaps = [
                     SELECT GatewayStatus__c
                     FROM GatewayStatusMapping__mdt
                     WHERE ResponseCode__c = :returnCode
                     LIMIT 1
             ];
             if (!gatewayStatusMaps.isEmpty()) {
                 gatewayStatus = mapGatewayStatusEnumTypesByStrings.get(gatewayStatusMaps.get(0).GatewayStatus__c);
                 if (gatewayStatus == null) {
                     gatewayStatus = defaultGatewayStatus;
                 }
             }
         }
         transactionResult.setGatewayStatus(gatewayStatus);
     }

    /**
    * @name handleError
    * @description populates TransactionResult with error values
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-20
    * @remark
    * @change
    */
    private void handleError(blng.TransactionResult transactionResult,
            String pointOfFailure,
            blng.TransactionResult.GatewayStatusType gatewayStatus,
            Exception e) {
        transactionResult.setIsSuccess(false);
        transactionResult.setError(pointOfFailure + (e != null ? ': ' + e.getMessage() : ''));
        transactionResult.setResponseToValidate(FAILURE);
        if (transactionResult.getResponseCode() != null) {
            populateGatewayStatus(transactionResult);
        } else {
            transactionResult.setGatewayStatus(gatewayStatus);
        }
    }
}