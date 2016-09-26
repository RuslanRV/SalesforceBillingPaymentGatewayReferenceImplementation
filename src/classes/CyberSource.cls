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
        private static final String SUBSCRIPTIONID = 'subscriptionID';
        private static final String REASONCODE = 'reasonCode';
        private static final String REQUEST_ID = 'requestID';
        private static final String INVALID_FIELD = 'invalidField';
        private static final String PAYMENTTYPE_CREDITCARD = 'Credit Card';
        private static final String PAYMENTTYPE_ACH = 'ACH';
        private static final String TEST_REQUEST_BODY_CYBER_SOURCE = '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Header><wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"><wsu:Timestamp xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" wsu:Id="Timestamp-501816472"><wsu:Created>2015-09-28T07:46:09.286Z</wsu:Created></wsu:Timestamp></wsse:Security></soap:Header><soap:Body><c:replyMessage xmlns:c="urn:schemas-cybersource-com:transaction-data-1.115"><c:merchantReferenceCode>acertiscloud_23</c:merchantReferenceCode><c:requestID>4436893298465000001516</c:requestID><c:decision>ACCEPT</c:decision><c:reasonCode>100</c:reasonCode><c:requestToken>Ahj//wSR4QyHBpJLFB/YIkGLdq1auG7adFqsbNmRST+D2l0cU2T+D2l0cXSBs4NSahk0ky3SA7msQMJEjwhkODSSWKD+wAAASgCk</c:requestToken><c:purchaseTotals><c:currency>USD</c:currency></c:purchaseTotals><c:ccAuthReply><c:reasonCode>100</c:reasonCode><c:amount>49.95</c:amount><c:authorizationCode>888888</c:authorizationCode><c:avsCode>X</c:avsCode><c:avsCodeRaw>I1</c:avsCodeRaw><c:authorizedDateTime>2015-10-01T08:48:50Z</c:authorizedDateTime><c:processorResponse>100</c:processorResponse><c:reconciliationID>17555876NEU1YYHR</c:reconciliationID></c:ccAuthReply><c:ccCaptureReply><c:reasonCode>100</c:reasonCode><c:requestDateTime>2015-10-01T08:48:50Z</c:requestDateTime><c:amount>49.95</c:amount><c:reconciliationID>17555876NEU1YYHR</c:reconciliationID></c:ccCaptureReply></c:replyMessage></soap:Body></soap:Envelope>';
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
    // ============================================================================
    // VARIABLES
    // ============================================================================
       
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
    * @param NA
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception CustomException [unexpected exception]
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */  
    public Map<String, nxtdev.TransactionResult> generateToken(Map<String, nxtdev.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {
            if(!mapOfTransactionParameterById.IsEmpty())
            {
                CyberSourceUtils.validateCustomerDetails(mapOfTransactionParameterById.Values());
                CyberSourceUtils.getInstance().generateTokenXML(mapOfTransactionParameterById.Values());
                for(nxtdev.TransactionParameter transactionParameterToProcess : mapOfTransactionParameterById.Values())
                {
                    HttpService sendHttpRequest = HttpService.getInstance();
                    sendHttpRequest.addHeader('Content-type', 'text/xml');
                    sendHttpRequest.setTokenisationHeader(transactionParameterToProcess.getGateWay().MerchantId__c, transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                    sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
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
                }    
            } 
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
    * @param NA
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception CustomException [unexpected exception]
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */ 
    public Map<String, nxtdev.TransactionResult> populateTransactionResultForToken(Map<String, nxtdev.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {
            Map<String, nxtdev.TransactionResult> mapOfTransactionResultById = new Map<String, nxtdev.TransactionResult>();
            for(String idToProcess : mapOfTransactionParameterById.KeySet())
            {
                nxtdev.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);

                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                }
                
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
                
                if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                } 

                transactionParameterToProcess.transactionResult.setPaymentToken(transactionParameterToProcess.getResponseValueByKey().get(SUBSCRIPTIONID));
                
                mapOfTransactionResultById.put(idToProcess,transactionParameterToProcess.transactionResult);
            }
            return mapOfTransactionResultById;
        }
        catch (Exception e) 
        {
            throw e; 
        }   
    } 

    /**
    * @name authorizeTransaction
    * @description Method to process Authorize Transaction request
    * @param NA
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception CustomException [unexpected exception]
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-25
    * @remark 
    * @change
    */  
    public Map<String, nxtdev.TransactionResult> authorizeTransaction(Map<String, nxtdev.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {    
            CyberSourceUtils.getInstance().generateAuthorizeXML(mapOfTransactionParameterById);
            for(nxtdev.TransactionParameter transactionParameterToProcess : mapOfTransactionParameterById.Values())
            {
                HttpService sendHttpRequest = HttpService.getInstance();
                sendHttpRequest.addHeader('Content-type', 'text/xml');
                sendHttpRequest.setAuthorizationHeader(transactionParameterToProcess.getGateWay().MerchantId__c,transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
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
            }
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
    * @param NA
    * @return Map[Key => String,Value => TransactionResult]
    * @exception CustomException [unexpected exception]
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */ 
    public Map<String, nxtdev.TransactionResult> populateTransactionResultForAuthorize(Map<String, nxtdev.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {    
            Map<String, nxtdev.TransactionResult> mapOfTransactionResultById = new Map<String, nxtdev.TransactionResult>();
            for(String idToProcess : mapOfTransactionParameterById.KeySet())
            {
                nxtdev.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);

                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                }
                else
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
                if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
                transactionParameterToProcess.transactionResult.setGatewayId(transactionParameterToProcess.getResponseValueByKey().get(REQUEST_ID));
                transactionParameterToProcess.transactionResult.setResponseMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                mapOfTransactionResultById.put(idToProcess,transactionParameterToProcess.transactionResult);
            }
            return mapOfTransactionResultById;
        }
        catch (Exception e) 
        {
            throw e; 
        }    
    } 

    /**
    * @name chargeTransaction
    * @description Method to process Charge Transaction request
    * @param NA
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception CustomException [unexpected exception]
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-26
    * @remark 
    * @change
    */  
    public Map<String, nxtdev.TransactionResult> chargeTransaction(Map<String, nxtdev.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {
           for(nxtdev.TransactionParameter transactionParameterToProcess : mapOfTransactionParameterById.Values())
            {
                if(transactionParameterToProcess.getPaymentMethod().nxtdev__PaymentType__c == PAYMENTTYPE_CREDITCARD)
                {
                    CyberSourceUtils.getInstance().generateChargeXML(mapOfTransactionParameterById);  
                }
                else if(transactionParameterToProcess.getPaymentMethod().nxtdev__PaymentType__c == PAYMENTTYPE_ACH)
                {  
                    CyberSourceUtils.getInstance().generateACHChargeXML(mapOfTransactionParameterById);
                }
                HttpService sendHttpRequest = HttpService.getInstance();
                sendHttpRequest.addHeader('Content-type', 'text/xml');
                sendHttpRequest.setAuthorizationHeader(transactionParameterToProcess.getGateWay().MerchantId__c,transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
                
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
            }
            return populateTransactionResultForCharge(mapOfTransactionParameterById); 
        }
        catch (Exception e) 
        {
            
            throw  e; 
        }
    }
    
    /**
    * @name populateTransactionResultForCharge
    * @description Method to populate Transaction Result for CyberSource authorize
    * @param NA
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception CustomException [unexpected exception]
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */ 
    public Map<String, nxtdev.TransactionResult> populateTransactionResultForCharge(Map<String, nxtdev.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {
            Map<String, nxtdev.TransactionResult> mapOfTransactionResultById = new Map<String, nxtdev.TransactionResult>();
            for(String idToProcess : mapOfTransactionParameterById.KeySet())
            {
                nxtdev.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);

                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                }
                else
                {
                   transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                
               transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
               if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
               transactionParameterToProcess.transactionResult.setGatewayId(transactionParameterToProcess.getResponseValueByKey().get(REQUEST_ID));
               transactionParameterToProcess.transactionResult.setResponseMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
               mapOfTransactionResultById.put(idToProcess,transactionParameterToProcess.transactionResult);
            }
            return mapOfTransactionResultById;
        }
        catch (Exception e) 
        {
            throw e; 
        }      
    } 

    /**
    * @name voidTransaction
    * @description Method to process Void Transaction request
    * @param NA
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception CustomException [unexpected exception]
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-26
    * @remark 
    * @change
    */  
    public Map<String, nxtdev.TransactionResult> voidTransaction(Map<String, nxtdev.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {
            for(nxtdev.TransactionParameter transactionParameterToProcess : mapOfTransactionParameterById.Values())
            {
                if(transactionParameterToProcess.getPaymentMethod().nxtdev__PaymentType__c == PAYMENTTYPE_CREDITCARD)
                {
                    CyberSourceUtils.getInstance().generateVoidXML(mapOfTransactionParameterById);  
                }
                else if(transactionParameterToProcess.getPaymentMethod().nxtdev__PaymentType__c == PAYMENTTYPE_ACH)
                {
                    CyberSourceUtils.getInstance().generateACHVoidXML(mapOfTransactionParameterById);
                }
                HttpService sendHttpRequest = HttpService.getInstance();
                sendHttpRequest.addHeader('Content-type', 'text/xml');
                sendHttpRequest.setAuthorizationHeader(transactionParameterToProcess.getGateWay().MerchantId__c,transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
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
            }
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
    * @param NA
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception CustomException [unexpected exception]
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */ 
    public Map<String, nxtdev.TransactionResult> populateTransactionResultForVoid(Map<String, nxtdev.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {    
            Map<String, nxtdev.TransactionResult> mapOfTransactionResultById = new Map<String, nxtdev.TransactionResult>();
            for(String idToProcess : mapOfTransactionParameterById.KeySet())
            {
                nxtdev.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);

                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                }
                else
                {
                   transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
                if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
                transactionParameterToProcess.transactionResult.setGatewayId(transactionParameterToProcess.getResponseValueByKey().get(REQUEST_ID));
                transactionParameterToProcess.transactionResult.setResponseMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                mapOfTransactionResultById.put(idToProcess,transactionParameterToProcess.transactionResult);
            }
            return mapOfTransactionResultById;
        }
        catch (Exception e) 
        {
            throw  e; 
        }     
    } 

    /**
    * @name refundTransaction
    * @description Method to process Refund Transaction request
    * @param NA
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception CustomException [unexpected exception]
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-26
    * @remark 
    * @change
    */  
    public Map<String, nxtdev.TransactionResult> refundTransaction(Map<String, nxtdev.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {   
            for(nxtdev.TransactionParameter transactionParameterToProcess : mapOfTransactionParameterById.Values())
            {
                if(transactionParameterToProcess.getPaymentMethod().nxtdev__PaymentType__c == PAYMENTTYPE_CREDITCARD)
                {
                    CyberSourceUtils.getInstance().generateRefundXML(mapOfTransactionParameterById);  
                }
                else if(transactionParameterToProcess.getPaymentMethod().nxtdev__PaymentType__c == PAYMENTTYPE_ACH)
                {
                    CyberSourceUtils.getInstance().generateACHRefundXML(mapOfTransactionParameterById);
                }
                HttpService sendHttpRequest = HttpService.getInstance();
                sendHttpRequest.addHeader('Content-type', 'text/xml');
                sendHttpRequest.setAuthorizationHeader(transactionParameterToProcess.getGateWay().MerchantId__c,transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                sendHttpRequest.post(transactionParameterToProcess.getGateWay().TestMode__c ? CYBER_SOURCE_ENDPOINT_URL_SANDBOX : CYBER_SOURCE_ENDPOINT_URL_PRODUCTION,transactionParameterToProcess.getRequestBody());
                
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
            }
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
    * @param NA
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception CustomException [unexpected exception]
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */ 
    public Map<String, nxtdev.TransactionResult> populateTransactionResultForRefund(Map<String, nxtdev.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {
            Map<String, nxtdev.TransactionResult> mapOfTransactionResultById = new Map<String, nxtdev.TransactionResult>();
            for(String idToProcess : mapOfTransactionParameterById.KeySet())
            {
                nxtdev.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);

                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                }
                else
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                
                transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
                if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
                transactionParameterToProcess.transactionResult.setGatewayId(transactionParameterToProcess.getResponseValueByKey().get(REQUEST_ID));
                transactionParameterToProcess.transactionResult.setResponseMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                mapOfTransactionResultById.put(idToProcess,transactionParameterToProcess.transactionResult);
            }
            return mapOfTransactionResultById;
        }
        catch (Exception e) 
        {
            throw  e;  
        }    
    } 
}