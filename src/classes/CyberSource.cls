/*
 * Copyright (c) 2020, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root
 https://github.com/forcedotcom/SalesforceBillingPaymentGatewayReferenceImplementation/blob/master/LICENSE.txt 
 */
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
        try
        {
            if(!mapOfTransactionParameterById.IsEmpty())
            {
                CyberSourceUtils.validateCustomerDetails(mapOfTransactionParameterById.Values());
                CyberSourceUtils.getInstance().generateTokenXML(mapOfTransactionParameterById.Values());
                for(blng.TransactionParameter transactionParameterToProcess : mapOfTransactionParameterById.Values())
                {
                    try
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
                    catch (Exception e) 
                    {
                        transactionParameterToProcess.transactionResult.setIsSuccess(false);
                        transactionParameterToProcess.transactionResult.setError(e.getMessage());
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
        try
        {
            Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
            for(String idToProcess : mapOfTransactionParameterById.KeySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);

                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                transactionParameterToProcess.transactionResult.setId(idToProcess);
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
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-25
    * @remark 
    * @change
    */  
    public Map<String, blng.TransactionResult> authorizeTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {    
            CyberSourceUtils.getInstance().generateAuthorizeXML(mapOfTransactionParameterById);
            for(blng.TransactionParameter transactionParameterToProcess : mapOfTransactionParameterById.Values())
            {
                try
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
                catch (Exception e) 
                {
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                    transactionParameterToProcess.transactionResult.setError(e.getMessage());
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
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String,Value => TransactionResult]
    * @exception Throw Exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */ 
    public Map<String, blng.TransactionResult> populateTransactionResultForAuthorize(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {    
            Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
            for(String idToProcess : mapOfTransactionParameterById.KeySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);

                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                transactionParameterToProcess.transactionResult.setId(idToProcess);
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
        try
        {
           for(String idToProcess : mapOfTransactionParameterById.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                try
                {    
                    if(transactionParameterToProcess.getPaymentMethod().blng__PaymentType__c == PAYMENTTYPE_CREDITCARD)
                    {
                        CyberSourceUtils.getInstance().generateChargeXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});  
                    }
                    else if(transactionParameterToProcess.getPaymentMethod().blng__PaymentType__c == PAYMENTTYPE_ACH)
                    {  
                        CyberSourceUtils.getInstance().generateACHChargeXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
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
                catch (Exception e) 
                {
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                    transactionParameterToProcess.transactionResult.setError(e.getMessage());
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
        try
        {
            Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
            for(String idToProcess : mapOfTransactionParameterById.KeySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);

                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                    transactionParameterToProcess.transactionResult.setResponseMessage('SUCCESS');
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                    transactionParameterToProcess.transactionResult.setResponseMessage(transactionParameterToProcess.getResponseValueByKey().get(INVALID_FIELD));
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else
                {
                   transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
               transactionParameterToProcess.transactionResult.setId(idToProcess);
               transactionParameterToProcess.transactionResult.setResponseCode(transactionParameterToProcess.getResponseValueByKey().get(REASONCODE));
               if(NULL != transactionParameterToProcess.transactionResult.getResponseCode())
                {
                    transactionParameterToProcess.transactionResult.setResponseCodeMessage(CyberSourceUtils.getErrorCyberSourceCode().get(transactionParameterToProcess.transactionResult.getResponseCode()));
                }
               transactionParameterToProcess.transactionResult.setGatewayId(transactionParameterToProcess.getResponseValueByKey().get(REQUEST_ID));
               
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
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-26
    * @remark 
    * @change
    */  
    public Map<String, blng.TransactionResult> voidTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {
            for(String idToProcess : mapOfTransactionParameterById.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                try
                {
                    if(transactionParameterToProcess.getPaymentMethod().blng__PaymentType__c == PAYMENTTYPE_CREDITCARD)
                    {
                        CyberSourceUtils.getInstance().generateVoidXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});  
                    }
                    else if(transactionParameterToProcess.getPaymentMethod().blng__PaymentType__c == PAYMENTTYPE_ACH)
                    {
                        CyberSourceUtils.getInstance().generateACHVoidXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
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
                catch (Exception e) 
                {
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                    transactionParameterToProcess.transactionResult.setError(e.getMessage());
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
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception Throw Exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */ 
    public Map<String, blng.TransactionResult> populateTransactionResultForVoid(Map<String, blng.TransactionParameter> mapOfTransactionParameterById)
    {
        try
        {    
            Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
            for(String idToProcess : mapOfTransactionParameterById.KeySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);

                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else
                {
                   transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                transactionParameterToProcess.transactionResult.setId(idToProcess);
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
        try
        {   
            for(String idToProcess : mapOfTransactionParameterById.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);
                try
                {
                   if(NULL != transactionParameterToProcess.getTransaction())
                   {
                        if(transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_CREDITCARD)
                        {
                            CyberSourceUtils.getInstance().generateRefundXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});  
                        }
                        else if(transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_ACH)
                        {
                            CyberSourceUtils.getInstance().generateACHRefundXML(new Map<String, blng.TransactionParameter> {idToProcess => transactionParameterToProcess});
                        }
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
                catch (Exception e) 
                {
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                    transactionParameterToProcess.transactionResult.setError(e.getMessage());
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
        try
        {
            Map<String, blng.TransactionResult> mapOfTransactionResultById = new Map<String, blng.TransactionResult>();
            for(String idToProcess : mapOfTransactionParameterById.KeySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterById.get(idToProcess);

                if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == ACCEPT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(SUCCESS);
                    transactionParameterToProcess.transactionResult.setIsSuccess(true);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == REJECT)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(FAILURE);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else if(transactionParameterToProcess.getResponseValueByKey().get(DECISION) == PENDING)
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate(PENDING);
                    transactionParameterToProcess.transactionResult.setIsSuccess(false);
                }
                else
                {
                    transactionParameterToProcess.transactionResult.setResponseToValidate('');
                }
                transactionParameterToProcess.transactionResult.setId(idToProcess);
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
