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
    public HTTPResponse respond(HTTPRequest req) 
    {
        HttpResponse res = new HttpResponse();
        res.setBody(CyberSourceCommonUtils.TEST_REQUEST_BODY);
        res.setStatusCode(200);
        return res;
    }
}