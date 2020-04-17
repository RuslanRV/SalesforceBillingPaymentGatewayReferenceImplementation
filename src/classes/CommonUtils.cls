/*
 * Copyright (c) 2020, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root
 * https://github.com/forcedotcom/SalesforceBillingPaymentGatewayReferenceImplementation/blob/master/LICENSE.txt 
 */
// ============================================================================================= 
// Object: CommonUtils
// Company: Salesforce
// Author: Himanshu Kapoor/Vinod KR/Devender/Manigandan SA
// Purpose: This utility class should inlucde all the methods which can be invoked/common shared by different Apex classes
//  • isProduction()
//  • getRecordTypeId()
//  • getCurrencyRate()
//Created: 2016-05-18
// ============================================================================================= 
// Changes: 
//
// ============================================================================================ 
public class CommonUtils {
    // ============================================================================
    // CONSTANT 
    // ============================================================================
    private static final Date REFERENCE_DATE = DateTime.valueOfGmt('2009-03-8 00:00:00').dateGMT();
    public static final String SOQL_ID = 'ID';
    public static final String VF_CONTEXT = 'VF';
    public static final String API_CONTEXT = 'API';
    public static final String ASYNC_CONTEXT = 'ASYNC';
    public static final String PRICE_FORMAT_TIERED = 'Tiered Pricing';
    public static final String PRICE_FORMAT_VOLUME = 'Volume Pricing';
    public static final String PRICE_FORMAT_PER_UNIT = 'Per Unit Pricing';
    public static final String PRICE_FORMAT_FLAT_FEE = 'Flat Fee Pricing';
    public static final String PRICING_METHOD_BLOCK = 'Block';
    public static final String CURRENCYISOCODE = 'CurrencyIsoCode';
    public static final String RANGE = 'Range';
    public static final String SLAB = 'Slab';
    public static final String AMOUNT = 'Amount';
    public static String CURRENT_CONTEXT;
    public static map<String, Id> recordTypeMap;
    private static boolean firstRun = true; 
    public static final String TEST_REQUEST_BODY = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"><s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><GetTaxResponse xmlns="http://avatax.avalara.com/services"><GetTaxResult><TransactionId>4750408166723020</TransactionId><ResultCode>Success</ResultCode><DocId>148583416</DocId><DocType>SalesInvoice</DocType><DocCode>INV003</DocCode><DocDate>2014-01-01</DocDate><DocStatus>Saved</DocStatus><Reconciled>false</Reconciled><Timestamp>2016-01-21T11:46:56.673</Timestamp><TotalAmount>5000</TotalAmount><TotalDiscount>0</TotalDiscount><TotalExemption>5000</TotalExemption><TotalTaxable>0</TotalTaxable><TotalTax>0</TotalTax><TotalTaxCalculated>0</TotalTaxCalculated><HashCode>0</HashCode><TaxLines><TaxLine><No>1</No><TaxCode>NT</TaxCode><Taxability>true</Taxability><BoundaryLevel>Address</BoundaryLevel><Exemption>5000</Exemption><Discount>0</Discount><Taxable>0</Taxable><Rate>0</Rate><Tax>0</Tax><TaxCalculated>0</TaxCalculated><TaxIncluded>false</TaxIncluded><TaxDetails><TaxDetail><Country>US</Country><Region>CA</Region><JurisType>State</JurisType><JurisCode>06</JurisCode><TaxType>Sales</TaxType><Base>0</Base><Taxable>0</Taxable><Rate>0</Rate><Tax>0</Tax><TaxCalculated>0</TaxCalculated><NonTaxable>5000</NonTaxable><Exemption>0</Exemption><JurisName>CALIFORNIA</JurisName><TaxName>CA STATE TAX</TaxName><TaxAuthorityType>45</TaxAuthorityType><TaxGroup/><RateType>G</RateType><StateAssignedNo/></TaxDetail></TaxDetails><ExemptCertId>0</ExemptCertId><TaxDate>2014-01-01</TaxDate><ReportingDate>2014-01-01</ReportingDate><AccountingMethod>Accrual</AccountingMethod></TaxLine></TaxLines><TaxAddresses><TaxAddress><Address>45 Fremont Street</Address><AddressCode>0</AddressCode><BoundaryLevel>0</BoundaryLevel><City>San Francisco</City><Country>US</Country><PostalCode>94105-2204</PostalCode><Region>CA</Region><TaxRegionId>2113460</TaxRegionId><JurisCode>0607500000</JurisCode><Latitude>37.791119</Latitude><Longitude>-122.397366</Longitude><GeocodeType>StreetLevel</GeocodeType><ValidateStatus>NormalHit</ValidateStatus><DistanceToBoundary>0</DistanceToBoundary></TaxAddress></TaxAddresses><Locked>false</Locked><AdjustmentReason>0</AdjustmentReason><AdjustmentDescription/><Version>1</Version><TaxDate>2014-01-01</TaxDate><TaxSummary/><VolatileTaxRates>false</VolatileTaxRates></GetTaxResult></GetTaxResponse></s:Body></s:Envelope>';                                                         
}
