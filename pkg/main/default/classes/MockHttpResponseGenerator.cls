// ============================================================================================= 
//  Object: MockHttpResponseGenerator 
//  Company: Salesforce
//  Author: Himanshu Kapoor/ Vinod KR/ Devender
//  Purpose: Contains Mock Test methods for HTTP Request and Response
//  Methods: Following are the methods and one line description
//              --respond - Return HTTP Response
//  Created: 2016-07-09
// ============================================================================================= 
//  Use Cases or Requirements: 
//  @UseCase number - @requirement Description      
// ============================================================================================= 
//  Changes: @Date Author
//           @Description
// ============================================================================================= 

@isTest
public class MockHttpResponseGenerator implements HttpCalloutMock
{
    final String TEST_REQUEST_BODY = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"><s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><GetTaxResponse xmlns="http://avatax.avalara.com/services"><GetTaxResult><TransactionId>4750408166723020</TransactionId><ResultCode>Success</ResultCode><DocId>148583416</DocId><DocType>SalesInvoice</DocType><DocCode>INV003</DocCode><DocDate>2014-01-01</DocDate><DocStatus>Saved</DocStatus><Reconciled>false</Reconciled><Timestamp>2016-01-21T11:46:56.673</Timestamp><TotalAmount>5000</TotalAmount><TotalDiscount>0</TotalDiscount><TotalExemption>5000</TotalExemption><TotalTaxable>0</TotalTaxable><TotalTax>0</TotalTax><TotalTaxCalculated>0</TotalTaxCalculated><HashCode>0</HashCode><TaxLines><TaxLine><No>1</No><TaxCode>NT</TaxCode><Taxability>true</Taxability><BoundaryLevel>Address</BoundaryLevel><Exemption>5000</Exemption><Discount>0</Discount><Taxable>0</Taxable><Rate>0</Rate><Tax>0</Tax><TaxCalculated>0</TaxCalculated><TaxIncluded>false</TaxIncluded><TaxDetails><TaxDetail><Country>US</Country><Region>CA</Region><JurisType>State</JurisType><JurisCode>06</JurisCode><TaxType>Sales</TaxType><Base>0</Base><Taxable>0</Taxable><Rate>0</Rate><Tax>0</Tax><TaxCalculated>0</TaxCalculated><NonTaxable>5000</NonTaxable><Exemption>0</Exemption><JurisName>CALIFORNIA</JurisName><TaxName>CA STATE TAX</TaxName><TaxAuthorityType>45</TaxAuthorityType><TaxGroup/><RateType>G</RateType><StateAssignedNo/></TaxDetail></TaxDetails><ExemptCertId>0</ExemptCertId><TaxDate>2014-01-01</TaxDate><ReportingDate>2014-01-01</ReportingDate><AccountingMethod>Accrual</AccountingMethod></TaxLine></TaxLines><TaxAddresses><TaxAddress><Address>45 Fremont Street</Address><AddressCode>0</AddressCode><BoundaryLevel>0</BoundaryLevel><City>San Francisco</City><Country>US</Country><PostalCode>94105-2204</PostalCode><Region>CA</Region><TaxRegionId>2113460</TaxRegionId><JurisCode>0607500000</JurisCode><Latitude>37.791119</Latitude><Longitude>-122.397366</Longitude><GeocodeType>StreetLevel</GeocodeType><ValidateStatus>NormalHit</ValidateStatus><DistanceToBoundary>0</DistanceToBoundary></TaxAddress></TaxAddresses><Locked>false</Locked><AdjustmentReason>0</AdjustmentReason><AdjustmentDescription/><Version>1</Version><TaxDate>2014-01-01</TaxDate><TaxSummary/><VolatileTaxRates>false</VolatileTaxRates></GetTaxResult></GetTaxResponse></s:Body></s:Envelope>';
    public HTTPResponse respond(HTTPRequest req) 
    {
        HttpResponse res = new HttpResponse();
        res.setBody(TEST_REQUEST_BODY);
        res.setStatusCode(200);
        return res;
    }
}