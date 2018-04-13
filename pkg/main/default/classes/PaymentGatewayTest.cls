// ============================================================================================= 
//  Object: TransactionServiceTest 
//  Company: Salesforce
//  Author: Himanshu Kapoor/ Vinod KR/ Devender / Manigandan SA
//  Purpose: Unit test methods to test Cyber Source payment gateway class functionality.
//  Methods: Following are the methods and their one line description
//              --commonTestData - test data set up method to create common data
//              
//  Created: 2016-08-05
// ============================================================================================= 
// Use Cases or Requirements: 
// @UseCase number - @requirement Description       
// ============================================================================================= 
// Changes: @Date Author
//          @Description
// =============================================================================================
@isTest (SeeALLData=false)
private class PaymentGatewayTest
{
    // ============================================================================================= 
    // Author: Manigandan SA
    // Description: 
    // Test Case : TC - 01 
    // API Request : All Valid Data 
    // API Response : Decision:ACCEPT   ReasonCode:100 
    // =============================================================================================
    public static testMethod void CyberSourceTokenCCMasterCard()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
       
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'mani@test.com', 
                                            blng__BillingPhone__c = '650-965-6000', 
                                            blng__BillingFirstName__c = 'Manigandan', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'Mastercard', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2021', 
                                            blng__CardExpirationMonth__c = '02',
                                            blng__BillingCity__c = 'Mountain View',
                                            blng__BillingStateProvince__c = 'CA',
                                            blng__BillingZipPostal__c = '60602-1304',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
       
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
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
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.generateToken(mapOfTransactionParameter);
        Test.stopTest();    
    }
    
    // ============================================================================================= 
    // Author: Manigandan SA
    // Description: 
    // Test Case : TC - 02 
    // API Request : Invalid Card Type
    // API Response :  Decision:REJECT   ReasonCode:102 
    // =============================================================================================
    public static testMethod void InvalidMasterCard()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
       
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'mani@test.com', 
                                            blng__BillingPhone__c = '650-965-6000', 
                                            blng__BillingFirstName__c = 'Manigandan', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'Visa', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2021', 
                                            blng__CardExpirationMonth__c = '02',
                                            blng__BillingCity__c = 'Mountain View',
                                            blng__BillingStateProvince__c = 'CA',
                                            blng__BillingZipPostal__c = '60602-1304',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
       
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
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
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.generateToken(mapOfTransactionParameter);
        Test.stopTest();    
    }
    
    // ============================================================================================= 
    // Author: Manigandan SA
    // Description: 
    // Test Case : TC - 03 
    // API Request : Invalid Card Number
    // API Response :   Decision:REJECT   ReasonCode:231
    // =============================================================================================
    public static testMethod void InvalidCardNumber()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
       
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'mani@test.com', 
                                            blng__BillingPhone__c = '650-965-6000', 
                                            blng__BillingFirstName__c = 'Manigandan', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'Visa', 
                                            blng__CardNumber__c = '4001111111', 
                                            blng__CardExpirationYear__c = '2021', 
                                            blng__CardExpirationMonth__c = '02',
                                            blng__BillingCity__c = 'Mountain View',
                                            blng__BillingStateProvince__c = 'CA',
                                            blng__BillingZipPostal__c = '60602-1304',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
       
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
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
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.generateToken(mapOfTransactionParameter);
        Test.stopTest();    
    }
    
    // ============================================================================================= 
    // Author: Manigandan SA
    // Description: 
    // Test Case : TC - 04 
    // API Request : Expired Card
    // API Response :   Decision:REJECT    ReasonCode:202
    // =============================================================================================
    public static testMethod void ExpiredCard()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
       
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'mani@test.com', 
                                            blng__BillingPhone__c = '650-965-6000', 
                                            blng__BillingFirstName__c = 'Manigandan', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'Visa', 
                                            blng__CardNumber__c = '4001111111', 
                                            blng__CardExpirationYear__c = '2016', 
                                            blng__CardExpirationMonth__c = '02',
                                            blng__BillingCity__c = 'Mountain View',
                                            blng__BillingStateProvince__c = 'CA',
                                            blng__BillingZipPostal__c = '60602-1304',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
       
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
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
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.generateToken(mapOfTransactionParameter);
        Test.stopTest();    
    }
    
    // ============================================================================================= 
    // Author: Manigandan SA
    // Description: 
    // Test Case : TC - 04 
    // API Request : Invalid Email
    // API Response :    Decision:REJECT    ReasonCode:101 
    // =============================================================================================
    public static testMethod void InvalidEmail()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
       
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = '', 
                                            blng__BillingPhone__c = '650-965-6000', 
                                            blng__BillingFirstName__c = 'Manigandan', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'Visa', 
                                            blng__CardNumber__c = '4001111111', 
                                            blng__CardExpirationYear__c = '2021', 
                                            blng__CardExpirationMonth__c = '02',
                                            blng__BillingCity__c = 'Mountain View',
                                            blng__BillingStateProvince__c = 'CA',
                                            blng__BillingZipPostal__c = '60602-1304',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
       
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
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
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.generateToken(mapOfTransactionParameter);
        Test.stopTest();    
    }
    
    public static testMethod void CyberSourceChargeACHChecking()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, MerchantId__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;

        blng__Invoice__c invoice = new blng__Invoice__c (blng__Account__c = account1.Id);
        insert invoice;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod1);
        transactionParameter.setInvoice(invoice);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceChargeACHSaving()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantId__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='Savings',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav',
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod1);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceChargeACHBusinessChecking()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='Business Checking',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod1);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceChargeCCVISA()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'VISA', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(
                                                    blng__ResponseStatus__c = 'Approved' ,
                                                    blng__GatewayID__c = '123456',
                                                    blng__PaymentGateway__c=gateway.id,
                                                    blng__PaymentMethod__c=paymentMethod2.id,
                                                    blng__Amount__c=20,blng__Type__c='Charge'
                                                );
        insert paymentTransaction;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        transactionParameter.setTransaction(paymentTransaction);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceChargeCCLevel3VISA()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'VISA', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(
                                                    blng__ResponseStatus__c = 'Approved' ,
                                                    blng__GatewayID__c = '123456',
                                                    blng__PaymentGateway__c=gateway.id,
                                                    blng__PaymentMethod__c=paymentMethod2.id,
                                                    blng__Amount__c=20,blng__Type__c='Charge'
                                                );
        insert paymentTransaction;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        transactionParameter.setTransaction(paymentTransaction);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            //CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
             CyberSourceUtils.getInstance().generateChargeLevel3XML(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourcechargeByTokenCCVISA()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__PaymentGatewayToken__c = '123456321',
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'VISA', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();
    }
    public static testMethod void CyberSourceChargeCCMasterCard()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                               );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'Mastercard', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceChargeCCDiscoverCard()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'Discover', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceChargeCCAmericanExpress()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'American Express', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
     public static testMethod void CyberSourceCaptureCCAmericanExpress()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__Invoice__c invoice = new blng__Invoice__c (blng__Account__c = account1.Id);
        insert invoice;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'American Express', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(
                                                    blng__ResponseStatus__c = 'Approved',
                                                    blng__GatewayID__c='4961250208446642103009',
                                                    blng__PaymentGateway__c=gateway.id,
                                                    blng__PaymentMethod__c=paymentMethod2.id,
                                                    //blng__RequestTypeOfPayment__c = 'Credit Card',
                                                    blng__Amount__c=20,blng__Type__c='Authorization'
                                                );
        insert paymentTransaction;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setInvoice(invoice);
        //transactionParameter.setPaymentTransaction(paymentTransaction1);
        transactionParameter.setPaymentMethod(paymentMethod2);
        //transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_CREDITCARD
        transactionParameter.setTransaction(paymentTransaction);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        //Map<String, blng.TransactionParameter> mapOfTransactionParameterById = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
             CyberSourceUtils.getInstance().generateCaptureXML(mapOfTransactionParameter);
            
            //CyberSourceAPI.captureTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceCapturelevel3CCAmericanExpress()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__Invoice__c invoice = new blng__Invoice__c (blng__Account__c = account1.Id);
        insert invoice;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'American Express', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(
                                                    blng__ResponseStatus__c = 'Approved',
                                                    blng__GatewayID__c='4961250208446642103009',
                                                    blng__PaymentGateway__c=gateway.id,
                                                    blng__PaymentMethod__c=paymentMethod2.id,
                                                    blng__RequestTypeOfPayment__c = 'Credit Card',
                                                    blng__Amount__c=20,blng__Type__c='Authorization'
            
                                                );
        insert paymentTransaction;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setInvoice(invoice);
        //transactionParameter.setPaymentTransaction(paymentTransaction1);
        transactionParameter.setPaymentMethod(paymentMethod2);
        //transactionParameterToProcess.getTransaction().blng__RequestTypeOfPayment__c == PAYMENTTYPE_CREDITCARD
        transactionParameter.setTransaction(paymentTransaction);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        //Map<String, blng.TransactionParameter> mapOfTransactionParameterById = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
             CyberSourceUtils.getInstance().generateCaptureLevel3XML(mapOfTransactionParameter);
             
            //CyberSourceAPI.captureTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    
    public static testMethod void CyberSourceTokenCCVISA()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'VISA', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
       
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.generateToken(mapOfTransactionParameter);
        Test.stopTest();    
    }
    //start-DL
    public static testMethod void CyberSourceVoidTokenTransaction()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
       
        Account account1 = new Account(Name = 'Test Account');
        insert account1; 
        
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com',
                                            blng__BillingPhone__c = '9999999',
                                            blng__BillingFirstName__c = 'Madhu',
                                            blng__BillingLastName__c = 'Kesav',
                                            blng__Account__c = account1.id,                                           
                                            blng__CardType__c = 'VISA',
                                            blng__CardNumber__c = '4111111111111111',
                                            blng__CardExpirationYear__c = '2020',
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States',
                                            blng__PaymentType__c='Credit Card',
                                            blng__NameonCard__c='vinod',
                                            blng__PaymentGatewayToken__c = '0138580717791111'
                                        );
        insert paymentMethod2;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('Bala');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('100.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.voidTokenTransaction(mapOfTransactionParameter);
        Test.stopTest();
    }
    
    public static testMethod void CyberSourceTokenCCDiscover()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'Discover', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
       
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.generateToken(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceTokenCCAmericanExpress()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardType__c = 'American Express', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
       
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.generateToken(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeCCVISA()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CardType__c = 'VISA', 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.authorizeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeByTokenCCVISA()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__PaymentGatewayToken__c = '123456321',  
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CardType__c = 'VISA', 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.authorizeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeCCMasterCard()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CardType__c = 'Mastercard', 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.authorizeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeCCDiscover()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CardType__c = 'Discover', 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.authorizeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeCCAmericanExpress()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
         
        /*blng__PaymentTransaction__c paymentTransaction = NEW blng__PaymentTransaction__c(
                                                        blng__GatewayID__c = '4974325404976911503008',
                                                        blng__RequestTypeOfPayment__c = 'Credit Card');
        insert paymentTransaction;*/
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CardType__c = 'American Express', 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.authorizeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeVoid()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'madhu@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Madhu', 
                                            blng__BillingLastName__c = 'Kesav', 
                                            blng__Account__c = account1.id, 
                                            blng__CardType__c = 'Visa', 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card');
        insert paymentMethod2;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.voidTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeRefund()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'bala@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Bala', 
                                            blng__BillingLastName__c = 'medoju', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'mani@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Mani', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(
                                                    blng__PaymentGateway__c = gateway.Id, 
                                                    blng__RequestTypeOfPayment__c= 'Credit Card'
                                                );
        insert paymentTransaction;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        transactionParameter.setTransaction(paymentTransaction);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
                           
            CyberSourceAPI.refundTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceVoidRefundTransaction()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'bala@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Bala', 
                                            blng__BillingLastName__c = 'medoju', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'mani@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Mani', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(
                                                    blng__PaymentGateway__c = gateway.Id, 
                                                    blng__RequestTypeOfPayment__c= 'Credit Card',
                                 blng__GatewayID__c='4961250208446642103009'
                                                );
        insert paymentTransaction;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        transactionParameter.setTransaction(paymentTransaction);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceUtils.getInstance().generateVoidRefundXML(mapOfTransactionParameter);            
            //CyberSourceAPI.refundTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeRefundACH()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'bala@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Bala', 
                                            blng__BillingLastName__c = 'medoju', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'mani@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Mani', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(
                                                    blng__PaymentGateway__c = gateway.Id, 
                                                    blng__RequestTypeOfPayment__c= 'ACH'
                                                );
        insert paymentTransaction;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod1);
        transactionParameter.setTransaction(paymentTransaction);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.refundTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }

    /**
     * @name testCyberSourceVoidTransactionForCreditCard
     * @description Method to test Void Transaction For Credit Card
     * @author Raghavendra Reddy
     * @created 2017-05-30
     */
    public static testMethod void testCyberSourceVoidTransactionForCreditCard()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(
                                                    blng__ResponseStatus__c = 'Approved' ,
                                                    blng__PaymentGateway__c=gateway.id,
                                                    blng__Amount__c=20,
                                                    blng__Type__c='Charge',
                                                    blng__RequestTypeOfPayment__c='Credit Card',
                                                    blng__GatewayID__c='4961250208446642103009'
                                                );
        insert paymentTransaction;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setTransaction(paymentTransaction);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.voidTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }

    /**
     * @name testCyberSourceVoidTransactionForCreditCard
     * @description Method to test Void Transaction For ACH
     * @author Raghavendra Reddy
     * @created 2017-05-30
     */
    public static testMethod void testCyberSourceVoidTransactionForACH()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(
                                                    blng__ResponseStatus__c = 'Approved' ,
                                                    blng__PaymentGateway__c=gateway.id,
                                                    blng__Amount__c=20,
                                                    blng__Type__c='Charge',
                                                    blng__RequestTypeOfPayment__c='ACH',
                                                    blng__GatewayID__c='4961250208446642103009'
                                                );
        insert paymentTransaction;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setTransaction(paymentTransaction);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.voidTransaction(mapOfTransactionParameter);
        Test.stopTest();    
        
    }

    /**
     * @name testCyberSourceVoidRefundTransactionForCreditCard
     * @description Method to test Void refund Transaction For Credit Card
     * @author Raghavendra Reddy
     * @created 2017-05-30
     */
    public static testMethod void testCyberSourceVoidRefundTransactionForCreditCard()
    {
        insert PaymentGatewayTest.getConfiguration();  
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        
        Account account1 = new Account(
                        Name = 'Test Account' 
                        //blng__CustomerProfileId__c = '1807887970'
                    );
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'mani@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Mani', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card', 
                                            blng__PaymentGatewayToken__c = '123456789'
                                        );
        insert paymentMethod1;
        blng__PaymentTransaction__c transactionObj = new blng__PaymentTransaction__c(
                                                blng__PaymentGateway__c = gateway.Id, 
                                                blng__PaymentMethod__c = paymentMethod1.Id, 
                                                blng__GatewayID__c = '60012197527', 
                                                blng__ResponseStatus__c = 'Approved', 
                                                blng__ResponseMessage__c = 'Approved', 
                                                blng__Authorization__c = 'blng__Authorization__c'
                                            );
        insert transactionObj;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setTransaction(transactionObj);
        transactionParameter.setPaymentMethod(paymentMethod1);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
         CyberSourceAPI.voidRefundTransaction(mapOfTransactionParameter);
        Test.stopTest();   
    }

    /**
     * @name testCyberSourceVoidRefundTransactionForACH
     * @description Method to test Void refund Transaction For ACH
     * @author Raghavendra Reddy
     * @created 2017-05-30
     */
    public static testMethod void testCyberSourceVoidRefundTransactionForACH()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        
        Account account1 = new Account(
                        Name = 'Test Account' 
                        //blng__CustomerProfileId__c = '1807887970'
                    );
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'bala@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Bala', 
                                            blng__BillingLastName__c = 'medoju', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentTransaction__c transactionObj = new blng__PaymentTransaction__c(
                                                blng__PaymentGateway__c = gateway.Id, 
                                                blng__PaymentMethod__c = paymentMethod1.Id, 
                                                blng__GatewayID__c = '60012197527', 
                                                blng__ResponseStatus__c = 'Approved', 
                                                blng__ResponseMessage__c = 'Approved', 
                                                blng__Authorization__c = 'blng__Authorization__c'
                                            );
        insert transactionObj;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setTransaction(transactionObj);
        transactionParameter.setPaymentMethod(paymentMethod1);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
         CyberSourceAPI.voidRefundTransaction(mapOfTransactionParameter);
        Test.stopTest();   
    }
    public static testMethod void captureTransaction()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
     
        insert gateway; 
        
        Account account1 = new Account(
                        Name = 'Test Account' 
                        //blng__CustomerProfileId__c = '1807887970'
                    );
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'mani@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Mani', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card', 
                                            blng__PaymentGatewayToken__c = '123456789'
                                        );
        insert paymentMethod1;
        blng__PaymentTransaction__c transactionObj = new blng__PaymentTransaction__c(
                                                    blng__PaymentGateway__c = gateway.Id, 
                                                    blng__PaymentMethod__c = paymentMethod1.Id, 
                                                    blng__GatewayID__c = '60012197527', 
                                                    blng__ResponseStatus__c = 'Approved', 
                                                    blng__ResponseMessage__c = 'Approved', 
                                                    blng__Authorization__c = 'blng__Authorization__c'
                                                );
        insert transactionObj;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setTransaction(transactionObj);
        transactionParameter.setPaymentMethod(paymentMethod1);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
         CyberSourceAPI.captureTransaction(mapOfTransactionParameter);
        Test.stopTest(); 
    }
    public static testMethod void cyberSourcegetTransactionDetails()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
     
        insert gateway; 
        Account account1 = new Account(
                        Name = 'Test Account' 
                        //blng__CustomerProfileId__c = '1807887970'
                    );
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'mani@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Mani', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card', 
                                            blng__PaymentGatewayToken__c = '123456789'
                                        );
        insert paymentMethod1;
        
        blng__PaymentTransaction__c transactionObj = new blng__PaymentTransaction__c(
                                                    blng__PaymentGateway__c = gateway.Id, 
                                                    blng__PaymentMethod__c = paymentMethod1.Id, 
                                                    blng__GatewayID__c = '60012197527', 
                                                    blng__ResponseStatus__c = 'Approved', 
                                                    blng__ResponseMessage__c = 'Approved', 
                                                    blng__Authorization__c = 'blng__Authorization__c'
                                                );
        insert transactionObj;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod1);
        transactionParameter.setTransaction(transactionObj);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.getPaymentStatus(mapOfTransactionParameter);
            CyberSourceAPI.getRefundStatus(mapOfTransactionParameter);
        Test.stopTest();   
    }
     public static testMethod void nonReferredRefundForCC()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(
                        Name = 'Test Account' 
                        //blng__CustomerProfileId__c = '1807887970'
                    );
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'mani@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Mani', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States', 
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod1;
        blng__PaymentTransaction__c transactionObj = new blng__PaymentTransaction__c(
                                                    blng__PaymentGateway__c = gateway.Id, 
                                                    blng__PaymentMethod__c = paymentMethod1.Id, 
                                                    blng__GatewayID__c = '60012197527', 
                                                    blng__ResponseStatus__c = 'Approved', 
                                                    blng__ResponseMessage__c = 'Approved', 
                                                    blng__Authorization__c = 'blng__Authorization__c', 
                                                    blng__RequestTypeOfPayment__c= 'Credit Card'
                                                );
        insert transactionObj;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setTransaction(transactionObj);
        transactionParameter.setPaymentMethod(paymentMethod1);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
         CyberSourceAPI.nonReferredRefund(mapOfTransactionParameter);
        Test.stopTest();         
    }
    public static testMethod void CyberSourceNonReferrencedRefund()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(
                        Name = 'Test Account'  
                        //blng__CustomerProfileId__c = '1807887970'
                    );
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'bala@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Bala', 
                                            blng__BillingLastName__c = 'medoju', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='071923284'
                                        );
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(
                                            blng__BillingEmail__c = 'mani@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Mani', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__CVV__c = '123', 
                                            blng__CardNumber__c = '4111111111111111', 
                                            blng__CardExpirationYear__c = '2020', 
                                            blng__CardExpirationMonth__c = '10',
                                            blng__BillingCity__c = 'US',
                                            blng__BillingStateProvince__c = 'UK',
                                            blng__BillingZipPostal__c = '505001',
                                            blng__BillingCountry__c = 'United States',
                                            blng__PaymentGatewayToken__c = '123456789',
                                            blng__PaymentType__c='Credit Card'
                                        );
        insert paymentMethod2;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(
                                                        blng__PaymentGateway__c = gateway.Id, 
                                                        blng__RequestTypeOfPayment__c= 'Credit Card', 
                                                        blng__RequestCreditCardNumber__c= '1111'
                                                    );
        insert paymentTransaction;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setPaymentMethod(paymentMethod2);
        transactionParameter.setTransaction(paymentTransaction);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.nonReferredRefund(mapOfTransactionParameter);
        Test.stopTest();        
    }
    public static testMethod void nonReferredRefundForACH()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(
                        Name = 'Test Account' 
                        //blng__CustomerProfileId__c = '1807887970'
                    );
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'mani@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Mani', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='12345678',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='CHECKING',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='125000024'
                                        );
        insert paymentMethod1;
        blng__PaymentTransaction__c transactionObj = new blng__PaymentTransaction__c(
                                                    blng__PaymentGateway__c = gateway.Id, 
                                                    blng__PaymentMethod__c = paymentMethod1.Id, 
                                                    blng__GatewayID__c = '60012197527', 
                                                    blng__ResponseStatus__c = 'Approved', 
                                                    blng__ResponseMessage__c = 'Approved', 
                                                    blng__Authorization__c = 'blng__Authorization__c', 
                                                    blng__RequestTypeOfPayment__c= 'ACH'
                                                );
        insert transactionObj;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setTransaction(transactionObj);
        transactionParameter.setPaymentMethod(paymentMethod1);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
         CyberSourceAPI.nonReferredRefund(mapOfTransactionParameter);
        Test.stopTest();      
    }
    public static testMethod void nonReferredRefundForACHBusinessChecking()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        
        Account account1 = new Account(
                        Name = 'Test Account' 
                        //blng__CustomerProfileId__c = '1807887970'
                    );
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'mani@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Mani', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='12345678',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='Business Checking',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='125000024'
                                        );
        insert paymentMethod1;
        blng__PaymentTransaction__c transactionObj = new blng__PaymentTransaction__c(
                                                    blng__PaymentGateway__c = gateway.Id, 
                                                    blng__PaymentMethod__c = paymentMethod1.Id, 
                                                    blng__GatewayID__c = '60012197527', 
                                                    blng__ResponseStatus__c = 'Approved', 
                                                    blng__ResponseMessage__c = 'Approved', 
                                                    blng__Authorization__c = 'blng__Authorization__c', 
                                                    blng__RequestTypeOfPayment__c= 'ACH'
                                                );
        insert transactionObj;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setTransaction(transactionObj);
        transactionParameter.setPaymentMethod(paymentMethod1);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
         CyberSourceAPI.nonReferredRefund(mapOfTransactionParameter);
        Test.stopTest();      
    }
    public static testMethod void nonReferredRefundForACHSavings()
    {
        insert PaymentGatewayTest.getConfiguration();
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(
                                    blng__GatewayType__c = 'CyberSource', 
                                    TestMode__c = true, 
                                    MerchantID__c = 'salesforcebilling', 
                                    MerchantReference__c= 'salesforcebilling', 
                                    TransactionSecurityKey__c= '465456'
                                );
        insert gateway; 
        Account account1 = new Account(
                        Name = 'Test Account' 
                        //blng__CustomerProfileId__c = '1807887970'
                    );
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(
                                            blng__PaymentType__c= 'ACH', 
                                            blng__BillingEmail__c = 'mani@gmail.com', 
                                            blng__BillingPhone__c = '9999999', 
                                            blng__BillingFirstName__c = 'Mani', 
                                            blng__BillingLastName__c = 'SA', 
                                            blng__Account__c = account1.id, 
                                            blng__BillingCity__c = 'CA',
                                            blng__BillingStateProvince__c = 'California',
                                            blng__BillingZipPostal__c = '11111',
                                            blng__BillingCountry__c = 'United States',
                                            blng__BankAccountNumber__c='12345678',
                                            blng__BankAccountName__c='ABC',
                                            blng__BankAccountType__c='Savings',
                                            blng__BankName__c='Test',
                                            blng__BankRoutingCode__c='125000024'
                                        );
        insert paymentMethod1;
        blng__PaymentTransaction__c transactionObj = new blng__PaymentTransaction__c(
                                                    blng__PaymentGateway__c = gateway.Id, 
                                                    blng__PaymentMethod__c = paymentMethod1.Id, 
                                                    blng__GatewayID__c = '60012197527', 
                                                    blng__ResponseStatus__c = 'Approved', 
                                                    blng__ResponseMessage__c = 'Approved', 
                                                    blng__Authorization__c = 'blng__Authorization__c', 
                                                    blng__RequestTypeOfPayment__c= 'ACH'
                                                );
        insert transactionObj;
        blng.TransactionParameter transactionParameter = new blng.TransactionParameter();
        transactionParameter.SetAccount(account1);
        transactionParameter.setFirstName('ManiGandanSA');
        transactionParameter.setLastName('SA');
        transactionParameter.setEmailId('m1@g.com');
        transactionParameter.setStreet('12');
        transactionParameter.setCity('CA');
        transactionParameter.setState('California');
        transactionParameter.setZipCode('11111');
        transactionParameter.setCountry('United States');
        transactionParameter.setPhone('111');
        transactionParameter.setCurrencyId('USD');
        transactionParameter.setAmount('1.00');
        transactionParameter.setGateWay(gateway);
        transactionParameter.setTransaction(transactionObj);
        transactionParameter.setPaymentMethod(paymentMethod1);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
         CyberSourceAPI.nonReferredRefund(mapOfTransactionParameter);
        Test.stopTest();      
    }
    public static List<blng__BillingConfig__c> getConfiguration() 
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
    @isTest   
    static void installScript() 
    {
        PostInstallClass postinstall = new PostInstallClass();
            system.Test.testInstall(postinstall, null);
        exception e;
    }
}