// ============================================================================================= 
//  Object: HttpService
//  Company: Salesforce
//  Author:Himanshu Kapoor/ Vinod KR/ Devender / Manigandan SA
//  Purpose: Http Generic Class 
//  Methods: Following are the methods and one line description
//           --getInstance - Method to create an instance of Http Service class - Singleton         
//  Created: 2016-06-16
// ============================================================================================= 
// Use Cases or Requirements: 
// @UseCase number - @requirement Description       
// ============================================================================================= 
// Changes: @Date Author
//          @Description
// ============================================================================================= 

public with sharing class HttpService 
{   
    
    // ============================================================================
    // CONSTANT 
    // ============================================================================
    
    // ============================================================================
    // STATIC VARIABLES
    // ============================================================================
    
    // Attribute to implement singleton pattern for Order Product Service class
    private static HttpService httpServiceInstance;
    
    // ============================================================================
    // VARIABLES
    // ============================================================================
    
    private HttpResponse httpResponse;
    private Map<String,String> mapOfHeaderParameter = new Map<String,String>();
    private enum Method {GET, POST}
    
    /**
* @name getInstance
* @description get an Instance of Service class
* @params NA
* @return Http Service Class Instance
* @exception To do
* @author Himanshu Kapoor/ Vinod KR
* @created 2016-06-16
* @remark 
* @change
*/ 
    public static HttpService getInstance() 
    {
        if (NULL == httpServiceInstance) 
        {
            httpServiceInstance =  new HttpService();  
        }
        return httpServiceInstance;
    }
    
    /**
* @name get
* @description Get Method to get a HTTP request
* @param endPoint
* @return 
* @exception
* @author Himanshu Kapoor/ Vinod KR
* @created 2016-06-16
* @remark 
* @change
*/    
    public void get(String endPoint) 
    {
        send(newRequest(Method.GET, endPoint));
    }
    
    /**
* @name post
* @description Post Method to Post a HTTP request
* @param endPoint and requestBody
* @return 
* @exception
* @author Himanshu Kapoor/ Vinod KR
* @created 2016-06-16
* @remark 
* @change
*/ 
    public void post(String endPoint, String requestBody)
    {
        send(newRequest(Method.POST, endPoint, requestBody));
    }
    
    /**
* @name addHeader
* @description addHeader Methods to add all the defualt Header's required fo rthe request
* @param name and value
* @return 
* @exception
* @author Himanshu Kapoor/ Vinod KR
* @created 2016-06-16
* @remark 
* @change
*/
    public void addHeader(String name, String value)
    {
        mapOfHeaderParameter.put(name, value);
    }
    
    /**
* @name setHeader
* @description setHeader Methods to set setHeader for the request
* @param request
* @return 
* @exception
* @author Himanshu Kapoor/ Vinod KR
* @created 2016-06-16
* @remark 
* @change
*/
    private void setHeader(HttpRequest request) 
    {
        for(String headerValue : mapOfHeaderParameter.keySet())
        {
            request.setHeader(headerValue, mapOfHeaderParameter.get(headerValue));
        }
    }
    
    /**
* @name setAuthorizationHeader
* @description setAuthorizationHeader Methods to set Authorization Header for the request
* @param userName and password
* @return 
* @exception
* @author Himanshu Kapoor/ Vinod KR
* @created 2016-06-22
* @remark 
* @change
*/
    public void setAuthorizationHeader(String userName,String password) 
    {
        if(String.isNotBlank(userName) && String.isNotBlank(password))
        {
            Blob headerValue = blob.valueOf(userName + ':' + password);
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            addHeader('Authorization', authorizationHeader);
        }
    }
    
    /**
* @name setTokenisationHeader
* @description setTokenisationHeader Methods to set Tokenisation Header for the request
* @param userName and password
* @return 
* @exception
* @author Himanshu Kapoor/ Vinod KR
* @created 2016-07-15
* @remark 
* @change
*/
    public void setTokenisationHeader(String userName,String password) 
    {
        if(String.isNotBlank(userName) && String.isNotBlank(password))
        {
            Blob headerValue = blob.valueOf(userName + ':' + password);
            String tokenisationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            addHeader('Tokenisation', tokenisationHeader);
        }
    }
    
    /**
* @name newRequest
* @description newRequest Methods to make a new request
* @param method and endPoint
* @return newRequest
* @exception
* @author Himanshu Kapoor/ Vinod KR
* @created 2016-06-16
* @remark 
* @change
*/
    private HttpRequest newRequest(Method method, String endPoint)
    {
        return newRequest(method, endPoint, NULL);
    }
    
    /**
* @name newRequest
* @description newRequest Methods to make a new request
* @param method, endPoint and requestBody
* @return request
* @exception
* @author Himanshu Kapoor/ Vinod KR
* @created 2016-06-16
* @remark 
* @change
*/
    private HttpRequest newRequest(Method method, String endPoint, String requestBody) 
    {
        HttpRequest request = new HttpRequest();
        request.setMethod(Method.name());
        setHeader(request);
        request.setEndpoint(endPoint);
        if (String.isNotBlank(requestBody)) 
        {
            request.setBody(requestBody);
        }   
        request.setTimeout(120000);
        return request;
    }
    
    /**
* @name send
* @description send Methods to send a request
* @param request
* @return 
* @exception Throws Exception
* @author Himanshu Kapoor/ Vinod KR
* @created 2016-06-16
* @remark 
* @change
*/
    private void send(HttpRequest request) 
    {
        try 
        {
            httpResponse = new Http().send(request);
        }
        catch(Exception e) 
        {
          throw e;    
        }
    }
    
    /**
* @name getResponse
* @description getResponse Method to get the Response
* @param NA
* @return httpResponse
* @exception
* @author Himanshu Kapoor/ Vinod KR
* @created 2016-06-16
* @remark 
* @change
*/
    public HttpResponse getResponse()
    {
        return httpResponse;
    }
    
    /**
* @name getResponseToString
* @description getResponse Method to get the Response
* @param NA
* @return getResponse
* @exception
* @author Himanshu Kapoor/ Vinod KR
* @created 2016-06-16
* @remark 
* @change
*/
    public String getResponseToString()
    {
        return getResponse().toString();
    }
}