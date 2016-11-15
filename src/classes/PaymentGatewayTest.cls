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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantId__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CVV__c = '123', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
    public static testMethod void CyberSourceChargeACHSaving()
    {
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantId__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='Savings',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CVV__c = '123', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='Business Checking',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CVV__c = '123', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CVV__c = '123', blng__CardType__c = 'VISA', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
        insert paymentMethod2;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(blng__ResponseStatus__c = 'Approved' ,blng__GatewayID__c = '123456',blng__PaymentGateway__c=gateway.id,blng__PaymentMethod__c=paymentMethod2.id,blng__Amount__c=20,blng__Type__c='Charge');
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
    public static testMethod void CyberSourcechargeByTokenCCVISA()
    {
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__PaymentGatewayToken__c = '123456321',blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CVV__c = '123', blng__CardType__c = 'VISA', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CVV__c = '123', blng__CardType__c = 'Mastercard', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CVV__c = '123', blng__CardType__c = 'Discover', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CVV__c = '123', blng__CardType__c = 'American Express', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
    public static testMethod void CyberSourceTokenCCVISA()
    {
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CVV__c = '123', blng__CardType__c = 'VISA', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
    public static testMethod void CyberSourceTokenCCMasterCard()
    {
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CVV__c = '123', blng__CardType__c = 'Mastercard', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
    public static testMethod void CyberSourceTokenCCDiscover()
    {
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CVV__c = '123', blng__CardType__c = 'Discover', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CVV__c = '123', blng__CardType__c = 'American Express', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CardType__c = 'VISA', blng__CVV__c = '123', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__PaymentGatewayToken__c = '123456321',  blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CardType__c = 'VISA', blng__CVV__c = '123', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CardType__c = 'Mastercard', blng__CVV__c = '123', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CardType__c = 'Discover', blng__CVV__c = '123', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CardType__c = 'American Express', blng__CVV__c = '123', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CardType__c = 'Visa', blng__CVV__c = '123', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CardType__c = 'Visa', blng__CVV__c = '123', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='Credit Card');
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
            CyberSourceAPI.refundTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizeRefundACH()
    {
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CardType__c = 'Visa', blng__CVV__c = '123', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='ACH');
        insert paymentMethod2;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(blng__ResponseStatus__c = 'Approved' ,blng__GatewayID__c = '123456',blng__PaymentGateway__c=gateway.id,blng__PaymentMethod__c=paymentMethod2.id,blng__Amount__c=20,blng__Type__c='Charge');
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
        transactionParameter.setTransaction(paymentTransaction);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.refundTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
    public static testMethod void CyberSourceAuthorizevoidACH()
    {
        blng__PaymentGateway__c gateway = new blng__PaymentGateway__c(blng__GatewayType__c = 'CyberSource', TestMode__c = true, MerchantID__c = 'salesforcebilling', MerchantReference__c= 'salesforcebilling', TransactionSecurityKey__c= '465456');
        insert gateway; 
        Account account1 = new Account(Name = 'Test Account');
        insert account1;
        blng__PaymentMethod__c paymentMethod1 = new blng__PaymentMethod__c(blng__PaymentType__c= 'ACH', blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__BillingAddress__c = '123',blng__BillingCity__c = 'CA',blng__BillingStateProvince__c = 'California',blng__BillingZipPostal__c = '11111',blng__BillingCountry__c = 'United States',blng__BankAccountNumber__c='4100',blng__BankAccountName__c='ABC',blng__BankAccountType__c='CHECKING',blng__BankName__c='Test',blng__BankRoutingCode__c='071923284');
        insert paymentMethod1;
        blng__PaymentMethod__c paymentMethod2 = new blng__PaymentMethod__c(blng__BillingEmail__c = 'madhu@gmail.com', blng__BillingPhone__c = '9999999', blng__BillingFirstName__c = 'Madhu', blng__BillingLastName__c = 'Kesav', blng__Account__c = account1.id, blng__CardType__c = 'Visa', blng__CVV__c = '123', blng__CardNumber__c = '4111111111111111', blng__CardExpirationYear__c = '2020', blng__CardExpirationMonth__c = '10',blng__BillingAddress__c = 'Prabhat Aracade',blng__BillingCity__c = 'US',blng__BillingStateProvince__c = 'UK',blng__BillingZipPostal__c = '505001',blng__BillingCountry__c = 'United States', blng__PaymentType__c='ACH');
        insert paymentMethod2;
        blng__PaymentTransaction__c paymentTransaction = new blng__PaymentTransaction__c(blng__ResponseStatus__c = 'Approved' ,blng__GatewayID__c = '123456',blng__PaymentGateway__c=gateway.id,blng__PaymentMethod__c=paymentMethod2.id,blng__Amount__c=20,blng__Type__c='Charge');
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
        transactionParameter.setTransaction(paymentTransaction);
        transactionParameter.setPaymentMethod(paymentMethod2);
        Map<String, blng.TransactionParameter> mapOfTransactionParameter = new Map<String, blng.TransactionParameter> {'123'=> transactionParameter};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
            CyberSourceAPI.voidTransaction(mapOfTransactionParameter);
        Test.stopTest();    
    }
}