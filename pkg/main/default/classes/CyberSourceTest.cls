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
     * validate one of the failures to make sure the customer validation works
     * TODO this will change after we implement the service improvements
     */
    public static testMethod void ValidateCustomerFailure()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        //overwrite from setup
        transactionParameter.setFirstName('');
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        blng.PaymentGatewayParameter paymentGatewayParameter = new blng.PaymentGatewayParameter();
        paymentGatewayParameter.setTransactionType(GENERATE_TOKEN);
        Test.startTest();
        Map<String, blng.TransactionResult> response = CyberSourceAPI.processPayments(mapOfTransactionParameter, paymentGatewayParameter);
        if(response.size() > 0) {
            blng.TransactionResult transactionResult = response.values().get(0);
            System.assertEquals(1, transactionResult.getErrors().size());
            System.assertEquals('First Name is missing', transactionResult.getErrors().get(0));
        }
        Test.stopTest();
    }

    // generate token tests
    public static testMethod void GenerateTokenSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        callAndVerify(GENERATE_TOKEN, transactionParameter, '100', SUCCESS, null, SUCCESS_MESSAGE, null);
    }

    public static testMethod void GenerateTokenReject()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        callAndVerify(GENERATE_TOKEN, transactionParameter, '101', FAILURE, null, REJECT_MESSAGE, null);
    }

    public static testMethod void GenerateTokenMissingEmail()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        transactionParameter.getPaymentMethod().blng__BillingEmail__c = '';
        blng.TransactionResult transactionResult = callAndVerify(GENERATE_TOKEN, transactionParameter, 'ERROR', FAILURE, FAILURE, 'Missing Information: Email', null);
        System.assertEquals(blng.TransactionResult.GatewayStatusType.ValidationError, transactionResult.getGatewayStatus());
    }

    // void token tests
    public static testMethod void VoidTokenTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_ACH);
        callAndVerify(VOID_TOKEN_TRANSACTION, transactionParameter, '100', SUCCESS, null, SUCCESS_MESSAGE, null);
    }

    public static testMethod void VoidTokenTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        callAndVerify(VOID_TOKEN_TRANSACTION, transactionParameter, '101', FAILURE, null, REJECT_MESSAGE, null);
    }

    // authorize transaction tests
    public static testMethod void AuthorizeTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        callAndVerify(AUTHORIZE_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void AuthorizeTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        callAndVerify(AUTHORIZE_TRANSACTION, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, REJECT_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void AuthorizeTransactionPending()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        callAndVerify(AUTHORIZE_TRANSACTION, transactionParameter, '102', PENDING, null, PENDING_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void AuthorizeTransactionEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        callAndVerify(AUTHORIZE_TRANSACTION, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    // capture transaction tests
    public static testMethod void CaptureTransactionACHSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        callAndVerify(CAPTURE_TRANSACTION, transactionParameter, '100', SUCCESS, SUCCESS, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void CaptureTransactionCCSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        blng__Invoice__c invoice = new blng__Invoice__c (blng__Account__c = transactionParameter.getAccount().Id);
        insert invoice;
        transactionParameter.setInvoice(invoice);
        callAndVerify(CAPTURE_TRANSACTION, transactionParameter, '100', SUCCESS, SUCCESS, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void CaptureTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        callAndVerify(CAPTURE_TRANSACTION, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, REJECT_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void CaptureTransactionPending()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        callAndVerify(CAPTURE_TRANSACTION, transactionParameter, '102', PENDING, null, PENDING_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void CaptureTransactionEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        callAndVerify(CAPTURE_TRANSACTION, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    /**
     * generateCaptureLevel3XML() method is called when the config for
     * INVOICE_DETAIL has the name of a TextArea field in blng__StringValue__c.
     * Invoice__c does not have a TextArea, but a customer can add one.
     * Since we cannot add a new field in the test, we will call this method directly
     */
    public static testMethod void CaptureTransactionLevel3XML()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        blng__Invoice__c invoice = new blng__Invoice__c (blng__Account__c = transactionParameter.getAccount().Id);
        insert invoice;
        transactionParameter.setInvoice(invoice);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.startTest();
        CyberSourceUtils.getInstance().generateCaptureLevel3XML(mapOfTransactionParameter);
        System.assertNotEquals(null, transactionParameter.getRequestBody(), 'Request body should be populated');
        Test.stopTest();
    }

    /**
     * generateChargeLevel3XML() method is called when the config for
     * INVOICE_DETAIL has the name of a TextArea field in blng__StringValue__c.
     * Invoice__c does not have a TextArea, but a customer can add one.
     * Since we cannot add a new field in the test, we will call this method directly
     */
    public static testMethod void ChargeTransactionLevel3XML()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        blng__Invoice__c invoice = new blng__Invoice__c (blng__Account__c = transactionParameter.getAccount().Id);
        insert invoice;
        transactionParameter.setInvoice(invoice);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.startTest();
        CyberSourceUtils.getInstance().generateChargeLevel3XML(mapOfTransactionParameter);
        System.assertNotEquals(null, transactionParameter.getRequestBody(), 'Request body should be populated');
        Test.stopTest();
    }

    // charge transaction tests
    public static testMethod void ChargeTransactionMissingEmail()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        transactionParameter.getPaymentMethod().blng__BillingEmail__c = '';
        blng.TransactionResult transactionResult = callAndVerify(CHARGE_TRANSACTION, transactionParameter, 'ERROR', EMAIL_MISSING, EMAIL_MISSING, 'Missing Information: Email', NULL);
        System.assertEquals(blng.TransactionResult.GatewayStatusType.ValidationError, transactionResult.getGatewayStatus());
    }

    public static testMethod void ChargeTransactionACHSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_ACH);
        callAndVerify(CHARGE_TRANSACTION, transactionParameter, '100', SUCCESS, SUCCESS, INVALID_FIELD_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void ChargeTransactionCCnoPayTxnSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        callAndVerify(CHARGE_TRANSACTION, transactionParameter, '100', SUCCESS, SUCCESS, INVALID_FIELD_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void ChargeTransactionCCwithPayTxnSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        callAndVerify(CHARGE_TRANSACTION, transactionParameter, '100', SUCCESS, SUCCESS, INVALID_FIELD_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void ChargeTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        callAndVerify(CHARGE_TRANSACTION, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, INVALID_FIELD_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void ChargeTransactionPending()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        callAndVerify(CHARGE_TRANSACTION, transactionParameter, '102', PENDING, null, null, GATEWAY_ID);
    }

    public static testMethod void ChargeTransactionEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        callAndVerify(CHARGE_TRANSACTION, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }
    
    // Void transaction tests
    public static testMethod void VoidTransactionACHSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        callAndVerify(VOID_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void VoidTransactionCCSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        callAndVerify(VOID_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void VoidTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        callAndVerify(VOID_TRANSACTION, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, REJECT_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void VoidTransactionPending()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        callAndVerify(VOID_TRANSACTION, transactionParameter, '102', PENDING, null, PENDING_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void VoidTransactionEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        callAndVerify(VOID_TRANSACTION, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    // refund tests
    public static testMethod void RefundTransactionACHSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        callAndVerify(REFUND_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void RefundTransactionCCPaymentTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        callAndVerify(REFUND_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void RefundTransactionCCSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        callAndVerify(REFUND_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void RefundTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        callAndVerify(REFUND_TRANSACTION, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, REJECT_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void RefundTransactionPending()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        callAndVerify(REFUND_TRANSACTION, transactionParameter, '102', PENDING, null, PENDING_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void RefundTransactionEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        callAndVerify(REFUND_TRANSACTION, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    //NonReferredRefund tests
    public static testMethod void NonReferredRefundACHPaymentTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        callAndVerify(NON_REFERRED_REFUND, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void NonReferredRefundACHPaymentMethodSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_ACH);
        callAndVerify(NON_REFERRED_REFUND, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void NonReferredRefundCCPaymentTransactionSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        callAndVerify(NON_REFERRED_REFUND, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void NonReferredRefundCCPaymentMethodSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        callAndVerify(NON_REFERRED_REFUND, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void NonReferredRefundReject()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        callAndVerify(NON_REFERRED_REFUND, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, REJECT_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void NonReferredRefundPending()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        callAndVerify(NON_REFERRED_REFUND, transactionParameter, '102', PENDING, null, PENDING_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void NonReferredRefundEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        callAndVerify(NON_REFERRED_REFUND, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    //Void Refund Transaction tests
    public static testMethod void VoidRefundTransactionACHSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        callAndVerify(VOID_REFUND_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void VoidRefundTransactionCCSuccess()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_CREDITCARD);
        callAndVerify(VOID_REFUND_TRANSACTION, transactionParameter, '100', SUCCESS, INVALID_FIELD_MESSAGE, SUCCESS_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void VoidRefundTransactionReject()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        callAndVerify(VOID_REFUND_TRANSACTION, transactionParameter, '101', FAILURE, INVALID_FIELD_MESSAGE, REJECT_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void VoidRefundTransactionPending()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_PENDING;
        callAndVerify(VOID_REFUND_TRANSACTION, transactionParameter, '102', PENDING, null, PENDING_MESSAGE, GATEWAY_ID);
    }

    public static testMethod void VoidRefundTransactionEmptyDecision()
    {
        blng.TransactionParameter transactionParameter = setupDataWithPaymentTransaction(PAYMENTTYPE_ACH);
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_EMPTY_DECISION;
        callAndVerify(VOID_REFUND_TRANSACTION, transactionParameter, '103', '', null, null, GATEWAY_ID);
    }

    //GetPaymentStatus tests
    public static testMethod void GetPaymentStatusSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        callAndVerify(GET_PAYMENT_STATUS, transactionParameter, '100', SUCCESS, null, SUCCESS_MESSAGE, null);
    }

    public static testMethod void GetPaymentStatusReject()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        CyberSource.TEST_REQUEST_BODY_CYBER_SOURCE = TEST_REQUEST_BODY_REJECT;
        callAndVerify(GET_PAYMENT_STATUS, transactionParameter, '101', FAILURE, null, REJECT_MESSAGE, null);
    }

    //GetRefundStatus calls GetPaymentStatus
    public static testMethod void GetRefundStatusSuccess()
    {
        blng.TransactionParameter transactionParameter = setupData(PAYMENTTYPE_CREDITCARD);
        transactionParameter.getPaymentMethod().blng__PaymentGatewayToken__c = '';
        callAndVerify(GET_REFUND_STATUS, transactionParameter, '100', SUCCESS, null, SUCCESS_MESSAGE, null);
    }

    /**
     * Tests the Gateway status mapping for the success case
     */
    public static testMethod void GatewayStatusSuccess()
    {
        blng.TransactionResult transactionResult = new blng.TransactionResult();
        transactionResult.setResponseCode('100');
        CyberSourceAPI.populateGatewayStatus(transactionResult);
        System.assertEquals(blng.TransactionResult.GatewayStatusType.Success, transactionResult.getGatewayStatus());
    }
    /**
     * Tests the Gateway status mapping for the case where the return code is not configured in the mapper
     */
    public static testMethod void GatewayStatusMissingCode()
    {
        blng.TransactionResult transactionResult = new blng.TransactionResult();
        transactionResult.setResponseCode('MISSING_CODE');
        CyberSourceAPI.populateGatewayStatus(transactionResult);
        System.assertEquals(blng.TransactionResult.GatewayStatusType.Indeterminate, transactionResult.getGatewayStatus());
    }
    /**
     * Tests the Gateway status mapping for the case where the return code is null
     */
    public static testMethod void GatewayStatusNullCode()
    {
        blng.TransactionResult transactionResult = new blng.TransactionResult();
        CyberSourceAPI.populateGatewayStatus(transactionResult);
        System.assertEquals(blng.TransactionResult.GatewayStatusType.Indeterminate, transactionResult.getGatewayStatus());
    }

    /**
     * inserts the config data
     *
     * @return
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
     * inserts config data, then
     * inserts gateway, account, payment method
     * and adds them to the parameter to be passed to the APIs
     * @param paymentType
     *
     * @return
     */
    private static blng.TransactionParameter setupData(String paymentType) {
        insert CyberSourceTest.getConfiguration();
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
                blng__BillingEmail__c = 'mani@test.com',
                blng__BillingPhone__c = '650-965-6000',
                blng__BillingFirstName__c = 'Manigandan',
                blng__BillingLastName__c = 'SA',
                blng__Account__c = account.id,
                blng__CVV__c = '123',
                blng__CardType__c = 'Mastercard',
                blng__CardNumber__c = '4111111111111111',
                blng__CardExpirationYear__c = '2021',
                blng__CardExpirationMonth__c = '02',
                blng__BillingCity__c = 'Mountain View',
                blng__BillingStateProvince__c = 'CA',
                blng__BillingZipPostal__c = '60602-1304',
                blng__BillingCountry__c = 'United States',
                blng__PaymentGatewayToken__c = '0138580717791111',
                blng__PaymentType__c = paymentType,
                blng__BankAccountNumber__c='4100',
                blng__BankAccountName__c='ABC',
                blng__BankAccountType__c='CHECKING',
                blng__BankName__c='Test',
                blng__BankRoutingCode__c='071923284'
        );
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
     * calls setupData, then inserts PaymentTransaction
     * and adds it to the parameter to be passed to the APIs
     * @param paymentType
     *
     * @return
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
     * assembles rapameters for the callout, makes the api call, asserts
     * returns the TransactionResult for the caller to make further asserts particular to the test cases
     *
     * @param apiMethod
     * @param transactionParameter
     * @param responseCode
     * @param responseToValidate
     * @param responseMessage
     * @param responseCodeMessage
     * @param gatewayId
     *
     * @return
     */
    private static blng.TransactionResult callAndVerify(
            String apiMethod,
            blng.TransactionParameter transactionParameter,
            String responseCode,
            String responseToValidate,
            String responseMessage,
            String responseCodeMessage,
            String gatewayId) {
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        blng.PaymentGatewayParameter paymentGatewayParameter = new blng.PaymentGatewayParameter();
        paymentGatewayParameter.setTransactionType(apiMethod);

        Test.startTest();
        Map<String, blng.TransactionResult> response = CyberSourceAPI.processPayments(mapOfTransactionParameter, paymentGatewayParameter);
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
