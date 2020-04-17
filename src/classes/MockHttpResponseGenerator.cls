/*
 * Copyright (c) 2020, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root
 * https://github.com/forcedotcom/SalesforceBillingPaymentGatewayReferenceImplementation/blob/master/LICENSE.txt 
 */
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
        res.setBody(CommonUtils.TEST_REQUEST_BODY);
        res.setStatusCode(200);
        return res;
    }
}
