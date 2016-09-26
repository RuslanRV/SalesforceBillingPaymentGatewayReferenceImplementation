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
    public static testMethod void CyberSourceChargeACHChecking()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantId__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CVV__c = '123', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceChargeACHSaving()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantId__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='Savings',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CVV__c = '123', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceChargeACHBusinessChecking()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='Business Checking',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CVV__c = '123', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceChargeCCVISA()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CVV__c = '123', nxtdev__CardType__c = 'VISA', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceChargeCCMasterCard()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CVV__c = '123', nxtdev__CardType__c = 'Mastercard', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceChargeCCDiscoverCard()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CVV__c = '123', nxtdev__CardType__c = 'Discover', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceChargeCCAmericanExpress()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CVV__c = '123', nxtdev__CardType__c = 'American Express', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.ChargeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceTokenCCVISA()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CVV__c = '123', nxtdev__CardType__c = 'VISA', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
       
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.generateToken(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceTokenCCMasterCard()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CVV__c = '123', nxtdev__CardType__c = 'Mastercard', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
       
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.generateToken(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceTokenCCDiscover()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CVV__c = '123', nxtdev__CardType__c = 'Discover', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
       
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.generateToken(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceTokenCCAmericanExpress()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CVV__c = '123', nxtdev__CardType__c = 'American Express', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
       
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.generateToken(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeCCVISA()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CardType__c = 'VISA', nxtdev__CVV__c = '123', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.authorizeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeCCMasterCard()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CardType__c = 'Mastercard', nxtdev__CVV__c = '123', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.authorizeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeCCDiscover()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CardType__c = 'Discover', nxtdev__CVV__c = '123', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.authorizeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeCCAmericanExpress()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CardType__c = 'American Express', nxtdev__CVV__c = '123', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.authorizeTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    
    public static testMethod void CyberSourceAuthorizeVoid()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CardType__c = 'Visa', nxtdev__CVV__c = '123', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.voidTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    
    public static testMethod void CyberSourceAuthorizeRefund()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CardType__c = 'Visa', nxtdev__CVV__c = '123', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='Credit Card');
        insert paymentMethod2;
        
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.refundTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    
    public static testMethod void CyberSourceAuthorizeRefundACH()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CardType__c = 'Visa', nxtdev__CVV__c = '123', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='ACH');
        insert paymentMethod2;
        nxtdev__PaymentTransaction__c paymentTransaction = new nxtdev__PaymentTransaction__c(nxtdev__ResponseStatus__c = 'Approved' ,nxtdev__GatewayID__c = '123456',nxtdev__PaymentGateway__c=gateway.id,nxtdev__PaymentMethod__c=paymentMethod2.id,nxtdev__Amount__c=20,nxtdev__Type__c='Charge');
        insert paymentTransaction;
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        transactionParameter.setTransaction(paymentTransaction);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.refundTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    
     public static testMethod void CyberSourceAuthorizevoidACH()
    {
        nxtdev__PaymentGateway__c gateway = new nxtdev__PaymentGateway__c(nxtdev__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        nxtdev__PaymentMethod__c paymentMethod1 = new nxtdev__PaymentMethod__c(nxtdev__PaymentType__c= 'ACH', nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__BillingAddress__c = '123',nxtdev__BillingCity__c = 'CA',nxtdev__BillingStateProvince__c = 'California',nxtdev__BillingZipPostal__c = '11111',nxtdev__BillingCountry__c = 'United States',nxtdev__BankAccountNumber__c='4100',nxtdev__BankAccountName__c='ABC',nxtdev__BankAccountType__c='CHECKING',nxtdev__BankName__c='Test',nxtdev__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        nxtdev__PaymentMethod__c paymentMethod2 = new nxtdev__PaymentMethod__c(nxtdev__BillingEmail__c = 'madhu@gmail.com', nxtdev__BillingPhone__c = '9999999', nxtdev__BillingFirstName__c = 'Madhu', nxtdev__BillingLastName__c = 'Kesav', nxtdev__Account__c = account1.id, nxtdev__CardType__c = 'Visa', nxtdev__CVV__c = '123', nxtdev__CardNumber__c = '4111111111111111', nxtdev__CardExpirationYear__c = '2020', nxtdev__CardExpirationMonth__c = '10',nxtdev__BillingAddress__c = 'Prabhat Aracade',nxtdev__BillingCity__c = 'US',nxtdev__BillingStateProvince__c = 'UK',nxtdev__BillingZipPostal__c = '505001',nxtdev__BillingCountry__c = 'United States', nxtdev__PaymentType__c='ACH');
        insert paymentMethod2;
        nxtdev__PaymentTransaction__c paymentTransaction = new nxtdev__PaymentTransaction__c(nxtdev__ResponseStatus__c = 'Approved' ,nxtdev__GatewayID__c = '123456',nxtdev__PaymentGateway__c=gateway.id,nxtdev__PaymentMethod__c=paymentMethod2.id,nxtdev__Amount__c=20,nxtdev__Type__c='Charge');
        insert paymentTransaction;
        nxtdev.TransactionParameter transactionParameter = new nxtdev.TransactionParameter();
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
        transactionParameter.setTransaction(paymentTransaction);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, nxtdev.TransactionParameter> mapOfTransactionParameter = new Map<String, nxtdev.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.voidTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
}