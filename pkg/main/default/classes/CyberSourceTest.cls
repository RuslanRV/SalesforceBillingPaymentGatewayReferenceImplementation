// ============================================================================================= 
//  Object: Gateway Service Test
//  Company: Salesforce
//  Purpose: Unit test methods to test Cyber Source payment gateway class functionality.

@isTest (SeeALLData=false)
private class CyberSourceTest
{
    private static final String TEST_REQUEST_BODY_REJECT = '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Header><wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"><wsu:Timestamp xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" wsu:Id="Timestamp-501816472"><wsu:Created>2015-09-28T07:46:09.286Z</wsu:Created></wsu:Timestamp></wsse:Security></soap:Header><soap:Body><c:replyMessage xmlns:c="urn:schemas-cybersource-com:transaction-data-1.115"><c:merchantReferenceCode>acertiscloud_23</c:merchantReferenceCode><c:requestID>4436893298465000001516</c:requestID><c:decision>REJECT</c:decision><c:reasonCode>101</c:reasonCode><c:requestToken>Ahj//wSR4QyHBpJLFB/YIkGLdq1auG7adFqsbNmRST+D2l0cU2T+D2l0cXSBs4NSahk0ky3SA7msQMJEjwhkODSSWKD+wAAASgCk</c:requestToken><c:purchaseTotals><c:currency>USD</c:currency></c:purchaseTotals><c:ccAuthReply><c:reasonCode>101</c:reasonCode><c:invalidField>Invalid Field X</c:invalidField><c:amount>49.95</c:amount><c:authorizationCode>888888</c:authorizationCode><c:avsCode>X</c:avsCode><c:avsCodeRaw>I1</c:avsCodeRaw><c:authorizedDateTime>2015-10-01T08:48:50Z</c:authorizedDateTime><c:processorResponse>101</c:processorResponse><c:reconciliationID>17555876NEU1YYHR</c:reconciliationID></c:ccAuthReply><c:ccCaptureReply><c:reasonCode>101</c:reasonCode><c:requestDateTime>2015-10-01T08:48:50Z</c:requestDateTime><c:amount>49.95</c:amount><c:reconciliationID>17555876NEU1YYHR</c:reconciliationID></c:ccCaptureReply></c:replyMessage></soap:Body></soap:Envelope>';
    private static final String TEST_REQUEST_BODY_PENDING = '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Header><wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"><wsu:Timestamp xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" wsu:Id="Timestamp-501816472"><wsu:Created>2015-09-28T07:46:09.286Z</wsu:Created></wsu:Timestamp></wsse:Security></soap:Header><soap:Body><c:replyMessage xmlns:c="urn:schemas-cybersource-com:transaction-data-1.115"><c:merchantReferenceCode>acertiscloud_23</c:merchantReferenceCode><c:requestID>4436893298465000001516</c:requestID><c:decision>PENDING</c:decision><c:reasonCode>102</c:reasonCode><c:requestToken>Ahj//wSR4QyHBpJLFB/YIkGLdq1auG7adFqsbNmRST+D2l0cU2T+D2l0cXSBs4NSahk0ky3SA7msQMJEjwhkODSSWKD+wAAASgCk</c:requestToken><c:purchaseTotals><c:currency>USD</c:currency></c:purchaseTotals><c:ccAuthReply><c:reasonCode>102</c:reasonCode><c:amount>49.95</c:amount><c:authorizationCode>888888</c:authorizationCode><c:avsCode>X</c:avsCode><c:avsCodeRaw>I1</c:avsCodeRaw><c:authorizedDateTime>2015-10-01T08:48:50Z</c:authorizedDateTime><c:processorResponse>102</c:processorResponse><c:reconciliationID>17555876NEU1YYHR</c:reconciliationID></c:ccAuthReply><c:ccCaptureReply><c:reasonCode>102</c:reasonCode><c:requestDateTime>2015-10-01T08:48:50Z</c:requestDateTime><c:amount>49.95</c:amount><c:reconciliationID>17555876NEU1YYHR</c:reconciliationID></c:ccCaptureReply></c:replyMessage></soap:Body></soap:Envelope>';
    private static final String TEST_REQUEST_BODY_EMPTY_DECISION = '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Header><wsse:Security xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"><wsu:Timestamp xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" wsu:Id="Timestamp-501816472"><wsu:Created>2015-09-28T07:46:09.286Z</wsu:Created></wsu:Timestamp></wsse:Security></soap:Header><soap:Body><c:replyMessage xmlns:c="urn:schemas-cybersource-com:transaction-data-1.115"><c:merchantReferenceCode>acertiscloud_23</c:merchantReferenceCode><c:requestID>4436893298465000001516</c:requestID><c:decision></c:decision><c:reasonCode>103</c:reasonCode><c:requestToken>Ahj//wSR4QyHBpJLFB/YIkGLdq1auG7adFqsbNmRST+D2l0cU2T+D2l0cXSBs4NSahk0ky3SA7msQMJEjwhkODSSWKD+wAAASgCk</c:requestToken><c:purchaseTotals><c:currency>USD</c:currency></c:purchaseTotals><c:ccAuthReply><c:reasonCode>103</c:reasonCode><c:amount>49.95</c:amount><c:authorizationCode>888888</c:authorizationCode><c:avsCode>X</c:avsCode><c:avsCodeRaw>I1</c:avsCodeRaw><c:authorizedDateTime>2015-10-01T08:48:50Z</c:authorizedDateTime><c:processorResponse>103</c:processorResponse><c:reconciliationID>17555876NEU1YYHR</c:reconciliationID></c:ccAuthReply><c:ccCaptureReply><c:reasonCode>103</c:reasonCode><c:requestDateTime>2015-10-01T08:48:50Z</c:requestDateTime><c:amount>49.95</c:amount><c:reconciliationID>17555876NEU1YYHR</c:reconciliationID></c:ccCaptureReply></c:replyMessage></soap:Body></soap:Envelope>';
    private static final String SUCCESS = 'SUCCESS';
    private static final String FAILURE = 'FAILURE';
    private static final String PENDING = 'PENDING';
    private static final String PAYMENTTYPE_CREDITCARD = 'Credit Card';
    private static final String PAYMENTTYPE_ACH = 'ACH';
    private static final String SUCCESS_MESSAGE = 'Successful transaction'; // hardcoded in utils for 100
    private static final String REJECT_MESSAGE = 'The request is missing one or more required fields.Possible action: see the reply fields missingField_0...N for which fields are missing. Resend the request with the complete information. For information about missing or invalid fields'; // hardcoded in utils for 101
    private static final String PENDING_MESSAGE = 'Invalid data'; // hardcoded in utils for 102
    private static final String EMAIL_MISSING = 'Email is Missing';
    private static final String INVALID_FIELD_MESSAGE = 'Invalid Field X'; // some arbitrary value we have in the soap responses
    private static final String GATEWAY_ID = '4436893298465000001516'; // some arbitrary value we have in the soap responses
    private static final String SUBSCRIPTION_ID = '123456'; // some arbitrary value we have in the soap responses

    private static final String GENERATE_TOKEN = 'generateToken';
    private static final String AUTHORIZE_TRANSACTION = 'authorizeTransaction';
    private static final String CHARGE_TRANSACTION = 'chargeTransaction';
    private static final String VOID_TRANSACTION = 'voidTransaction';
    private static final String REFUND_TRANSACTION = 'refundTransaction';
    private static final String CAPTURE_TRANSACTION = 'captureTransaction';
    private static final String VOID_REFUND_TRANSACTION = 'voidRefundTransaction';
    private static final String VOID_TOKEN_TRANSACTION = 'voidTokenTransaction';
    private static final String GET_PAYMENT_STATUS = 'getPaymentStatus';
    private static final String GET_REFUND_STATUS = 'getRefundStatus';
    private static final String NON_REFERRED_REFUND = 'nonReferredRefund';

    /**
    * @name testValidateCustomerFailure
    * @description validate one of the failures to make sure the customer validation works
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    /**
     * TODO this will change after we implement the service improvements
     */
    public static testMethod void testValidateCustomerFailure()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        //overwrite from setup
        transactionParameter.setFirstName('');
        Map<String, blng.TransactionParameter> mapOfProcessIdToTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        blng.PaymentGatewayParameter paymentGatewayParameter = new blng.PaymentGatewayParameter();
        paymentGatewayParameter.setTransactionType(GENERATE_TOKEN);
        Test.startTest();
        Map<String, blng.TransactionResult> response = CyberSourceAPI.processPayments(mapOfProcessIdToTransactionParameter, paymentGatewayParameter);
        if(response.size() > 0) {
            blng.TransactionResult transactionResult = response.values().get(0);
            System.assertEquals(1, transactionResult.getErrors().size());
            System.assertEquals('First Name is missing', transactionResult.getErrors().get(0));
        }
        Test.stopTest();
    }

    /**
    * @name testGenerateTokenSuccess
    * @description generate token success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testGenerateTokenSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        // setupData sets the payment token, but since generate token does does require it, remove it here
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        blng.TransactionResult transactionResult = invokeAPIAndVerifyResponse(GENERATE_TOKEN, transactionParameter, '100', SUCCESS, null, SUCCESS_MESSAGE, null);
        System.assertEquals(SUBSCRIPTION_ID, transactionResult.getPaymentToken(), 'Wrong Payment Token');
    }

    /**
    * @name testGenerateTokenReject
    * @description generate token reject case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testGenerateTokenReject()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        // setupData sets the payment token, but since generate token does does require it, remove it here
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        // change the response message to be the reject message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        invokeAPIAndVerifyResponse(GENERATE_TOKEN, transactionParameter, '101', FAILURE, null, REJECT_MESSAGE, null);
    }

    /**
    * @name testGenerateTokenForMissingEmail
    * @description generate token missing email case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testGenerateTokenForMissingEmail()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        // setupData sets the payment token, but since generate token does does require it, remove it here
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        // set the email as blank
        transactionParameter.getPaymentMethod().blng__BillingEmail__c = '';
        blng.TransactionResult transactionResult = invokeAPIAndVerifyResponse(GENERATE_TOKEN, transactionParameter, 'ERROR', FAILURE, FAILURE, 'Missing Information: Email', null);
        System.assertEquals(blng.TransactionResult.GatewayStatusType.ValidationError, transactionResult.getGatewayStatus(), 'Wrong Gateway Status');
    }

    /**
    * @name testVoidTokenTransactionSuccess
    * @description void token success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testVoidTokenTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_ACH);
        blng.TransactionResult transactionResult = invokeAPIAndVerifyResponse(VOID_TOKEN_TRANSACTION, transactionParameter, '100', SUCCESS, null, SUCCESS_MESSAGE, null);
        System.assertEquals(SUBSCRIPTION_ID, transactionResult.getPaymentToken(), 'Wrong Payment Token');
    }

    /**
    * @name testVoidTokenTransactionReject
    * @description void token reject case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testVoidTokenTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_ACH);
        // change the response message to be the reject message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        invokeAPIAndVerifyResponse(VOID_TOKEN_TRANSACTION, transactionParameter, '101', FAILURE, null, REJECT_MESSAGE, null);
    }

    /**
    * @name testAuthorizeTransactionSuccess
    * @description authorize transaction success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testAuthorizeTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        invokeAPIAndVerifyResponse(AUTHORIZE_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testAuthorizeTransactionReject
    * @description authorize transaction reject case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testAuthorizeTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        // change the response message to be the reject message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        invokeAPIAndVerifyResponse(AUTHORIZE_TRANSACTION, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, REJECT_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testAuthorizeTransactionPending
    * @description authorize transaction pending case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testAuthorizeTransactionPending()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        // change the response message to be the pending message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        invokeAPIAndVerifyResponse(AUTHORIZE_TRANSACTION, transactionParameter, '102', PENDING, null, PENDING_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testAuthorizeTransactionEmptyDecision
    * @description authorize transaction empty decision case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testAuthorizeTransactionEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        // change the response message to be the empty <decision> message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        invokeAPIAndVerifyResponse(AUTHORIZE_TRANSACTION, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    /**
     * @name testCaptureTransactionACHSuccess
     * @description capture transaction ACH success case
     * @Param
     * @return NA
     * @exception NA
     * @author Lopa
     * @created 2018-06-5
     * @remark
     * @change
     */
    public static testMethod void testCaptureTransactionACHSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        invokeAPIAndVerifyResponse(CAPTURE_TRANSACTION, transactionParameter, '100', SUCCESS, SUCCESS, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testCaptureTransactionCCSuccess
    * @description capture transaction CC success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testCaptureTransactionCCSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        // this API call for credit card needs an invoice
        blng__Invoice__c invoice = new blng__Invoice__c (blng__Account__c = transactionParameter.getAccount().Id);
        insert invoice;
        transactionParameter.setInvoice(invoice);
        invokeAPIAndVerifyResponse(CAPTURE_TRANSACTION, transactionParameter, '100', SUCCESS, SUCCESS, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testCaptureTransactionReject
    * @description capture transaction reject case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testCaptureTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the reject message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        invokeAPIAndVerifyResponse(CAPTURE_TRANSACTION, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, REJECT_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testCaptureTransactionPending
    * @description capture transaction pending case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testCaptureTransactionPending()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the pending message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        invokeAPIAndVerifyResponse(CAPTURE_TRANSACTION, transactionParameter, '102', PENDING, null, PENDING_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testCaptureTransactionEmptyDecision
    * @description capture transaction empty decision case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testCaptureTransactionEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the empty <decision> message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        invokeAPIAndVerifyResponse(CAPTURE_TRANSACTION, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    /**
    * @name testCaptureTransactionLevel3XML
    * @description
    * generateCaptureLevel3XML() method is called when the config for
    * INVOICE_DETAIL has the name of a TextArea field in blng__StringValue__c.
    * Invoice__c does not have a TextArea, but a customer can add one.
    * Since we cannot add a new field in the test, we will call this method directly
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testCaptureTransactionLevel3XML()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        blng__Invoice__c invoice = new blng__Invoice__c (blng__Account__c = transactionParameter.getAccount().Id);
        insert invoice;
        transactionParameter.setInvoice(invoice);
        Map<String, blng.TransactionParameter> mapOfProcessIdToTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.startTest();
        CyberSourceUtils.getInstance().generateCaptureLevel3XML(mapOfProcessIdToTransactionParameter);
        System.assertNotEquals(null, transactionParameter.getRequestBody(), 'Request body should be populated');
        Test.stopTest();
    }

    /**
    * @name testChargeTransactionLevel3XML
    * @description
    * generateChargeLevel3XML() method is called when the config for
    * INVOICE_DETAIL has the name of a TextArea field in blng__StringValue__c.
    * Invoice__c does not have a TextArea, but a customer can add one.
    * Since we cannot add a new field in the test, we will call this method directly
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testChargeTransactionLevel3XML()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        blng__Invoice__c invoice = new blng__Invoice__c (blng__Account__c = transactionParameter.getAccount().Id);
        insert invoice;
        transactionParameter.setInvoice(invoice);
        Map<String, blng.TransactionParameter> mapOfProcessIdToTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.startTest();
        CyberSourceUtils.getInstance().generateChargeLevel3XML(mapOfProcessIdToTransactionParameter);
        System.assertNotEquals(null, transactionParameter.getRequestBody(), 'Request body should be populated');
        Test.stopTest();
    }

    /**
    * @name testChargeTransactionMissingEmail
    * @description charge transaction missing email case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testChargeTransactionMissingEmail()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // empty the email field
        transactionParameter.getPaymentMethod().blng__BillingEmail__c = '';
        blng.TransactionResult transactionResult = invokeAPIAndVerifyResponse(CHARGE_TRANSACTION, transactionParameter, 'ERROR', EMAIL_MISSING, EMAIL_MISSING, 'Missing Information: Email', NULL);
        System.assertEquals(blng.TransactionResult.GatewayStatusType.ValidationError, transactionResult.getGatewayStatus(), 'Wrong Gateway Status');
    }

    /**
    * @name testChargeTransactionACHSuccess
    * @description charge transaction ACH success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testChargeTransactionACHSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_ACH);
        invokeAPIAndVerifyResponse(CHARGE_TRANSACTION, transactionParameter, '100', SUCCESS, SUCCESS, INVALID_FIELD_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testChargeTransactionCCwithPaymentTransactionSuccess
    * @description charge transaction 'CC with payment transaction' success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testChargeTransactionCCwithPaymentTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        invokeAPIAndVerifyResponse(CHARGE_TRANSACTION, transactionParameter, '100', SUCCESS, SUCCESS, INVALID_FIELD_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testChargeTransactionCCnoPaymentTransactionSuccess
    * @description charge transaction 'CC without payment transaction' success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testChargeTransactionCCnoPaymentTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        invokeAPIAndVerifyResponse(CHARGE_TRANSACTION, transactionParameter, '100', SUCCESS, SUCCESS, INVALID_FIELD_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testChargeTransactionReject
    * @description charge transaction reject case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testChargeTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the reject message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        invokeAPIAndVerifyResponse(CHARGE_TRANSACTION, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, INVALID_FIELD_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testChargeTransactionPending
    * @description charge transaction pending case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testChargeTransactionPending()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the pending message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        invokeAPIAndVerifyResponse(CHARGE_TRANSACTION, transactionParameter, '102', PENDING, null, null, GATEWAY_ID);
    }

    /**
    * @name testChargeTransactionEmptyDecision
    * @description charge transaction empty decision case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testChargeTransactionEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the empty <decision> message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        invokeAPIAndVerifyResponse(CHARGE_TRANSACTION, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    /**
    * @name testVoidTransactionACHSuccess
    * @description void transaction ACH success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testVoidTransactionACHSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        invokeAPIAndVerifyResponse(VOID_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testVoidTransactionCCSuccess
    * @description void transaction CC success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testVoidTransactionCCSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        invokeAPIAndVerifyResponse(VOID_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testVoidTransactionReject
    * @description void transaction reject case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testVoidTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the reject message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        invokeAPIAndVerifyResponse(VOID_TRANSACTION, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, REJECT_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testVoidTransactionPending
    * @description void transaction pending case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testVoidTransactionPending()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the pending message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        invokeAPIAndVerifyResponse(VOID_TRANSACTION, transactionParameter, '102', PENDING, null, PENDING_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testVoidTransactionEmptyDecision
    * @description void transaction empty decision case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testVoidTransactionEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the empty <decision> message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        invokeAPIAndVerifyResponse(VOID_TRANSACTION, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    /**
    * @name testRefundTransactionACHSuccess
    * @description refund transaction ACH success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testRefundTransactionACHSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        invokeAPIAndVerifyResponse(REFUND_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testRefundTransactionCCwithPaymentTransactionSuccess
    * @description refund transaction 'CC with payment transaction' success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testRefundTransactionCCwithPaymentTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        invokeAPIAndVerifyResponse(REFUND_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testRefundTransactionCCnoPaymentTransactionSuccess
    * @description refund transaction 'CC without payment transaction' success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testRefundTransactionCCnoPaymentTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        invokeAPIAndVerifyResponse(REFUND_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testRefundTransactionReject
    * @description refund transaction reject case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testRefundTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the reject message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        invokeAPIAndVerifyResponse(REFUND_TRANSACTION, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, REJECT_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testRefundTransactionPending
    * @description refund transaction pending case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testRefundTransactionPending()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the pending message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        invokeAPIAndVerifyResponse(REFUND_TRANSACTION, transactionParameter, '102', PENDING, null, PENDING_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testRefundTransactionEmptyDecision
    * @description refund transaction empty decision case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testRefundTransactionEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the empty <decision> message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        invokeAPIAndVerifyResponse(REFUND_TRANSACTION, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    /**
    * @name testNonReferredRefundACHwithPaymentTransactionSuccess
    * @description NonReferred Refund 'ACH with payment transaction' success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testNonReferredRefundACHwithPaymentTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        invokeAPIAndVerifyResponse(NON_REFERRED_REFUND, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testNonReferredRefundACHnoPaymentTransactionSuccess
    * @description NonReferred Refund 'ACH without payment transaction' success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testNonReferredRefundACHnoPaymentTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_ACH);
        invokeAPIAndVerifyResponse(NON_REFERRED_REFUND, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testNonReferredRefundCCwithPaymentTransactionSuccess
    * @description NonReferred Refund 'CC with payment transaction' success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testNonReferredRefundCCwithPaymentTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        invokeAPIAndVerifyResponse(NON_REFERRED_REFUND, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testNonReferredRefundCCnoPaymentTransactionSuccess
    * @description NonReferred Refund 'CC without payment transaction' success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testNonReferredRefundCCnoPaymentTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        invokeAPIAndVerifyResponse(NON_REFERRED_REFUND, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testNonReferredRefundReject
    * @description NonReferred Refund reject case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testNonReferredRefundReject()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        // change the response message to be the reject message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        invokeAPIAndVerifyResponse(NON_REFERRED_REFUND, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, REJECT_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testNonReferredRefundPending
    * @description NonReferred Refund pending case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testNonReferredRefundPending()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        // change the response message to be the pending message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        invokeAPIAndVerifyResponse(NON_REFERRED_REFUND, transactionParameter, '102', PENDING, null, PENDING_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testNonReferredRefundEmptyDecision
    * @description NonReferred Refund empty decision case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testNonReferredRefundEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        // change the response message to be the empty <decision> message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        invokeAPIAndVerifyResponse(NON_REFERRED_REFUND, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    /**
    * @name testVoidRefundTransactionACHSuccess
    * @description Void Refund ACH success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testVoidRefundTransactionACHSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        invokeAPIAndVerifyResponse(VOID_REFUND_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testVoidRefundTransactionCCSuccess
    * @description Void Refund CC success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testVoidRefundTransactionCCSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        invokeAPIAndVerifyResponse(VOID_REFUND_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testVoidRefundTransactionReject
    * @description Void Refund reject case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testVoidRefundTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the reject message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        invokeAPIAndVerifyResponse(VOID_REFUND_TRANSACTION, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, REJECT_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testVoidRefundTransactionPending
    * @description Void Refund pending case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testVoidRefundTransactionPending()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the pending message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        invokeAPIAndVerifyResponse(VOID_REFUND_TRANSACTION, transactionParameter, '102', PENDING, null, PENDING_MESSAGE, GATEWAY_ID);
    }

    /**
    * @name testVoidRefundTransactionEmptyDecision
    * @description Void Refund empty decision case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testVoidRefundTransactionEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        // change the response message to be the empty <decision> message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        invokeAPIAndVerifyResponse(VOID_REFUND_TRANSACTION, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    /**
    * @name testGetPaymentStatusSuccess
    * @description Payment Status success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testGetPaymentStatusSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        // this api call does not need payment token, so empty it
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        blng.TransactionResult transactionResult = invokeAPIAndVerifyResponse(GET_PAYMENT_STATUS, transactionParameter, '100', SUCCESS, null, SUCCESS_MESSAGE, null);
        System.assertEquals(SUBSCRIPTION_ID, transactionResult.getPaymentToken(), 'Wrong Payment Token');
    }

    /**
    * @name testGetPaymentStatusReject
    * @description Payment Status reject case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testGetPaymentStatusReject()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        // this api call does not need payment token, so empty it
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        // change the response message to be the reject message
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        invokeAPIAndVerifyResponse(GET_PAYMENT_STATUS, transactionParameter, '101', FAILURE, null, REJECT_MESSAGE, null);
    }

    /**
    * @name testGetRefundStatusSuccess
    * @description Refund Status calls Payment Status, so we test one case only
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testGetRefundStatusSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        // this api call does not need payment token, so empty it
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        blng.TransactionResult transactionResult = invokeAPIAndVerifyResponse(GET_REFUND_STATUS, transactionParameter, '100', SUCCESS, null, SUCCESS_MESSAGE, null);
        System.assertEquals(SUBSCRIPTION_ID, transactionResult.getPaymentToken(), 'Wrong Payment Token');
    }

    /**
    * @name testGatewayStatusSuccess
    * @description Tests the Gateway status mapping for the success case
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testGatewayStatusSuccess()
    {
        blng.TransactionResult transactionResult = new blng.TransactionResult();
        transactionResult.setResponseCode('100');
        CyberSourceAPI.populateGatewayStatus(transactionResult);
        System.assertEquals(blng.TransactionResult.GatewayStatusType.Success, transactionResult.getGatewayStatus(), 'Wrong Gateway Status');
    }

    /**
    * @name testGatewayStatusForMissingCode
    * @description Tests the Gateway status mapping for the case where the return code is not configured in the mapper
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testGatewayStatusForMissingCode()
    {
        blng.TransactionResult transactionResult = new blng.TransactionResult();
        transactionResult.setResponseCode('MISSING_CODE');
        CyberSourceAPI.populateGatewayStatus(transactionResult);
        System.assertEquals(blng.TransactionResult.GatewayStatusType.Indeterminate, transactionResult.getGatewayStatus(), 'Wrong Gateway Status');
    }

    /**
    * @name testGatewayStatusForNullCode
    * @description Tests the Gateway status mapping for the case where the return code is null
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    public static testMethod void testGatewayStatusForNullCode()
    {
        blng.TransactionResult transactionResult = new blng.TransactionResult();
        CyberSourceAPI.populateGatewayStatus(transactionResult);
        System.assertEquals(blng.TransactionResult.GatewayStatusType.Indeterminate, transactionResult.getGatewayStatus(), 'Wrong Gateway Status');
    }

    /**
    * @name getConfiguration
    * @description inserts the gateway config data
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    private static List<blng__BillingConfig__c> getConfiguration()
    {
        list<blng__BillingConfig__c> listofConfiguration = new list<blng__BillingConfig__c>();
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'POPULATE_PREFERRED_BILLING_DAY', 
                blng__BooleanValue__c =false , 
                blng__StringValue__c = ''
            )
        );
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'TAX_CALCULATION_BASED_ON', 
                blng__BooleanValue__c = false , 
                blng__StringValue__c = 'Order: Account Billing Address'
            )
        );
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'ADVANCED_AR_APPLICATION', 
                blng__BooleanValue__c = false, 
                blng__StringValue__c = ''
            )
        );
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'ALIGN_BILLDAYOFMONTH_TO_ORDERSTARTDATE', 
                blng__BooleanValue__c = true, 
                blng__StringValue__c = ''
            )
        );
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'SAVE_CREDIT_CARD_ON_PAYMENT_PAGE',
                blng__BooleanValue__c = true
            )
        );
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'ENABLE_STATE_AND_COUNTRY_PICKLIST',
                blng__BooleanValue__c = true
            )
        );
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'USAGE_FLAG_AGGREGATIONBYTRIGGER', 
                blng__BooleanValue__c = true
            )
        );
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'INVOICE_TO_BE_CHARGED_ON', 
                blng__BooleanValue__c = true
            )
        );
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'INSERT_SAMPLE_DATA', 
                blng__BooleanValue__c = false
            )
        );
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'CARD_MAPPING', 
                blng__BooleanValue__c = false
            )
        );
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'PAYMENT_METHOD_DISPLAY', 
                blng__StringValue__c = 'Nickname',
                blng__BooleanValue__c = false
            )
        );
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'INVOICE_DETAIL', 
                blng__StringValue__c = '',
                blng__BooleanValue__c = false
            )
        );
        listofConfiguration.add(
            new blng__BillingConfig__c(
                Name = 'INVOICE_LINE_DETAIL', 
                blng__StringValue__c = '',
                blng__BooleanValue__c = false
            )
        );
        return listofConfiguration;
    }

    /**
    * @name setupData
    * @description
    * inserts config data, then
    * inserts gateway, account, payment method
    * and adds them to the parameter to be passed to the APIs*
    * @Param
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    private static blng.TransactionParameter setupData(String paymentType) {
        insert getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                blng__GatewayType__c = 'CyberSource',
                TestMode__c = true,
                MerchantID__c = 'salesforcebilling',
                MerchantReference__c= 'salesforcebilling',
                TransactionSecurityKey__c= '465456'
        );
        insert gateway;
        Account account = new Account(Name = 'Test Account');
        insert account;

        blng__PaymentMethod__c paymentMethod = new blng__PaymentMethod__c(
                blng__Account__c = account.id,
                blng__PaymentType__c = paymentType,
                blng__BillingEmail__c = 'mani@test.com',
                blng__BillingPhone__c = '650-965-6000',
                blng__BillingFirstName__c = 'Manigandan',
                blng__BillingLastName__c = 'SA',
                blng__BillingCity__c = 'Mountain View',
                blng__BillingStateProvince__c = 'CA',
                blng__BillingZipPostal__c = '60602-1304',
                blng__BillingCountry__c = 'United States',
                blng__PaymentGatewayToken__c = '0138580717791111'
        );
        if (PAYMENTTYPE_CREDITCARD.equals(paymentType)) {
            paymentMethod.blng__CVV__c = '123';
            paymentMethod.blng__CardType__c = 'Mastercard';
            paymentMethod.blng__CardNumber__c = '4111111111111111';
            paymentMethod.blng__CardExpirationYear__c = '2021';
            paymentMethod.blng__CardExpirationMonth__c = '02';
        } else {
            paymentMethod.blng__BankAccountNumber__c='4100';
            paymentMethod.blng__BankAccountName__c='ABC';
            paymentMethod.blng__BankAccountType__c='CHECKING';
            paymentMethod.blng__BankName__c='Test';
            paymentMethod.blng__BankRoutingCode__c='071923284';
        }
        insert paymentMethod;

        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account);
        transactionParameter.setFirstName('Manigandan');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('mani@test.com');
        transactionParameter.setStreet('1295 Charleston Rd.');
        transactionParameter.setCity('Mountain View');
        transactionParameter.setState('CA');
        transactionParameter.setZipCode('60602-1304');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod);
        return transactionParameter;
    }

    /**
    * @name setupDataWithPaymentTransaction
    * @description calls setupData, then inserts PaymentTransaction
    * and adds it to the parameter to be passed to the APIs
    * @Param paymentType
    * @return NA
    * @exception NA
    * @author Lopa
    * @created 2018-06-5
    * @remark
    * @change
    */
    private static blng.TransactionParameter setupDataWithPaymentTransaction(String paymentType) {
        blng.TransactionParameter transactionParameter = setupData(paymentType);
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(
                blng__ResponseStatus__c = 'Approved',
                blng__GatewayID__c= '4961250208446642103009',
                blng__PaymentGateway__c = transactionParameter.getGateWay().Id,
                blng__PaymentMethod__c = transactionParameter.getPaymentMethod().Id,
                blng__RequestTypeOfPayment__c = paymentType,
                blng__Amount__c = 20,
                blng__Type__c = 'Authorization'
        );

        insert paymentTransaction;
        transactionParameter.setTransaction(paymentTransaction);
        return transactionParameter;
    }

    /**
     * @name invokeAPIAndVerifyResponse
     * @description assembles parameter for the callout, makes the api call, asserts
     * returns the TransactionResult for the caller to make further asserts particular to the test cases
     * @param apiMethod
     * @param transactionParameter
     * @param responseCode
     * @param responseToValidate
     * @param responseMessage
     * @param responseCodeMessage
     * @param gatewayId
     * @return NA
     * @exception NA
     * @author Lopa
     * @created 2018-06-5
     * @remark
     * @change
     */
    private static blng.TransactionResult invokeAPIAndVerifyResponse(
            String apiMethod,
            blng.TransactionParameter transactionParameter,
            String responseCode,
            String responseToValidate,
            String responseMessage,
            String responseCodeMessage,
            String gatewayId) {
        Map<String, blng.TransactionParameter> mapOfProcessIdToTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        blng.PaymentGatewayParameter paymentGatewayParameter = new blng.PaymentGatewayParameter();
        paymentGatewayParameter.setTransactionType(apiMethod);

        Test.startTest();
        Map<String, blng.TransactionResult> response = CyberSourceAPI.processPayments(mapOfProcessIdToTransactionParameter, paymentGatewayParameter);
        System.assertNotEquals(0, response.size(), apiMethod + ' should return a transaction result');
        blng.TransactionResult transactionResult = response.values().get(0);

        System.assertEquals(responseCode, transactionResult.getResponseCode(), 'Wrong responseCode');
        System.assertEquals(responseToValidate, transactionResult.getResponseToValidate(), 'Wrong responseToValidate');
        System.assertEquals(responseMessage, transactionResult.getResponseMessage(), 'Wrong responseMessage');
        System.assertEquals(responseCodeMessage, transactionResult.getResponseCodeMessage(), 'Wrong responseCodeMessage');
        System.assertEquals(gatewayId, transactionResult.getGatewayId(), 'Wrong GatewayId');
        if (responseToValidate.equals(SUCCESS)) {
            System.assertEquals(true, transactionResult.getIsSuccess(), 'Wrong IsSuccess');
        } else if (!String.isBlank(responseToValidate)){
            System.assertEquals(false, transactionResult.getIsSuccess(), 'Wrong IsSuccess');
        }

        Test.stopTest();
        return transactionResult;
    }

    @isTest   
    static void installScript() 
    {
        PostInstallClass postinstall = new PostInstallClass();
            system.Test.testInstall(postinstall, null);
        exception e;
    }
}
