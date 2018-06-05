// ============================================================================================= 
//  Object: CyberSourceUtils 
//  Company: Salesforce
//  Author:  Vinod KR/ Manigandan SA
//  Purpose: This class for all the functionality of CyberSource payment gateway XML Generator
//  Methods: Following are the methods and one line description
//              
//  Created: 2016-07-14
// ============================================================================================= 
//  Use Cases or Requirements: 
//  @UseCase number - @requirement Description      
// ============================================================================================= 
//  Changes: @Date Author
//           @Description
// ============================================================================================= 
public class CyberSourceUtils 
{   
    //implements PaymentTransactionXMLGenerator
    // ============================================================================
    // CONSTANT 
    // ============================================================================
        private static final String GENERATE_TOKEN_XML = 'generateTokenXML ';
        private static final String GENERATE_AUTHORIZE_XML = 'generateAuthorizeXML ';
        private static final String GENERATE_CHARGE_XML = 'generateChargeXML ';
        private static final String GENERATE_VOID_XML = 'generateVoidXML ';
        private static final String GENERATE_REFUND_XML = 'generateRefundXML ';
        private static final String GENERATE_ACH_CHARGE_XML = 'generateACHChargeXML ';
        private static final String GENERATE_ACH_VOID_XML = 'generateACHVoidXML ';
        private static final String GENERATE_ACH_REFUND_XML = 'generateACHRefundXML ';
        private static final String GET_ELEMENTS = 'getElements ';
        private static Boolean IS_MULTICURRENCY_ORG = UserInfo.isMultiCurrencyOrganization();
        private static String CURRENCYISOCODE = 'CurrencyIsoCode';
        private static final String TEXTAREA = 'TEXTAREA';
        
    // ============================================================================
    // STATIC VARIABLES
    // ============================================================================
    
       // private Attribute to implement singleton pattern for CyberSourceUtils class
       private static CyberSourceUtils cyberSourceXMLGeneratorInstance;

    // ============================================================================
    // VARIABLES
    // ============================================================================
        private static Map<string, string> mapOfResponseValueByKey = new Map<string, string>();
    // ============================================================================
    // Methods
    // ============================================================================ 

    /**
     * @name getInstance
     * @description get an Instance of Service class
     * @param NA
     * @return CyberSource XML Generator Class Instance
     * @exception To do
     * @author Manigandan SA / Vinod KR
     * @created 2016-07-15
     * @remark 
     * @change
     */ 
    public static CyberSourceUtils getInstance() 
    {
        if (NULL == cyberSourceXMLGeneratorInstance) 
        {
            cyberSourceXMLGeneratorInstance = new CyberSourceUtils();
        }
        return cyberSourceXMLGeneratorInstance;
    }

    /**
     * @name generateTokenXML
     * @description Method to Generate Token XML
     * @param List [TransactionParameter]
     * @return NA
     * @exception CustomException [unexpected exception]
     * @author Manigandan SA / Vinod KR
     * @created 2016-07-14
     * @remark
     * @change
     */
    public void generateTokenXML(List<blng.TransactionParameter> listOfTransactionParameter) 
    {
        try
        {    
            for(blng.TransactionParameter transactionParameterToProcess : listOfTransactionParameter)
            {
                XmlStreamWriter writer = new XmlStreamWriter();
                // Populate Document start
                writer.writeStartDocument('utf-8', '1.0');  
                    // Populate Envelope start
                    writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                        writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                            // Populate Header start
                            writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                                // Populate Security start
                                writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                                    writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                                        // Populate UsernameToken start
                                        writer.writeStartElement('wsse','UsernameToken','');
                                            // Populate the Username start
                                            writer.writeStartElement('wsse','Username','');
                                                writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                            writer.writeEndElement();
                                            // Populate the Username end
                                            // Populate the Password start
                                            writer.writeStartElement('wsse','Password','');
                                                writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                                                writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                                            writer.writeEndElement();
                                            // Populate the Password end
                                        writer.writeEndElement();
                                        // Populate UsernameToken end
                                writer.writeEndElement();
                                // Populate Security end
                                writer.writeEndElement();
                            // Populate Header end
                            // Populate Body start
                            writer.writeStartElement('s','Body','');
                                // Populate RequestMessage start
                                writer.writeStartElement('','requestMessage','');
                                        writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
                                        // Populate merchantID start
                                        writer.writeStartElement('','merchantID','');
                                        writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                        writer.writeEndElement();
                                        // Populate merchantID end
                                        // Populate merchantReferenceCode start
                                        writer.writeStartElement('','merchantReferenceCode','');
                                        writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
                                        writer.writeEndElement();
                                        // Populate merchantReferenceCode end
                                        // Populate billToAddress start
                                        writer.writeStartElement('','billTo','');
                                        // Populate firstName start
                                        writer.writeStartElement('','firstName','');
                                        writer.writeCharacters(transactionParameterToProcess.getFirstName());
                                        writer.writeEndElement();
                                        // Populate firstName end
                                        // Populate lastName start
                                        writer.writeStartElement('','lastName','');
                                        writer.writeCharacters(transactionParameterToProcess.getLastName());
                                        writer.writeEndElement();
                                        // Populate lastName end
                                        // Populate street1 start
                                        writer.writeStartElement('','street1','');
                                        writer.writeCharacters(transactionParameterToProcess.getStreet());
                                        writer.writeEndElement();
                                        // Populate street1 end
                                        // Populate city start
                                        writer.writeStartElement('','city','');
                                        writer.writeCharacters(transactionParameterToProcess.getCity());
                                        writer.writeEndElement();
                                        // Populate city end
                                        // Populate state start
                                        writer.writeStartElement('','state','');
                                        writer.writeCharacters(transactionParameterToProcess.getState());
                                        writer.writeEndElement();
                                        // Populate state end
                                        // Populate postalCode start
                                        writer.writeStartElement('','postalCode','');
                                        writer.writeCharacters(transactionParameterToProcess.getZipCode());
                                        writer.writeEndElement();
                                        // Populate postalCode end
                                        // Populate country start
                                        writer.writeStartElement('','country','');
                                        writer.writeCharacters(transactionParameterToProcess.getCountry());
                                        writer.writeEndElement();
                                        // Populate country end
                                        // Populate email start
                                        writer.writeStartElement('','email','');
                                        writer.writeCharacters(transactionParameterToProcess.getEmailId());
                                        writer.writeEndElement();
                                        // Populate email end
                                        writer.writeEndElement();
                                        // Populate billToAddress end
                                        // Populate purchaseTotals start
                                        writer.writeStartElement('','purchaseTotals','');
                                        // Populate currency start
                                        writer.writeStartElement('','currency','');
                                        writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                                        writer.writeEndElement();
                                        // Populate currency end
                                        writer.writeEndElement();
                                        // Populate purchaseTotals end
                                        // Populate card start
                                        writer.writeStartElement('','card','');
                                        // Populate accountNumber start
                                        writer.writeStartElement('','accountNumber','');
                                        writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardNumber__c);
                                        writer.writeEndElement();
                                        // Populate accountNumber end
                                        // Populate expirationMonth start
                                        writer.writeStartElement('','expirationMonth','');
                                        writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardExpirationMonth__c);
                                        writer.writeEndElement();
                                        // Populate expirationMonth end
                                        // Populate expirationYear start
                                        writer.writeStartElement('','expirationYear','');
                                        writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardExpirationYear__c);
                                        writer.writeEndElement();
                                        // Populate expirationYear end
                                        if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'VISA')
                                        {
                                             // Populate cardType start
                                            writer.writeStartElement('','cardType','');
                                                writer.writeCharacters('001');
                                            writer.writeEndElement();
                                            // Populate cardType end
                                        }
                                        else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'Mastercard')
                                        {
                                             // Populate cardType start
                                            writer.writeStartElement('','cardType','');
                                                writer.writeCharacters('002');
                                            writer.writeEndElement();
                                            // Populate cardType end
                                        }
                                        else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'American Express')
                                        {
                                             // Populate cardType start
                                            writer.writeStartElement('','cardType','');
                                                writer.writeCharacters('003');
                                            writer.writeEndElement();
                                            // Populate cardType end
                                        }
                                        else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'Discover')
                                        {
                                             // Populate cardType start
                                            writer.writeStartElement('','cardType','');
                                                writer.writeCharacters('004');
                                            writer.writeEndElement();
                                            // Populate cardType end
                                        }
                                        writer.writeEndElement();
                                        // Populate card end
                                        // Populate recurringSubscriptionInfo start
                                        writer.writeStartElement('','recurringSubscriptionInfo','');    
                                        // Populate frequency start
                                        writer.writeStartElement('','frequency','');
                                        writer.writeCharacters('on-demand');
                                        writer.writeEndElement();
                                        // Populate frequency end
                                        writer.writeEndElement();
                                        // Populate recurringSubscriptionInfo end
                                        // Populate paySubscriptionCreateService start
                                        writer.writeStartElement('','paySubscriptionCreateService','');
                                        writer.writeAttribute('', '', 'run', 'true');
                                        writer.writeEndElement();
                                        // Populate paySubscriptionCreateService end
                                // Populate RequestMessage end
                            writer.writeEndElement();
                            // Populate Body end
                    writer.writeEndElement();
                    // Populate Envelope end
                writer.writeEndDocument();
                transactionParameterToProcess.setRequestBody(writer.getXmlString());
                writer.close();
            }
        }
        catch (Exception e) 
        {
           throw e;
        }   
    }
    /**
     * @name generateVoidTokenXML
     * @description Method to delete Token XML
     * @param List [TransactionParameter]
     * @return NA
     * @exception CustomException [unexpected exception]
     * @author Dhanalakshmi
     * @created 2017-06-02
     * @remark
     * @change
     */
    public void generateVoidTokenXML(List<blng.TransactionParameter> listOfTransactionParameter) 
    {
        try
        {    
            for(blng.TransactionParameter transactionParameterToProcess : listOfTransactionParameter)
            {
                XmlStreamWriter writer = new XmlStreamWriter();
                // Populate Document start
                writer.writeStartDocument('utf-8', '1.0');  
                    // Populate Envelope start
                    writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                        writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                            // Populate Header start
                            writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                                // Populate Security start
                                writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                                    writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                                        // Populate UsernameToken start
                                        writer.writeStartElement('wsse','UsernameToken','');
                                            // Populate the Username start
                                            writer.writeStartElement('wsse','Username','');
                                                writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                            writer.writeEndElement();
                                            // Populate the Username end
                                            // Populate the Password start
                                            writer.writeStartElement('wsse','Password','');
                                                writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                                                writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                                            writer.writeEndElement();
                                            // Populate the Password end
                                        writer.writeEndElement();
                                        // Populate UsernameToken end
                                writer.writeEndElement();
                                // Populate Security end
                                writer.writeEndElement();
                            // Populate Header end
                            // Populate Body start
                            writer.writeStartElement('s','Body','');
                                // Populate RequestMessage start
                                writer.writeStartElement('','requestMessage','');
                                        writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.137');
                                        // Populate merchantID start
                                        writer.writeStartElement('','merchantID','');
                                        writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                        writer.writeEndElement();
                                        // Populate merchantID end
                                        // Populate merchantReferenceCode start
                                        writer.writeStartElement('','merchantReferenceCode','');
                                        writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
                                        writer.writeEndElement();
                                        // Populate merchantReferenceCode end
                                        // Populate recurringSubscriptionInfo start
                                        writer.writeStartElement('','recurringSubscriptionInfo','');
                                            // Populate subscriptionID start
                                            writer.writeStartElement('','subscriptionID','');
                                                //Added by DL,W-3931366, for cardmapping
                                                writer.writeCharacters(getCardMapping(transactionParameterToProcess.getPaymentMethod()));
                                            writer.writeEndElement();
                                            // Populate subscriptionID end
                                        writer.writeEndElement();
                                        // Populate recurringSubscriptionInfo end
                                        // Populate paySubscriptionDeleteService start
                                        writer.writeStartElement('','paySubscriptionDeleteService','');
                                        writer.writeAttribute('', '', 'run', 'true');
                                        writer.writeEndElement();
                                        // Populate paySubscriptionDeleteService end
                                // Populate RequestMessage end
                            writer.writeEndElement();
                            // Populate Body end
                    writer.writeEndElement();
                    // Populate Envelope end
                writer.writeEndDocument();
                transactionParameterToProcess.setRequestBody(writer.getXmlString());
                writer.close();
            }
        }
        catch (Exception e) 
        {
           throw e;
        }   
    }
    /**
     * @name generateAuthorizeXML
     * @description Method to Generate Authorize XML
     * @param Map[Key => String [unique Id],Value => TransactionParameter]
     * @return NA
     * @exception Throw Exception
     * @author Balachary 
     * @created 2017-06-01
     * @remark
     * @change
     */
    public void generateAuthorizeXML(Map<String, blng.TransactionParameter> mapOfTransactionParameterByInvoiceId)
    {
        try
        {
            for(String idToProcess : mapOfTransactionParameterByInvoiceId.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterByInvoiceId.get(idToProcess);
                XmlStreamWriter writer = new XmlStreamWriter();
                // Populate Document start
                writer.writeStartDocument('utf-8', '1.0');  
                    // Populate Envelope start
                    writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                        writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                            // Populate Header start
                            writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                                // Populate Security start
                                writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                                    writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                                        // Populate UsernameToken start
                                        writer.writeStartElement('wsse','UsernameToken','');
                                            // Populate the Username start
                                            writer.writeStartElement('wsse','Username','');
                                                writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                            writer.writeEndElement();
                                            // Populate the Username end
                                            // Populate the Password start
                                            writer.writeStartElement('wsse','Password','');
                                                writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                                                writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                                            writer.writeEndElement();
                                            // Populate the Password end
                                        writer.writeEndElement();
                                        // Populate UsernameToken end
                                writer.writeEndElement();
                                // Populate Security end
                                writer.writeEndElement();
                             // Populate Header end
                            // Populate Body start
                            writer.writeStartElement('s','Body','');
                // Populate RequestMessage start
                writer.writeStartElement('','requestMessage','');
                writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
                // Populate merchantID start
                writer.writeStartElement('','merchantID','');
                writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                writer.writeEndElement();
                // Populate merchantID end
                // Populate merchantReferenceCode start
                writer.writeStartElement('','merchantReferenceCode','');
                writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
                writer.writeEndElement();
                // Populate merchantReferenceCode end
                // Populate billToAddress start
                writer.writeStartElement('','billTo','');
                // Populate firstName start
                writer.writeStartElement('','firstName','');
                writer.writeCharacters(transactionParameterToProcess.getFirstName());
                writer.writeEndElement();
                // Populate firstName end
                // Populate lastName start
                writer.writeStartElement('','lastName','');
                writer.writeCharacters(transactionParameterToProcess.getLastName());
                writer.writeEndElement();
                // Populate lastName end
                // Populate street1 start
                writer.writeStartElement('','street1','');
                writer.writeCharacters(transactionParameterToProcess.getStreet());
                writer.writeEndElement();
                // Populate street1 end
                // Populate city start
                writer.writeStartElement('','city','');
                writer.writeCharacters(transactionParameterToProcess.getCity());
                writer.writeEndElement();
                // Populate city end
                // Populate state start
                writer.writeStartElement('','state','');
                writer.writeCharacters(transactionParameterToProcess.getState());
                writer.writeEndElement();
                // Populate state end
                // Populate postalCode start
                writer.writeStartElement('','postalCode','');
                writer.writeCharacters(transactionParameterToProcess.getZipCode());
                writer.writeEndElement();
                // Populate postalCode end
                // Populate country start
                writer.writeStartElement('','country','');
                writer.writeCharacters(transactionParameterToProcess.getCountry());
                writer.writeEndElement();
                // Populate country end
                // Populate email start
                writer.writeStartElement('','email','');
                writer.writeCharacters(transactionParameterToProcess.getEmailId());
                writer.writeEndElement();
                // Populate email end
                writer.writeEndElement();
                // Populate billToAddress end
                // Populate purchaseTotals start
                writer.writeStartElement('','purchaseTotals','');
                // Populate currency start
                writer.writeStartElement('','currency','');
                writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                writer.writeEndElement();
                writer.writeStartElement('','grandTotalAmount','');
                writer.writeCharacters(transactionParameterToProcess.getAmount());
                writer.writeEndElement();
                // Populate currency end
                writer.writeEndElement();
                // Populate purchaseTotals end
                // Populate card start
                writer.writeStartElement('','card','');
                // Populate accountNumber start
                writer.writeStartElement('','accountNumber','');
                writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardNumber__c);
                writer.writeEndElement();
                // Populate accountNumber end
                // Populate expirationMonth start
                writer.writeStartElement('','expirationMonth','');
                writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardExpirationMonth__c);
                writer.writeEndElement();
                // Populate expirationMonth end
                // Populate expirationYear start
                writer.writeStartElement('','expirationYear','');
                writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardExpirationYear__c);
                writer.writeEndElement();
                // Populate expirationYear end
                if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'VISA')
                {
                     // Populate cardType start
                    writer.writeStartElement('','cardType','');
                        writer.writeCharacters('001');
                    writer.writeEndElement();
                    // Populate cardType end
                }
                else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'Mastercard')
                {
                     // Populate cardType start
                    writer.writeStartElement('','cardType','');
                        writer.writeCharacters('002');
                    writer.writeEndElement();
                    // Populate cardType end
                }
                else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'American Express')
                {
                     // Populate cardType start
                    writer.writeStartElement('','cardType','');
                        writer.writeCharacters('003');
                    writer.writeEndElement();
                    // Populate cardType end
                }
                else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'Discover')
                {
                     // Populate cardType start
                    writer.writeStartElement('','cardType','');
                        writer.writeCharacters('004');
                    writer.writeEndElement();
                    // Populate cardType end
                }
                writer.writeEndElement();
                // Populate card end
                writer.writeStartElement('','ccAuthService','');
                writer.writeAttribute('', '', 'run', 'true');
                writer.writeEndElement();
                // Populate ccAuthService end
                // Populate RequestMessage end
                writer.writeEndElement();
                // Populate Body end
                writer.writeEndElement();
                // Populate Envelope end
                
                writer.writeEndDocument();
                transactionParameterToProcess.setRequestBody(writer.getXmlString());
                writer.close();
            }
        }
        catch (Exception e) 
        {
            throw e;
        }     
    } 
     /**
     * @name generateCaptureXML
     * @description Method to Generate Charge XML
     * @param Map[Key => String [unique Id],Value => TransactionParameter]
     * @return NA
     * @exception Throw Exception
     * @author Manigandan SA
     * @created 2017-05-30
     * @remark 
     * @change
     */
    public void generateCaptureXML(Map<String, blng.TransactionParameter> mapOfTransactionParameterByInvoiceId)
    {
        try
        {    
            for(String idToProcess : mapOfTransactionParameterByInvoiceId.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterByInvoiceId.get(idToProcess);
                XmlStreamWriter writer = new XmlStreamWriter();
                        // Populate Document start
                      writer.writeStartDocument('utf-8', '1.0');  
                        // Populate Envelope start
                        writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                          writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                            // Populate Header start
                            writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                              // Populate Security start
                              writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                                writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                                  // Populate UsernameToken start
                                  writer.writeStartElement('wsse','UsernameToken','');
                                    // Populate the Username start
                                    writer.writeStartElement('wsse','Username','');
                                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                    writer.writeEndElement();
                                    // Populate the Username end
                                    // Populate the Password start
                                    writer.writeStartElement('wsse','Password','');
                                      writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                                      writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                                    writer.writeEndElement();
                                    // Populate the Password end
                                  writer.writeEndElement();
                                  // Populate UsernameToken end
                              writer.writeEndElement();
                              // Populate Security end
                              writer.writeEndElement();
                             // Populate Header end
                            // Populate Body start
                            writer.writeStartElement('s','Body',''); 
                      // Populate RequestMessage start
                      writer.writeStartElement('','requestMessage','');
                      writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
                      // Populate merchantID start
                      writer.writeStartElement('','merchantID','');
                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                      writer.writeEndElement();
                      // Populate merchantID end
                      // Populate merchantReferenceCode start
                      writer.writeStartElement('','merchantReferenceCode','');
                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
                      writer.writeEndElement();
                      // Populate purchaseTotals start
                     writer.writeStartElement('','purchaseTotals','');
                     // Populate currency start
                     writer.writeStartElement('','currency','');
                     writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                     writer.writeEndElement();
                     // Populate currency end
                     writer.writeStartElement('','grandTotalAmount','');
                     writer.writeCharacters(transactionParameterToProcess.getAmount());
                     writer.writeEndElement();
                     writer.writeEndElement();
                     
                     
                    // Populate ccCaptureService start
                    writer.writeStartElement('','ccCaptureService','');
                    writer.writeAttribute('', '', 'run', 'true');
                    // Populate authRequestID start
                     writer.writeStartElement('','authRequestID','');
                     writer.writeCharacters(transactionParameterToProcess.getTransaction().blng__GatewayID__c);
                     writer.writeEndElement();
                     // Populate authRequestID end
                    
                     //writer.writeStartElement('','purchasingLevel','');
                     //writer.writeCharacters('3');
                     //writer.writeEndElement();
                     writer.writeEndElement();
                    
                    // Populate ccCaptureService End
                    writer.writeEndElement();
                    // Populate RequestMessage end
                    writer.writeEndElement();
                    // Populate Body end
                    writer.writeEndElement();
                    // Populate Envelope end
                    writer.writeEndDocument();
                    transactionParameterToProcess.setRequestBody(getInvoiceDetail(writer.getXmlString(), transactionParameterToProcess.getInvoice().id,transactionParameterToProcess));
                    writer.close();
                      
            }
        } 
        catch (Exception e) 
        {
            throw e;
        }
    }
   /**
     * @name generateChargeXML
     * @description Method to Generate Charge XML
     * @param Map[Key => String [unique Id],Value => TransactionParameter]
     * @return NA
     * @exception Throw Exception
     * @author Manigandan SA / Vinod KR
     * @created 2016-07-26
     * @remark 
     * @change
     */
    public void generateChargeXML(Map<String, blng.TransactionParameter> mapOfTransactionParameterByInvoiceId)
    {
        try
        {    
            for(String idToProcess : mapOfTransactionParameterByInvoiceId.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterByInvoiceId.get(idToProcess);
                XmlStreamWriter writer = new XmlStreamWriter();
                if(NULL == mapOfTransactionParameterByInvoiceId.get(idToProcess).getTransaction()) 
                {
                     // Populate Document start
                      writer.writeStartDocument('utf-8', '1.0');  
                        // Populate Envelope start
                        writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                          writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                            // Populate Header start
                            writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                              // Populate Security start
                              writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                                writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                                  // Populate UsernameToken start
                                  writer.writeStartElement('wsse','UsernameToken','');
                                    // Populate the Username start
                                    writer.writeStartElement('wsse','Username','');
                                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                    writer.writeEndElement();
                                    // Populate the Username end
                                    // Populate the Password start
                                    writer.writeStartElement('wsse','Password','');
                                      writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                                      writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                                    writer.writeEndElement();
                                    // Populate the Password end
                                  writer.writeEndElement();
                                  // Populate UsernameToken end
                              writer.writeEndElement();
                              // Populate Security end
                              writer.writeEndElement();
                             // Populate Header end
                            // Populate Body start
                            writer.writeStartElement('s','Body','');
                      // Populate RequestMessage start
                      writer.writeStartElement('','requestMessage','');
                      writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
                      // Populate merchantID start
                      writer.writeStartElement('','merchantID','');
                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                      writer.writeEndElement();
                      // Populate merchantID end
                      // Populate merchantReferenceCode start
                      writer.writeStartElement('','merchantReferenceCode','');
                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
                      writer.writeEndElement();
                      //Added by DL,W-3931366, for cardmapping
                      String cardMapping = getCardMapping(transactionParameterToProcess.getPaymentMethod());
                      if(NULL == cardMapping)
                      {
                            // Populate billToAddress start
                            writer.writeStartElement('','billTo','');
                            // Populate firstName start
                            writer.writeStartElement('','firstName','');
                            writer.writeCharacters(transactionParameterToProcess.getFirstName());
                            writer.writeEndElement();
                            // Populate firstName end
                            // Populate lastName start
                            writer.writeStartElement('','lastName','');
                            writer.writeCharacters(transactionParameterToProcess.getLastName());
                            writer.writeEndElement();
                            // Populate lastName end
                            // Populate street1 start
                            writer.writeStartElement('','street1','');
                            writer.writeCharacters(transactionParameterToProcess.getStreet());
                            writer.writeEndElement();
                            // Populate street1 end
                            // Populate city start
                            writer.writeStartElement('','city','');
                            writer.writeCharacters(transactionParameterToProcess.getCity());
                            writer.writeEndElement();
                            // Populate city end
                            // Populate state start
                            writer.writeStartElement('','state','');
                            writer.writeCharacters(transactionParameterToProcess.getState());
                            writer.writeEndElement();
                            // Populate state end
                            // Populate postalCode start
                            writer.writeStartElement('','postalCode','');
                            writer.writeCharacters(transactionParameterToProcess.getZipCode());
                            writer.writeEndElement();
                            // Populate postalCode end
                            // Populate country start
                            writer.writeStartElement('','country','');
                            writer.writeCharacters(transactionParameterToProcess.getCountry());
                            writer.writeEndElement();
                            // Populate country end
                            // Populate email start
                            writer.writeStartElement('','email','');
                            writer.writeCharacters(transactionParameterToProcess.getEmailId());
                            writer.writeEndElement();
                            // Populate email end
                            writer.writeEndElement();
                            // Populate billToAddress end
                            // Populate purchaseTotals start
                            writer.writeStartElement('','purchaseTotals','');
                            // Populate currency start
                            writer.writeStartElement('','currency','');
                            writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                            writer.writeEndElement();
                            writer.writeStartElement('','grandTotalAmount','');
                            writer.writeCharacters(transactionParameterToProcess.getAmount());
                            writer.writeEndElement();
                            // Populate currency end
                            writer.writeEndElement();
                            // Populate purchaseTotals end
                            // Populate card start
                            writer.writeStartElement('','card','');
                            // Populate accountNumber start
                            writer.writeStartElement('','accountNumber','');
                            writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardNumber__c);
                            writer.writeEndElement();
                            // Populate accountNumber end
                            // Populate expirationMonth start
                            writer.writeStartElement('','expirationMonth','');
                            writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardExpirationMonth__c);
                            writer.writeEndElement();
                            // Populate expirationMonth end
                            // Populate expirationYear start
                            writer.writeStartElement('','expirationYear','');
                            writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardExpirationYear__c);
                            writer.writeEndElement();
                            // Populate expirationYear end
                            if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'VISA')
                            {
                                  // Populate cardType start
                                  writer.writeStartElement('','cardType','');
                                    writer.writeCharacters('001');
                                  writer.writeEndElement();
                                  // Populate cardType end
                            }
                            else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'Mastercard')
                            {
                               // Populate cardType start
                               writer.writeStartElement('','cardType','');
                                writer.writeCharacters('002');
                              writer.writeEndElement();
                              // Populate cardType end
                            }
                            else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'American Express')
                            {
                                 // Populate cardType start
                              writer.writeStartElement('','cardType','');
                                writer.writeCharacters('003');
                              writer.writeEndElement();
                              // Populate cardType end
                            }
                            else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'Discover')
                            {
                                 // Populate cardType start
                              writer.writeStartElement('','cardType','');
                                writer.writeCharacters('004');
                              writer.writeEndElement();
                              // Populate cardType end
                            }
                            writer.writeEndElement();
                            // Populate card end
                        // Populate ccAuthService start
                        writer.writeStartElement('','ccAuthService','');
                        writer.writeAttribute('', '', 'run', 'true');
                            
                        // Populate authType start
                        writer.writeStartElement('','authType','');
                        writer.writeCharacters('AUTOCAPTURE');
                        writer.writeEndElement();
                        // Populate authType End
                        writer.writeEndElement();
                        // Populate ccAuthService End     
                        // Populate ccCaptureService start
                        writer.writeStartElement('','ccCaptureService','');
                        writer.writeAttribute('', '', 'run', 'true');
                        //writer.writeStartElement('','purchasingLevel','');
                        //writer.writeCharacters('3');
                        //writer.writeEndElement();
                        writer.writeEndElement();
                        // Populate ccCaptureService End
                    }
                    else
                    {
                        // Populate purchaseTotals start
                        writer.writeStartElement('','purchaseTotals','');
                        // Populate currency start
                        writer.writeStartElement('','currency','');
                        writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                        writer.writeEndElement();
                        // Populate currency end
                        writer.writeStartElement('','grandTotalAmount','');
                        writer.writeCharacters(transactionParameterToProcess.getAmount());
                        writer.writeEndElement();
                        writer.writeEndElement();
                        // Populate purchaseTotals end
                        // Populate recurringSubscriptionInfo start
                        writer.writeStartElement('','recurringSubscriptionInfo','');
                        writer.writeStartElement('','subscriptionID','');
                        //Added by DL,W-3931366, for cardmapping
                        writer.writeCharacters(cardMapping);
                        writer.writeEndElement();
                        writer.writeEndElement();
                        // Populate recurringSubscriptionInfo end
                        // Populate ccAuthService start
                        writer.writeStartElement('','ccAuthService','');
                        writer.writeAttribute('', '', 'run', 'true');
                        // Populate authType start
                        writer.writeStartElement('','authType','');
                        writer.writeCharacters('AUTOCAPTURE');
                        writer.writeEndElement();
                        // Populate authType End
                        writer.writeEndElement();
                        // Populate ccAuthService End
                        // Populate ccCaptureService start
                        writer.writeStartElement('','ccCaptureService','');
                        writer.writeAttribute('', '', 'run', 'true');
                        //writer.writeStartElement('','purchasingLevel','');
                        //writer.writeCharacters('3');
                        //writer.writeEndElement();
                        writer.writeEndElement();
                        // Populate ccCaptureService End
                    }
                        writer.writeEndElement();
                        // Populate RequestMessage end
                        writer.writeEndElement();
                        // Populate Body end
                        writer.writeEndElement();
                        // Populate Envelope end
                        writer.writeEndDocument();
                        if(transactionParameterToProcess.getInvoice() != NULL)
                        {
                            transactionParameterToProcess.setRequestBody(getInvoiceDetail(writer.getXmlString(), transactionParameterToProcess.getInvoice().Id,transactionParameterToProcess));
                        }
                        else
                        {
                            transactionParameterToProcess.setRequestBody(writer.getXmlString());
                        }
                        writer.close();
                }
                else
                {
                        // Populate Document start
                      writer.writeStartDocument('utf-8', '1.0');  
                        // Populate Envelope start
                        writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                          writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                            // Populate Header start
                            writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                              // Populate Security start
                              writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                                writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                                  // Populate UsernameToken start
                                  writer.writeStartElement('wsse','UsernameToken','');
                                    // Populate the Username start
                                    writer.writeStartElement('wsse','Username','');
                                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                    writer.writeEndElement();
                                    // Populate the Username end
                                    // Populate the Password start
                                    writer.writeStartElement('wsse','Password','');
                                      writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                                      writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                                    writer.writeEndElement();
                                    // Populate the Password end
                                  writer.writeEndElement();
                                  // Populate UsernameToken end
                              writer.writeEndElement();
                              // Populate Security end
                              writer.writeEndElement();
                             // Populate Header end
                            // Populate Body start
                            writer.writeStartElement('s','Body','');
                      // Populate RequestMessage start
                      writer.writeStartElement('','requestMessage','');
                      writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
                      // Populate merchantID start
                      writer.writeStartElement('','merchantID','');
                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                      writer.writeEndElement();
                      // Populate merchantID end
                      // Populate merchantReferenceCode start
                      writer.writeStartElement('','merchantReferenceCode','');
                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
                      writer.writeEndElement();
                      // Populate purchaseTotals start
                     writer.writeStartElement('','purchaseTotals','');
                     // Populate currency start
                     writer.writeStartElement('','currency','');
                     writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                     writer.writeEndElement();
                     // Populate currency end
                     writer.writeStartElement('','grandTotalAmount','');
                     writer.writeCharacters(transactionParameterToProcess.getAmount());
                     writer.writeEndElement();
                     writer.writeEndElement();
                     // Populate ccCaptureService start
                    writer.writeStartElement('','ccCaptureService','');
                    writer.writeAttribute('', '', 'run', 'true');
                    // Populate authRequestID start
                     writer.writeStartElement('','authRequestID','');
                     writer.writeCharacters(transactionParameterToProcess.getTransaction().blng__GatewayID__c);
                     writer.writeEndElement();
                     // Populate authRequestID end
                     //writer.writeStartElement('','purchasingLevel','');
                     //writer.writeCharacters('3');
                     //writer.writeEndElement();
                    writer.writeEndElement();
                    // Populate ccCaptureService End
                    writer.writeEndElement();
                    // Populate RequestMessage end
                    writer.writeEndElement();
                    // Populate Body end
                    writer.writeEndElement();
                    // Populate Envelope end
                    writer.writeEndDocument();
                    if(transactionParameterToProcess.getInvoice() != NULL)
                    {
                        transactionParameterToProcess.setRequestBody(getInvoiceDetail(writer.getXmlString(), transactionParameterToProcess.getInvoice().Id,transactionParameterToProcess));
                    }
                    else
                    {
                        transactionParameterToProcess.setRequestBody(writer.getXmlString());
                    }
                    writer.close();
                }       
            }
        } 
        catch (Exception e) 
        {
            throw e;
        }
    }
  /**
     * @name generateCaptureLevel3XML
     * @description Method to Generate Charge XML
     * @param Map[Key => String [unique Id],Value => TransactionParameter]
     * @return NA
     * @exception Throw Exception
     * @author Manigandan SA
     * @created 2017-05-30
     * @remark 
     * @change
     */
    public void generateCaptureLevel3XML(Map<String, blng.TransactionParameter> mapOfTransactionParameterByInvoiceId)
    {
        try
        {    
            for(String idToProcess : mapOfTransactionParameterByInvoiceId.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterByInvoiceId.get(idToProcess);
                XmlStreamWriter writer = new XmlStreamWriter();
                        // Populate Document start
                      writer.writeStartDocument('utf-8', '1.0');  
                        // Populate Envelope start
                        writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                          writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                            // Populate Header start
                            writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                              // Populate Security start
                              writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                                writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                                  // Populate UsernameToken start
                                  writer.writeStartElement('wsse','UsernameToken','');
                                    // Populate the Username start
                                    writer.writeStartElement('wsse','Username','');
                                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                    writer.writeEndElement();
                                    // Populate the Username end
                                    // Populate the Password start
                                    writer.writeStartElement('wsse','Password','');
                                      writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                                      writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                                    writer.writeEndElement();
                                    // Populate the Password end
                                  writer.writeEndElement();
                                  // Populate UsernameToken end
                              writer.writeEndElement();
                              // Populate Security end
                              writer.writeEndElement();
                             // Populate Header end
                            // Populate Body start
                            writer.writeStartElement('s','Body',''); 
                      // Populate RequestMessage start
                      writer.writeStartElement('','requestMessage','');
                      writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
                      // Populate merchantID start
                      writer.writeStartElement('','merchantID','');
                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                      writer.writeEndElement();
                      // Populate merchantID end
                      // Populate merchantReferenceCode start
                      writer.writeStartElement('','merchantReferenceCode','');
                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
                      writer.writeEndElement();
                      // Populate purchaseTotals start
                     writer.writeStartElement('','purchaseTotals','');
                     // Populate currency start
                     writer.writeStartElement('','currency','');
                     writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                     writer.writeEndElement();
                     // Populate currency end
                     writer.writeStartElement('','grandTotalAmount','');
                     writer.writeCharacters(transactionParameterToProcess.getAmount());
                     writer.writeEndElement();
                     writer.writeEndElement();
                     
                     
                    // Populate ccCaptureService start
                    writer.writeStartElement('','ccCaptureService','');
                    writer.writeAttribute('', '', 'run', 'true');
                    // Populate authRequestID start
                     writer.writeStartElement('','authRequestID','');
                     writer.writeCharacters(transactionParameterToProcess.getTransaction().blng__GatewayID__c);
                     writer.writeEndElement();
                     // Populate authRequestID end
                    
                     writer.writeStartElement('','purchasingLevel','');
                     writer.writeCharacters('3');
                     writer.writeEndElement();
                     writer.writeEndElement();
                    
                    // Populate ccCaptureService End
                    writer.writeEndElement();
                    // Populate RequestMessage end
                    writer.writeEndElement();
                    // Populate Body end
                    writer.writeEndElement();
                    // Populate Envelope end
                    writer.writeEndDocument();
                    transactionParameterToProcess.setRequestBody(getInvoiceDetail(writer.getXmlString(), transactionParameterToProcess.getInvoice().id,transactionParameterToProcess));
                    writer.close();
                     
            }
        } 
        catch (Exception e) 
        {
            throw e;
        }
    }

    /**
     * @name generateChargeLevel3XML
     * @description Method to Generate Charge XML
     * @param Map[Key => String [unique Id],Value => TransactionParameter]
     * @return NA
     * @exception Throw Exception
     * @author Manigandan SA / Vinod KR
     * @created 2016-07-26
     * @remark 
     * @change
     */
    public void generateChargeLevel3XML(Map<String, blng.TransactionParameter> mapOfTransactionParameterByInvoiceId)
    {
        try
        {    
            for(String idToProcess : mapOfTransactionParameterByInvoiceId.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterByInvoiceId.get(idToProcess);
                XmlStreamWriter writer = new XmlStreamWriter();
                if(NULL == mapOfTransactionParameterByInvoiceId.get(idToProcess).getTransaction()) 
                {
                     // Populate Document start
                      writer.writeStartDocument('utf-8', '1.0');  
                        // Populate Envelope start
                        writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                          writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                            // Populate Header start
                            writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                              // Populate Security start
                              writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                                writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                                  // Populate UsernameToken start
                                  writer.writeStartElement('wsse','UsernameToken','');
                                    // Populate the Username start
                                    writer.writeStartElement('wsse','Username','');
                                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                    writer.writeEndElement();
                                    // Populate the Username end
                                    // Populate the Password start
                                    writer.writeStartElement('wsse','Password','');
                                      writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                                      writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                                    writer.writeEndElement();
                                    // Populate the Password end
                                  writer.writeEndElement();
                                  // Populate UsernameToken end
                              writer.writeEndElement();
                              // Populate Security end
                              writer.writeEndElement();
                             // Populate Header end
                            // Populate Body start
                            writer.writeStartElement('s','Body','');
                      // Populate RequestMessage start
                      writer.writeStartElement('','requestMessage','');
                      writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
                      // Populate merchantID start
                      writer.writeStartElement('','merchantID','');
                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                      writer.writeEndElement();
                      // Populate merchantID end
                      // Populate merchantReferenceCode start
                      writer.writeStartElement('','merchantReferenceCode','');
                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
                      writer.writeEndElement();
                      //Added by DL,W-3931366, for cardmapping
                      String cardMapping = getCardMapping(transactionParameterToProcess.getPaymentMethod());
                      if(NULL == cardMapping)
                      {
                            // Populate billToAddress start
                            writer.writeStartElement('','billTo','');
                            // Populate firstName start
                            writer.writeStartElement('','firstName','');
                            writer.writeCharacters(transactionParameterToProcess.getFirstName());
                            writer.writeEndElement();
                            // Populate firstName end
                            // Populate lastName start
                            writer.writeStartElement('','lastName','');
                            writer.writeCharacters(transactionParameterToProcess.getLastName());
                            writer.writeEndElement();
                            // Populate lastName end
                            // Populate street1 start
                            writer.writeStartElement('','street1','');
                            writer.writeCharacters(transactionParameterToProcess.getStreet());
                            writer.writeEndElement();
                            // Populate street1 end
                            // Populate city start
                            writer.writeStartElement('','city','');
                            writer.writeCharacters(transactionParameterToProcess.getCity());
                            writer.writeEndElement();
                            // Populate city end
                            // Populate state start
                            writer.writeStartElement('','state','');
                            writer.writeCharacters(transactionParameterToProcess.getState());
                            writer.writeEndElement();
                            // Populate state end
                            // Populate postalCode start
                            writer.writeStartElement('','postalCode','');
                            writer.writeCharacters(transactionParameterToProcess.getZipCode());
                            writer.writeEndElement();
                            // Populate postalCode end
                            // Populate country start
                            writer.writeStartElement('','country','');
                            writer.writeCharacters(transactionParameterToProcess.getCountry());
                            writer.writeEndElement();
                            // Populate country end
                            // Populate email start
                            writer.writeStartElement('','email','');
                            writer.writeCharacters(transactionParameterToProcess.getEmailId());
                            writer.writeEndElement();
                            // Populate email end
                            writer.writeEndElement();
                            // Populate billToAddress end
                            // Populate purchaseTotals start
                            writer.writeStartElement('','purchaseTotals','');
                            // Populate currency start
                            writer.writeStartElement('','currency','');
                            writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                            writer.writeEndElement();
                            writer.writeStartElement('','grandTotalAmount','');
                            writer.writeCharacters(transactionParameterToProcess.getAmount());
                            writer.writeEndElement();
                            // Populate currency end
                            writer.writeEndElement();
                            // Populate purchaseTotals end
                            // Populate card start
                            writer.writeStartElement('','card','');
                            // Populate accountNumber start
                            writer.writeStartElement('','accountNumber','');
                            writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardNumber__c);
                            writer.writeEndElement();
                            // Populate accountNumber end
                            // Populate expirationMonth start
                            writer.writeStartElement('','expirationMonth','');
                            writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardExpirationMonth__c);
                            writer.writeEndElement();
                            // Populate expirationMonth end
                            // Populate expirationYear start
                            writer.writeStartElement('','expirationYear','');
                            writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardExpirationYear__c);
                            writer.writeEndElement();
                            // Populate expirationYear end
                            if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'VISA')
                            {
                                  // Populate cardType start
                                  writer.writeStartElement('','cardType','');
                                    writer.writeCharacters('001');
                                  writer.writeEndElement();
                                  // Populate cardType end
                            }
                            else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'Mastercard')
                            {
                               // Populate cardType start
                               writer.writeStartElement('','cardType','');
                                writer.writeCharacters('002');
                              writer.writeEndElement();
                              // Populate cardType end
                            }
                            else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'American Express')
                            {
                                 // Populate cardType start
                              writer.writeStartElement('','cardType','');
                                writer.writeCharacters('003');
                              writer.writeEndElement();
                              // Populate cardType end
                            }
                            else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'Discover')
                            {
                                 // Populate cardType start
                              writer.writeStartElement('','cardType','');
                                writer.writeCharacters('004');
                              writer.writeEndElement();
                              // Populate cardType end
                            }
                            writer.writeEndElement();
                            // Populate card end
                        // Populate ccAuthService start
                        writer.writeStartElement('','ccAuthService','');
                        writer.writeAttribute('', '', 'run', 'true');
                            
                        // Populate authType start
                        writer.writeStartElement('','authType','');
                        writer.writeCharacters('AUTOCAPTURE');
                        writer.writeEndElement();
                        // Populate authType End
                        writer.writeEndElement();
                        // Populate ccAuthService End     
                        // Populate ccCaptureService start
                        writer.writeStartElement('','ccCaptureService','');
                        writer.writeAttribute('', '', 'run', 'true');
                        writer.writeStartElement('','purchasingLevel','');
                        writer.writeCharacters('3');
                        writer.writeEndElement();
                        writer.writeEndElement();
                        // Populate ccCaptureService End
                    }
                    else
                    {
                        // Populate purchaseTotals start
                        writer.writeStartElement('','purchaseTotals','');
                        // Populate currency start
                        writer.writeStartElement('','currency','');
                        writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                        writer.writeEndElement();
                        // Populate currency end
                        writer.writeStartElement('','grandTotalAmount','');
                        writer.writeCharacters(transactionParameterToProcess.getAmount());
                        writer.writeEndElement();
                        writer.writeEndElement();
                        // Populate purchaseTotals end
                        // Populate recurringSubscriptionInfo start
                        writer.writeStartElement('','recurringSubscriptionInfo','');
                        writer.writeStartElement('','subscriptionID','');
                        //Added by DL,W-3931366, for cardmapping
                        writer.writeCharacters(cardMapping);
                        writer.writeEndElement();
                        writer.writeEndElement();
                        // Populate recurringSubscriptionInfo end
                        // Populate ccAuthService start
                        writer.writeStartElement('','ccAuthService','');
                        writer.writeAttribute('', '', 'run', 'true');
                        // Populate authType start
                        writer.writeStartElement('','authType','');
                        writer.writeCharacters('AUTOCAPTURE');
                        writer.writeEndElement();
                        // Populate authType End
                        writer.writeEndElement();
                        // Populate ccAuthService End
                        // Populate ccCaptureService start
                        writer.writeStartElement('','ccCaptureService','');
                        writer.writeAttribute('', '', 'run', 'true');
                        writer.writeStartElement('','purchasingLevel','');
                        writer.writeCharacters('3');
                        writer.writeEndElement();
                        writer.writeEndElement();
                        // Populate ccCaptureService End
                    }
                        writer.writeEndElement();
                        // Populate RequestMessage end
                        writer.writeEndElement();
                        // Populate Body end
                        writer.writeEndElement();
                        // Populate Envelope end
                        writer.writeEndDocument();
                        if(transactionParameterToProcess.getInvoice() != NULL)
                        {
                            transactionParameterToProcess.setRequestBody(getInvoiceDetail(writer.getXmlString(), transactionParameterToProcess.getInvoice().Id,transactionParameterToProcess));
                        }
                        else
                        {
                            transactionParameterToProcess.setRequestBody(writer.getXmlString());
                        }
                        writer.close();
                }
                else
                {
                        // Populate Document start
                      writer.writeStartDocument('utf-8', '1.0');  
                        // Populate Envelope start
                        writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                          writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                            // Populate Header start
                            writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                              // Populate Security start
                              writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                                writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                                  // Populate UsernameToken start
                                  writer.writeStartElement('wsse','UsernameToken','');
                                    // Populate the Username start
                                    writer.writeStartElement('wsse','Username','');
                                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                    writer.writeEndElement();
                                    // Populate the Username end
                                    // Populate the Password start
                                    writer.writeStartElement('wsse','Password','');
                                      writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                                      writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                                    writer.writeEndElement();
                                    // Populate the Password end
                                  writer.writeEndElement();
                                  // Populate UsernameToken end
                              writer.writeEndElement();
                              // Populate Security end
                              writer.writeEndElement();
                             // Populate Header end
                            // Populate Body start
                            writer.writeStartElement('s','Body','');
                      // Populate RequestMessage start
                      writer.writeStartElement('','requestMessage','');
                      writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
                      // Populate merchantID start
                      writer.writeStartElement('','merchantID','');
                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                      writer.writeEndElement();
                      // Populate merchantID end
                      // Populate merchantReferenceCode start
                      writer.writeStartElement('','merchantReferenceCode','');
                      writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
                      writer.writeEndElement();
                      // Populate purchaseTotals start
                     writer.writeStartElement('','purchaseTotals','');
                     // Populate currency start
                     writer.writeStartElement('','currency','');
                     writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                     writer.writeEndElement();
                     // Populate currency end
                     writer.writeStartElement('','grandTotalAmount','');
                     writer.writeCharacters(transactionParameterToProcess.getAmount());
                     writer.writeEndElement();
                     writer.writeEndElement();
                     // Populate ccCaptureService start
                    writer.writeStartElement('','ccCaptureService','');
                    writer.writeAttribute('', '', 'run', 'true');
                    // Populate authRequestID start
                     writer.writeStartElement('','authRequestID','');
                     writer.writeCharacters(transactionParameterToProcess.getTransaction().blng__GatewayID__c);
                     writer.writeEndElement();
                     // Populate authRequestID end
                     writer.writeStartElement('','purchasingLevel','');
                     writer.writeCharacters('3');
                     writer.writeEndElement();
                    writer.writeEndElement();
                    // Populate ccCaptureService End
                    writer.writeEndElement();
                    // Populate RequestMessage end
                    writer.writeEndElement();
                    // Populate Body end
                    writer.writeEndElement();
                    // Populate Envelope end
                    writer.writeEndDocument();
                    if(transactionParameterToProcess.getInvoice() != NULL)
                    {
                        transactionParameterToProcess.setRequestBody(getInvoiceDetail(writer.getXmlString(), transactionParameterToProcess.getInvoice().Id,transactionParameterToProcess));
                    }
                    else
                    {
                        transactionParameterToProcess.setRequestBody(writer.getXmlString());
                    }
                    writer.close();
                    
                }       
            }
        } 
        catch (Exception e) 
        {
            throw e;
        }
    }

    /**
     * @name generateACHChargeXML
     * @description Method to Generate ACH Charge XML
     * @param Map[Key => String [unique Id],Value => TransactionParameter]
     * @return NA
     * @exception Throw Exception
     * @author Manigandan SA / Vinod KR
     * @created 2016-07-26
     * @remark 
     * @change
     */
    public void generateACHChargeXML(Map<String, blng.TransactionParameter> mapOfTransactionParameterByInvoiceId)
    {
        try
        {    
            for(String idToProcess : mapOfTransactionParameterByInvoiceId.keySet())
            {
                blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterByInvoiceId.get(idToProcess);
                XmlStreamWriter writer = new XmlStreamWriter();
                 if(NULL == transactionParameterToProcess.getTransaction()) 
                 {
                         // Populate Document start
                          writer.writeStartDocument('utf-8', '1.0');  
                            // Populate Envelope start
                            writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                              writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                                // Populate Header start
                                writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                                  // Populate Security start
                                  writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                                    writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                                      // Populate UsernameToken start
                                      writer.writeStartElement('wsse','UsernameToken','');
                                        // Populate the Username start
                                        writer.writeStartElement('wsse','Username','');
                                          writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                        writer.writeEndElement();
                                        // Populate the Username end
                                        // Populate the Password start
                                        writer.writeStartElement('wsse','Password','');
                                          writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                                          writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                                        writer.writeEndElement();
                                        // Populate the Password end
                                      writer.writeEndElement();
                                      // Populate UsernameToken end
                                  writer.writeEndElement();
                                  // Populate Security end
                                  writer.writeEndElement();
                                 // Populate Header end
                                // Populate Body start
                                writer.writeStartElement('s','Body','');
                          // Populate RequestMessage start
                          writer.writeStartElement('','requestMessage','');
                          writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
                          // Populate merchantID start
                          writer.writeStartElement('','merchantID','');
                          writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                          writer.writeEndElement();
                          // Populate merchantID end
                          // Populate merchantReferenceCode start
                          writer.writeStartElement('','merchantReferenceCode','');
                          writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
                          writer.writeEndElement();
                        // Populate billToAddress start
                        writer.writeStartElement('','billTo','');
                        // Populate firstName start
                        writer.writeStartElement('','firstName','');
                        writer.writeCharacters(transactionParameterToProcess.getFirstName());
                        writer.writeEndElement();
                        // Populate firstName end
                        // Populate lastName start
                        writer.writeStartElement('','lastName','');
                        writer.writeCharacters(transactionParameterToProcess.getLastName());
                        writer.writeEndElement();
                        // Populate lastName end
                        // Populate street1 start
                        writer.writeStartElement('','street1','');
                        writer.writeCharacters(transactionParameterToProcess.getStreet());
                        writer.writeEndElement();
                        // Populate street1 end
                        // Populate city start
                        writer.writeStartElement('','city','');
                        writer.writeCharacters(transactionParameterToProcess.getCity());
                        writer.writeEndElement();
                        // Populate city end
                        // Populate state start
                        writer.writeStartElement('','state','');
                        writer.writeCharacters(transactionParameterToProcess.getState());
                        writer.writeEndElement();
                        // Populate state end
                        // Populate postalCode start
                        writer.writeStartElement('','postalCode','');
                        writer.writeCharacters(transactionParameterToProcess.getZipCode());
                        writer.writeEndElement();
                        // Populate postalCode end
                        // Populate country start
                        writer.writeStartElement('','country','');
                        writer.writeCharacters(transactionParameterToProcess.getCountry());
                        writer.writeEndElement();
                        // Populate country end
                        // Populate email start
                        writer.writeStartElement('','email','');
                        writer.writeCharacters(transactionParameterToProcess.getEmailId());
                        writer.writeEndElement();
                        // Populate email end
                        writer.writeEndElement();
                        // Populate billToAddress end
                        // Populate purchaseTotals start
                        writer.writeStartElement('','purchaseTotals','');
                        // Populate currency start
                        writer.writeStartElement('','currency','');
                        writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                        writer.writeEndElement();
                        writer.writeStartElement('','grandTotalAmount','');
                        writer.writeCharacters(transactionParameterToProcess.getAmount());
                        writer.writeEndElement();
                        // Populate currency end
                        writer.writeEndElement();
                        // Populate purchaseTotals end
                        // Populate card start
                        writer.writeStartElement('','check','');
                        // Populate accountNumber start
                        writer.writeStartElement('','accountNumber','');
                        writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__BankAccountNumber__c);
                        writer.writeEndElement();
                        // Populate accountNumber end
                        // Populate expirationYear end
                        if(transactionParameterToProcess.getPaymentMethod().blng__BankAccountType__c == 'Checking')
                        {
                              // Populate cardType start
                              writer.writeStartElement('','accountType','');
                                writer.writeCharacters('C');
                              writer.writeEndElement();
                              // Populate cardType end
                        }
                        else if(transactionParameterToProcess.getPaymentMethod().blng__BankAccountType__c == 'Business Checking')
                        {
                           // Populate cardType start
                           writer.writeStartElement('','accountType','');
                            writer.writeCharacters('X');
                          writer.writeEndElement();
                          // Populate cardType end
                        }
                        else if(transactionParameterToProcess.getPaymentMethod().blng__BankAccountType__c == 'Savings')
                        {
                             // Populate cardType start
                          writer.writeStartElement('','accountType','');
                            writer.writeCharacters('S');
                          writer.writeEndElement();
                          // Populate cardType end
                        }
                        // Populate cardType start
                        writer.writeStartElement('','bankTransitNumber','');
                          writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__BankRoutingCode__c);
                        writer.writeEndElement();
                          // Populate cardType end
                        writer.writeEndElement();
                        // Populate check end
                       // Populate ecDebitService start
                    writer.writeStartElement('','ecDebitService','');
                    writer.writeAttribute('', '', 'run', 'true');
                    writer.writeEndElement();
                    writer.writeEndElement();
                    // Populate RequestMessage end
                    writer.writeEndElement();
                    // Populate Body end
                    writer.writeEndElement();
                    // Populate Envelope end
                    writer.writeEndDocument();
                    if(transactionParameterToProcess.getInvoice() != NULL)
                    {
                        transactionParameterToProcess.setRequestBody(getInvoiceDetail(writer.getXmlString(), transactionParameterToProcess.getInvoice().Id,transactionParameterToProcess));
                    }
                    else
                    {
                        transactionParameterToProcess.setRequestBody(writer.getXmlString());
                    }
                    writer.close();
                }  
            }
        } 
        catch (Exception e) 
        {
            throw e; 
        }    
    }

    /**
     * @name generateVoidXML
     * @description Method to Generate Void XML
     * @param Map[Key => String [unique Id],Value => TransactionParameter]
     * @return NA
     * @exception Throw Exception
     * @author Raghavendra Reddy
     * @created 2017-05-30
     * @remark 
     * @change
     */
    public void generateVoidXML(Map<String, blng.TransactionParameter> mapOfTransactionParameterByInvoiceId)
    {
       try
        {
            for(String idToProcess : mapOfTransactionParameterByInvoiceId.keySet())
            {
              blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterByInvoiceId.get(idToProcess);
              XmlStreamWriter writer = new XmlStreamWriter();
              // Populate Document start
              writer.writeStartDocument('utf-8', '1.0');  
                // Populate Envelope start
                writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                  writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                    // Populate Header start
                    writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                      // Populate Security start
                      writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                        writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                          // Populate UsernameToken start
                          writer.writeStartElement('wsse','UsernameToken','');
                            // Populate the Username start
                            writer.writeStartElement('wsse','Username','');
                              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                            writer.writeEndElement();
                            // Populate the Username end
                            // Populate the Password start
                            writer.writeStartElement('wsse','Password','');
                              writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                              writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                            writer.writeEndElement();
                            // Populate the Password end
                          writer.writeEndElement();
                          // Populate UsernameToken end
                      writer.writeEndElement();
                      // Populate Security end
                      writer.writeEndElement();
                     // Populate Header end
                    // Populate Body start
                    writer.writeStartElement('s','Body','');
              // Populate RequestMessage start
              writer.writeStartElement('','requestMessage','');
              writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
              // Populate merchantID start
              writer.writeStartElement('','merchantID','');
              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
              writer.writeEndElement();
              // Populate merchantID end
              // Populate merchantReferenceCode start
              writer.writeStartElement('','merchantReferenceCode','');
              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
              writer.writeEndElement();
              // Populate purchaseTotals start
                writer.writeStartElement('','purchaseTotals','');
                // Populate currency start
                writer.writeStartElement('','currency','');
                writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                writer.writeEndElement();
                writer.writeStartElement('','grandTotalAmount','');
                writer.writeCharacters(transactionParameterToProcess.getAmount());
                writer.writeEndElement();
                // Populate currency end
                writer.writeEndElement();
                // Populate purchaseTotals end
                // Populate ccCreditService start
                writer.writeStartElement('','voidService','');
                writer.writeAttribute('', '', 'run', 'true');
                // Populate captureRequestID start
                writer.writeStartElement('','voidRequestID','');
                writer.writeCharacters(transactionParameterToProcess.getTransaction().blng__GatewayID__c);
                writer.writeEndElement();
                // Populate captureRequestID end
                writer.writeEndElement();
                // Populate ccCreditService end
                writer.writeEndElement();
                // Populate RequestMessage end
                writer.writeEndElement();
                // Populate Body end
                writer.writeEndElement();
                // Populate Envelope end
                writer.writeEndDocument();
                transactionParameterToProcess.setRequestBody(writer.getXmlString());
                writer.close();
            }
        } 
        catch (Exception e) 
        {
           throw e;
        }            
    }
   
    /**
     * @name generateRefundXML
     * @description Method to Generate Card Refund XML
     * @param Map[Key => String [unique Id],Value => TransactionParameter]
     * @return NA
     * @exception Throw Exception
     * @author Manigandan SA / Vinod KR
     * @created 2016-07-26
     * @remark 
     * @change
     */
    public void generateRefundXML(Map<String, blng.TransactionParameter> mapOfTransactionParameterByInvoiceId)
    {
        try
        {
            for(String idToProcess : mapOfTransactionParameterByInvoiceId.keySet())
            {
              blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterByInvoiceId.get(idToProcess);
              XmlStreamWriter writer = new XmlStreamWriter();
              // Populate Document start
              writer.writeStartDocument('utf-8', '1.0');  
                // Populate Envelope start
                writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                  writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                    // Populate Header start
                    writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                      // Populate Security start
                      writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                        writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                          // Populate UsernameToken start
                          writer.writeStartElement('wsse','UsernameToken','');
                            // Populate the Username start
                            writer.writeStartElement('wsse','Username','');
                              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                            writer.writeEndElement();
                            // Populate the Username end
                            // Populate the Password start
                            writer.writeStartElement('wsse','Password','');
                              writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                              writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                            writer.writeEndElement();
                            // Populate the Password end
                          writer.writeEndElement();
                          // Populate UsernameToken end
                      writer.writeEndElement();
                      // Populate Security end
                      writer.writeEndElement();
                     // Populate Header end
                    // Populate Body start
                    writer.writeStartElement('s','Body','');
              // Populate RequestMessage start
              writer.writeStartElement('','requestMessage','');
              writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
              // Populate merchantID start
              writer.writeStartElement('','merchantID','');
              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
              writer.writeEndElement();
              // Populate merchantID end
              // Populate merchantReferenceCode start
              writer.writeStartElement('','merchantReferenceCode','');
              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
              writer.writeEndElement();
              // Populate purchaseTotals start
                writer.writeStartElement('','purchaseTotals','');
                // Populate currency start
                writer.writeStartElement('','currency','');
                writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                writer.writeEndElement();
                writer.writeStartElement('','grandTotalAmount','');
                writer.writeCharacters(transactionParameterToProcess.getAmount());
                writer.writeEndElement();
                // Populate currency end
                writer.writeEndElement();
                // Populate purchaseTotals end
                // Populate ccCreditService start
                writer.writeStartElement('','ccCreditService','');
                writer.writeAttribute('', '', 'run', 'true');
                // Populate captureRequestID start
                writer.writeStartElement('','captureRequestID','');
                writer.writeCharacters(transactionParameterToProcess.getTransaction().blng__GatewayID__c);
                writer.writeEndElement();
                // Populate captureRequestID end
                writer.writeEndElement();
                // Populate ccCreditService end
                writer.writeEndElement();
                // Populate RequestMessage end
                writer.writeEndElement();
                // Populate Body end
                writer.writeEndElement();
                // Populate Envelope end
                writer.writeEndDocument();
                transactionParameterToProcess.setRequestBody(getInvoiceDetail(writer.getXmlString(), transactionParameterToProcess.getTransaction().blng__RequestInvoice__c,transactionParameterToProcess));
                system.debug('----Refund--->'+ writer.getXmlString());
                writer.close();
            }
        } 
        catch (Exception e) 
        {
           throw e;
        }        
    }

    /**
     * @name generateACHRefundXML
     * @description Method to Generate ACH Refund XML
     * @param Map[Key => String [unique Id],Value => TransactionParameter]
     * @return NA
     * @exception Throw Exception
     * @author Manigandan SA / Vinod KR
     * @created 2016-07-26
     * @remark 
     * @change
     */
    public void generateACHRefundXML(Map<String, blng.TransactionParameter> mapOfTransactionParameterByInvoiceId)
    {
        try
        {
            for(String idToProcess : mapOfTransactionParameterByInvoiceId.keySet())
            {
              blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterByInvoiceId.get(idToProcess);  
              XmlStreamWriter writer = new XmlStreamWriter();
              // Populate Document start
              writer.writeStartDocument('utf-8', '1.0');  
                // Populate Envelope start
                writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                  writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                    // Populate Header start
                    writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                      // Populate Security start
                      writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                        writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                          // Populate UsernameToken start
                          writer.writeStartElement('wsse','UsernameToken','');
                            // Populate the Username start
                            writer.writeStartElement('wsse','Username','');
                              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                            writer.writeEndElement();
                            // Populate the Username end
                            // Populate the Password start
                            writer.writeStartElement('wsse','Password','');
                              writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                              writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                            writer.writeEndElement();
                            // Populate the Password end
                          writer.writeEndElement();
                          // Populate UsernameToken end
                      writer.writeEndElement();
                      // Populate Security end
                      writer.writeEndElement();
                     // Populate Header end
                    // Populate Body start
                    writer.writeStartElement('s','Body','');
              // Populate RequestMessage start
              writer.writeStartElement('','requestMessage','');
              writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
              // Populate merchantID start
              writer.writeStartElement('','merchantID','');
              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
              writer.writeEndElement();
              // Populate merchantID end
              // Populate merchantReferenceCode start
              writer.writeStartElement('','merchantReferenceCode','');
              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
              writer.writeEndElement();
              // Populate purchaseTotals start
                writer.writeStartElement('','purchaseTotals','');
                // Populate currency start
                writer.writeStartElement('','currency','');
                writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                writer.writeEndElement();
                writer.writeStartElement('','grandTotalAmount','');
                writer.writeCharacters(transactionParameterToProcess.getAmount());
                writer.writeEndElement();
                // Populate currency end
                writer.writeEndElement();
                // Populate purchaseTotals end
                // Populate ecCreditService start
                writer.writeStartElement('','ecCreditService','');
                writer.writeAttribute('', '', 'run', 'true');
                // Populate captureRequestID start
                writer.writeStartElement('','debitRequestID','');
                writer.writeCharacters(transactionParameterToProcess.getTransaction().blng__GatewayID__c);
                writer.writeEndElement();
                // Populate captureRequestID end
                writer.writeEndElement();
                // Populate ecCreditService end
                writer.writeEndElement();
                // Populate RequestMessage end
                writer.writeEndElement();
                // Populate Body end
                writer.writeEndElement();
                // Populate Envelope end
                writer.writeEndDocument();
                transactionParameterToProcess.setRequestBody(getInvoiceDetail(writer.getXmlString(), transactionParameterToProcess.getTransaction().blng__RequestInvoice__c,transactionParameterToProcess));
                writer.close();
            }
        } 
        catch (Exception e) 
        {
           throw e;
        }        
    }

     /**
     * @name generateCardnonReferencedRefundXML
     * @description Method to Generate Card non Referenced Refund XML
     * @param Map[Key => String [unique Id],Value => TransactionParameter]
     * @return NA
     * @exception Throw Exception
     * @author Manigandan SA
     * @created 2017-05-30
     * @remark 
     * @change
     */
    public void generateCardnonReferencedRefundXML(Map<String, blng.TransactionParameter> mapOfTransactionParameterByInvoiceId)
    {
        try
        {
            for(String idToProcess : mapOfTransactionParameterByInvoiceId.keySet())
            {
              blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterByInvoiceId.get(idToProcess);
              XmlStreamWriter writer = new XmlStreamWriter();
              // Populate Document start
              writer.writeStartDocument('utf-8', '1.0');  
                // Populate Envelope start
                writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                  writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                    // Populate Header start
                    writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                      // Populate Security start
                      writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                        writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                          // Populate UsernameToken start
                          writer.writeStartElement('wsse','UsernameToken','');
                            // Populate the Username start
                            writer.writeStartElement('wsse','Username','');
                              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                            writer.writeEndElement();
                            // Populate the Username end
                            // Populate the Password start
                            writer.writeStartElement('wsse','Password','');
                              writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                              writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                            writer.writeEndElement();
                            // Populate the Password end
                          writer.writeEndElement();
                          // Populate UsernameToken end
                      writer.writeEndElement();
                      // Populate Security end
                      writer.writeEndElement();
                     // Populate Header end
                    // Populate Body start
                    writer.writeStartElement('s','Body','');
              // Populate RequestMessage start
              writer.writeStartElement('','requestMessage','');
              writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
              // Populate merchantID start
              writer.writeStartElement('','merchantID','');
              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
              writer.writeEndElement();
              // Populate merchantID end
              // Populate merchantReferenceCode start
              writer.writeStartElement('','merchantReferenceCode','');
              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
              writer.writeEndElement();
              // Populate billToAddress start
                        writer.writeStartElement('','billTo','');
                        // Populate firstName start
                        writer.writeStartElement('','firstName','');
                        writer.writeCharacters(transactionParameterToProcess.getFirstName());
                        writer.writeEndElement();
                        // Populate firstName end
                        // Populate lastName start
                        writer.writeStartElement('','lastName','');
                        writer.writeCharacters(transactionParameterToProcess.getLastName());
                        writer.writeEndElement();
                        // Populate lastName end
                        // Populate street1 start
                        writer.writeStartElement('','street1','');
                        writer.writeCharacters(transactionParameterToProcess.getStreet());
                        writer.writeEndElement();
                        // Populate street1 end
                        // Populate city start
                        writer.writeStartElement('','city','');
                        writer.writeCharacters(transactionParameterToProcess.getCity());
                        writer.writeEndElement();
                        // Populate city end
                        // Populate state start
                        writer.writeStartElement('','state','');
                        writer.writeCharacters(transactionParameterToProcess.getState());
                        writer.writeEndElement();
                        // Populate state end
                        // Populate postalCode start
                        writer.writeStartElement('','postalCode','');
                        writer.writeCharacters(transactionParameterToProcess.getZipCode());
                        writer.writeEndElement();
                        // Populate postalCode end
                        // Populate country start
                        writer.writeStartElement('','country','');
                        writer.writeCharacters(transactionParameterToProcess.getCountry());
                        writer.writeEndElement();
                        // Populate country end
                        // Populate email start
                        writer.writeStartElement('','email','');
                        writer.writeCharacters(transactionParameterToProcess.getEmailId());
                        writer.writeEndElement();
                        // Populate email end
                        writer.writeEndElement();
                        // Populate billToAddress end
              // Populate purchaseTotals start
                writer.writeStartElement('','purchaseTotals','');
                // Populate currency start
                writer.writeStartElement('','currency','');
                writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                writer.writeEndElement();
                writer.writeStartElement('','grandTotalAmount','');
                writer.writeCharacters(transactionParameterToProcess.getAmount());
                writer.writeEndElement();
                // Populate currency end
                writer.writeEndElement();
                // Populate purchaseTotals end
                // Populate card start
                            writer.writeStartElement('','card','');
                            // Populate accountNumber start
                            writer.writeStartElement('','accountNumber','');
                            writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardNumber__c);
                            writer.writeEndElement();
                            // Populate accountNumber end
                            // Populate expirationMonth start
                            writer.writeStartElement('','expirationMonth','');
                            writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardExpirationMonth__c);
                            writer.writeEndElement();
                            // Populate expirationMonth end
                            // Populate expirationYear start
                            writer.writeStartElement('','expirationYear','');
                            writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__CardExpirationYear__c);
                            writer.writeEndElement();
                            // Populate expirationYear end
                            if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'VISA')
                            {
                                  // Populate cardType start
                                  writer.writeStartElement('','cardType','');
                                    writer.writeCharacters('001');
                                  writer.writeEndElement();
                                  // Populate cardType end
                            }
                            else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'Mastercard')
                            {
                               // Populate cardType start
                               writer.writeStartElement('','cardType','');
                                writer.writeCharacters('002');
                              writer.writeEndElement();
                              // Populate cardType end
                            }
                            else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'American Express')
                            {
                                 // Populate cardType start
                              writer.writeStartElement('','cardType','');
                                writer.writeCharacters('003');
                              writer.writeEndElement();
                              // Populate cardType end
                            }
                            else if(transactionParameterToProcess.getPaymentMethod().blng__CardType__c == 'Discover')
                            {
                                 // Populate cardType start
                              writer.writeStartElement('','cardType','');
                                writer.writeCharacters('004');
                              writer.writeEndElement();
                              // Populate cardType end
                            }
                            writer.writeEndElement();
                            // Populate card end

                // Populate ccCreditService start
                writer.writeStartElement('','ccCreditService',''); 
                writer.writeAttribute('', '', 'run', 'true');
                writer.writeEndElement();
                // Populate ccCreditService end
                writer.writeEndElement();
                // Populate RequestMessage end
                writer.writeEndElement();
                // Populate Body end
                writer.writeEndElement();
                // Populate Envelope end
                writer.writeEndDocument();
                transactionParameterToProcess.setRequestBody(writer.getXmlString());
                writer.close();
            }
        } 
        catch (Exception e) 
        {
           throw e;
        }        
    }
    /**
     * @name generateACHnonReferencedRefundXML
     * @description Method to Generate ACH non Referenced Refund XML
     * @param Map[Key => String [unique Id],Value => TransactionParameter]
     * @return NA
     * @exception Throw Exception
     * @author Manigandan SA
     * @created 2017-05-30
     * @remark 
     * @change
     */
    public void generateACHnonReferencedRefundXML(Map<String, blng.TransactionParameter> mapOfTransactionParameterByInvoiceId)
    {
        try
        {
            for(String idToProcess : mapOfTransactionParameterByInvoiceId.keySet())
            {
              blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterByInvoiceId.get(idToProcess);  
              XmlStreamWriter writer = new XmlStreamWriter();
              // Populate Document start
              writer.writeStartDocument('utf-8', '1.0');  
                // Populate Envelope start
                writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                  writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                    // Populate Header start
                    writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                      // Populate Security start
                      writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                        writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                          // Populate UsernameToken start
                          writer.writeStartElement('wsse','UsernameToken','');
                            // Populate the Username start
                            writer.writeStartElement('wsse','Username','');
                              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                            writer.writeEndElement();
                            // Populate the Username end
                            // Populate the Password start
                            writer.writeStartElement('wsse','Password','');
                              writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                              writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                            writer.writeEndElement();
                            // Populate the Password end
                          writer.writeEndElement();
                          // Populate UsernameToken end
                      writer.writeEndElement();
                      // Populate Security end
                      writer.writeEndElement();
                     // Populate Header end
                    // Populate Body start
                    writer.writeStartElement('s','Body','');
              // Populate RequestMessage start
              writer.writeStartElement('','requestMessage','');
              writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
              // Populate merchantID start
              writer.writeStartElement('','merchantID','');
              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
              writer.writeEndElement();
              // Populate merchantID end
              // Populate merchantReferenceCode start
              writer.writeStartElement('','merchantReferenceCode','');
              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
              writer.writeEndElement();
              // Populate billToAddress start
                        writer.writeStartElement('','billTo','');
                        // Populate firstName start
                        writer.writeStartElement('','firstName','');
                        writer.writeCharacters(transactionParameterToProcess.getFirstName());
                        writer.writeEndElement();
                        // Populate firstName end
                        // Populate lastName start
                        writer.writeStartElement('','lastName','');
                        writer.writeCharacters(transactionParameterToProcess.getLastName());
                        writer.writeEndElement();
                        // Populate lastName end
                        // Populate street1 start
                        writer.writeStartElement('','street1','');
                        writer.writeCharacters(transactionParameterToProcess.getStreet());
                        writer.writeEndElement();
                        // Populate street1 end
                        // Populate city start
                        writer.writeStartElement('','city','');
                        writer.writeCharacters(transactionParameterToProcess.getCity());
                        writer.writeEndElement();
                        // Populate city end
                        // Populate state start
                        writer.writeStartElement('','state','');
                        writer.writeCharacters(transactionParameterToProcess.getState());
                        writer.writeEndElement();
                        // Populate state end
                        // Populate postalCode start
                        writer.writeStartElement('','postalCode','');
                        writer.writeCharacters(transactionParameterToProcess.getZipCode());
                        writer.writeEndElement();
                        // Populate postalCode end
                        // Populate country start
                        writer.writeStartElement('','country','');
                        writer.writeCharacters(transactionParameterToProcess.getCountry());
                        writer.writeEndElement();
                        // Populate country end
                        // Populate email start
                        writer.writeStartElement('','email','');
                        writer.writeCharacters(transactionParameterToProcess.getEmailId());
                        writer.writeEndElement();
                        // Populate email end
                        writer.writeEndElement();
                        // Populate billToAddress end
              // Populate purchaseTotals start
                writer.writeStartElement('','purchaseTotals','');
                // Populate currency start
                writer.writeStartElement('','currency','');
                writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                writer.writeEndElement();
                writer.writeStartElement('','grandTotalAmount','');
                writer.writeCharacters(transactionParameterToProcess.getAmount());
                writer.writeEndElement();
                // Populate currency end
                writer.writeEndElement();
                // Populate purchaseTotals end

                 // Populate card start
                        writer.writeStartElement('','check','');
                        // Populate accountNumber start
                        writer.writeStartElement('','accountNumber','');
                        writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__BankAccountNumber__c);
                        writer.writeEndElement();
                        // Populate accountNumber end
                        // Populate expirationYear end
                        if(transactionParameterToProcess.getPaymentMethod().blng__BankAccountType__c == 'Checking')
                        {
                              // Populate cardType start
                              writer.writeStartElement('','accountType','');
                                writer.writeCharacters('C');
                              writer.writeEndElement();
                              // Populate cardType end
                        }
                        else if(transactionParameterToProcess.getPaymentMethod().blng__BankAccountType__c == 'Business Checking')
                        {
                           // Populate cardType start
                           writer.writeStartElement('','accountType','');
                            writer.writeCharacters('X');
                          writer.writeEndElement();
                          // Populate cardType end
                        }
                        else if(transactionParameterToProcess.getPaymentMethod().blng__BankAccountType__c == 'Savings')
                        {
                             // Populate cardType start
                          writer.writeStartElement('','accountType','');
                            writer.writeCharacters('S');
                          writer.writeEndElement();
                          // Populate cardType end
                        }
                        // Populate cardType start
                        writer.writeStartElement('','bankTransitNumber','');
                          writer.writeCharacters(transactionParameterToProcess.getPaymentMethod().blng__BankRoutingCode__c);
                        writer.writeEndElement();
                          // Populate cardType end
                        writer.writeEndElement();
                        // Populate check end


                // Populate ecCreditService start
                writer.writeStartElement('','ecCreditService',''); 
                writer.writeAttribute('', '', 'run', 'true');
                writer.writeEndElement();
                // Populate ecCreditService end
                writer.writeEndElement();
                // Populate RequestMessage end
                writer.writeEndElement();
                // Populate Body end
                writer.writeEndElement();
                // Populate Envelope end
                writer.writeEndDocument();
                transactionParameterToProcess.setRequestBody(writer.getXmlString());
                writer.close();
            }
        } 
        catch (Exception e) 
        {
           throw e;
        }        
    }
    /**
     * @name generateVoidRefundXML
     * @description Method to Generate Void Refund XML
     * @param Map[Key => String [unique Id],Value => TransactionParameter]
     * @return NA
     * @exception Throw Exception
     * @author Raghavendra Reddy
     * @created 2017-05-30
     * @remark 
     * @change
     */
    public void generateVoidRefundXML(Map<String, blng.TransactionParameter> mapOfTransactionParameterByInvoiceId)
    {
       try
        {
            for(String idToProcess : mapOfTransactionParameterByInvoiceId.keySet())
            {
              blng.TransactionParameter transactionParameterToProcess = mapOfTransactionParameterByInvoiceId.get(idToProcess);
              XmlStreamWriter writer = new XmlStreamWriter();
              // Populate Document start
              writer.writeStartDocument('utf-8', '1.0');  
                // Populate Envelope start
                writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                  writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                    // Populate Header start
                    writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                      // Populate Security start
                      writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                        writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                          // Populate UsernameToken start
                          writer.writeStartElement('wsse','UsernameToken','');
                            // Populate the Username start
                            writer.writeStartElement('wsse','Username','');
                              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                            writer.writeEndElement();
                            // Populate the Username end
                            // Populate the Password start
                            writer.writeStartElement('wsse','Password','');
                              writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                              writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                            writer.writeEndElement();
                            // Populate the Password end
                          writer.writeEndElement();
                          // Populate UsernameToken end
                      writer.writeEndElement();
                      // Populate Security end
                      writer.writeEndElement();
                     // Populate Header end
                    // Populate Body start
                    writer.writeStartElement('s','Body','');
              // Populate RequestMessage start
              writer.writeStartElement('','requestMessage','');
              writer.writeAttribute('', '', 'xmlns', 'urn:schemas-cybersource-com:transaction-data-1.115');
              // Populate merchantID start
              writer.writeStartElement('','merchantID','');
              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
              writer.writeEndElement();
              // Populate merchantID end
              // Populate merchantReferenceCode start
              writer.writeStartElement('','merchantReferenceCode','');
              writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantReference__c);
              writer.writeEndElement();
              // Populate purchaseTotals start
                writer.writeStartElement('','purchaseTotals','');
                // Populate currency start
                writer.writeStartElement('','currency','');
                writer.writeCharacters(validateCurrency(transactionParameterToProcess));
                writer.writeEndElement();
                writer.writeStartElement('','grandTotalAmount','');
                writer.writeCharacters(transactionParameterToProcess.getAmount());
                writer.writeEndElement();
                // Populate currency end
                writer.writeEndElement();
                // Populate purchaseTotals end
                // Populate ccCreditService start
                writer.writeStartElement('','voidService','');
                writer.writeAttribute('', '', 'run', 'true');
                // Populate captureRequestID start
                writer.writeStartElement('','voidRequestID','');
                writer.writeCharacters(transactionParameterToProcess.getTransaction().blng__GatewayID__c);
                writer.writeEndElement();
                // Populate captureRequestID end
                writer.writeEndElement();
                // Populate ccCreditService end
                writer.writeEndElement();
                // Populate RequestMessage end
                writer.writeEndElement();
                // Populate Body end
                writer.writeEndElement();
                // Populate Envelope end
                writer.writeEndDocument();
                transactionParameterToProcess.setRequestBody(writer.getXmlString());
                writer.close();
            }
        } 
        catch (Exception e) 
        {
           throw e;
        }            
    }

    /**
     * @name generateGetPaymentStatusXML
     * @description Method to Get Payment Status
     * @param List [TransactionParameter]
     * @return NA
     * @exception CustomException [unexpected exception]
     * @author Ramachandran
     * @created 2017-05-30
     * @remark
     * @change
     */
    public void generateGetPaymentStatusXML(List<blng.TransactionParameter> listOfTransactionParameter) 
    {
        try
        {    
            for(blng.TransactionParameter transactionParameterToProcess : listOfTransactionParameter)
            {
                XmlStreamWriter writer = new XmlStreamWriter();
                // Populate Document start
                writer.writeStartDocument('utf-8', '1.0');  
                    // Populate Envelope start
                    writer.writeStartElement('s','Envelope','http://schemas.xmlsoap.org/soap/envelope/');
                        writer.writeAttribute('xmlns', 'http://schemas.xmlsoap.org/soap/envelope/', 's', 'http://schemas.xmlsoap.org/soap/envelope/');
                            // Populate Header start
                            writer.writeStartElement('s','Header','http://schemas.xmlsoap.org/soap/envelope/');
                                // Populate Security start
                                writer.writeStartElement('wsse','Security','http://schemas.xmlsoap.org/soap/envelope/');
                                    writer.writeAttribute('xmlns', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd', 'wsse', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd');
                                        // Populate UsernameToken start
                                        writer.writeStartElement('wsse','UsernameToken','');
                                            // Populate the Username start
                                            writer.writeStartElement('wsse','Username','');
                                                writer.writeCharacters(transactionParameterToProcess.getGateWay().MerchantId__c);
                                            writer.writeEndElement();
                                            // Populate the Username end
                                            // Populate the Password start
                                            writer.writeStartElement('wsse','Password','');
                                                writer.writeAttribute(NULL, NULL, 'Type', 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText');
                                                writer.writeCharacters(transactionParameterToProcess.getGateWay().TransactionSecurityKey__c);
                                            writer.writeEndElement();
                                            // Populate the Password end
                                        writer.writeEndElement();
                                        // Populate UsernameToken end
                                writer.writeEndElement();
                                // Populate Security end
                                writer.writeEndElement();
                            // Populate Header end
                            // Populate Body start
                            writer.writeStartElement('s','Body','');
                                // Populate Request start
                                writer.writeStartElement('','requestMessage','');
                                        writer.writeAttribute('', '', 'MerchantReferenceNumber', transactionParameterToProcess.getGateWay().MerchantReference__c);
                                        writer.writeAttribute('', '', 'Source', 'SCMP API');
                                        //writer.writeAttribute('', '', 'TransactionReferenceNumber',transactionParameterToProcess.getTransaction().blng__GatewayID__c);
                               writer.writeEndElement();
                                // Populate Request end
                            writer.writeEndElement();
                            // Populate Body end
                    writer.writeEndElement();
                    // Populate Envelope end
                writer.writeEndDocument();
                transactionParameterToProcess.setRequestBody(writer.getXmlString());
                writer.close();
            }
        }
        catch (Exception e) 
        {
           throw e;
        }   
    }

    /**
     * @name getElements
     * @description Populates's map Of Response Value By Key
     * @param Dom XML Node
     * @return Map [Key => String [Name] , Value => String [text]]
     * @exception NA
     * @author Raghavendra Reddy
     * @created 2017-05-30
     * @remark 
     * @change
     */  
    public static Map<string, string> getElements(DOM.XMLNode node) 
    {
        if(node.getNodeType() == DOM.XMLNodeType.ELEMENT)
        {
            if(String.IsNotBlank(node.getText().trim())) 
            {
                mapOfResponseValueByKey.put(node.getName(), node.getText().trim());
            }
            
            for(Dom.XMLNode child : node.getChildElements())
            {
                getElements(child);
            }
        }
        return mapOfResponseValueByKey;
    }

     /**
    * @name validateCustomerDetails
    * @description Validate's Customer Detail
    * @param List [TransactionParameter]
    * @return NA
    * @exception NA
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-14
    * @remark 
    * @change
    */
    public static void validateCustomerDetails(List<blng.TransactionParameter> listOfTransactionParameter) 
    {      
        for(blng.TransactionParameter transactionParameterToProcess : listOfTransactionParameter)
        {
            if(String.IsBlank(transactionParameterToProcess.getFirstName()))
            {
                transactionParameterToProcess.transactionResult.setError('First Name is missing');
            }
            else if(String.IsBlank(transactionParameterToProcess.getLastName()))
            {
                transactionParameterToProcess.transactionResult.setError('Last Name is missing');
            }
            else if(String.IsBlank(transactionParameterToProcess.getStreet()))
            {
                transactionParameterToProcess.transactionResult.setError('Address is missing');
            }
            else if(String.IsBlank(transactionParameterToProcess.getCity()))
            {
                transactionParameterToProcess.transactionResult.setError('City is missing');
            }
            else if(String.IsBlank(transactionParameterToProcess.getState()))
            {
                transactionParameterToProcess.transactionResult.setError('State is missing');
            }
            else if(String.IsBlank(transactionParameterToProcess.getZipCode()))
            {
                transactionParameterToProcess.transactionResult.setError('Zip Code is missing');
            }
            else if(String.IsBlank(transactionParameterToProcess.getCountry()))
            {
                transactionParameterToProcess.transactionResult.setError('Country is missing');
            }
            else if(String.IsBlank(transactionParameterToProcess.getEmailId()))
            {
                transactionParameterToProcess.transactionResult.setError('Email is missing');
            }
            
            if(!transactionParameterToProcess.transactionResult.getErrors().IsEmpty())
            {
                transactionParameterToProcess.transactionResult.setIsSuccess(false);
            }
        }
    }

    /**
     * Method verifies if any field name was added to Invoice and InvoiceLine config
     * If the field type is not TEXTAREA, then the process is aborted and the appropriate
     * TransactionResult is returned.
     * @param mapOfProcessIdToTransactionParameterById
     * @param invoiceDetailAPIValue
     *
     * @return
     */
    public static Map<String, blng.TransactionResult> validateInvoiceConfig(
            Map<String, blng.TransactionParameter> mapOfProcessIdToTransactionParameterById,
            String invoiceDetailAPIValue)
    {
        String invoiceLineDetailAPIValue = blng__BillingConfig__c.getValues('INVOICE_LINE_DETAIL').blng__StringValue__c;
        Map<String, blng.TransactionResult> mapOfProcessIdToTransactionParameter = new Map<String, blng.TransactionResult>();
        Schema.DisplayType fielddataType;
        // check invoice config
        if(NULL != invoiceDetailAPIValue) {
            fielddataType = ((Schema.getGlobalDescribe().get('blng__Invoice__c')).getDescribe().fields.getMap()).get(invoiceDetailAPIValue).getDescribe().getType();
        }
        // field added has to be of type TEXTAREA, else it is an error
        if(NULL != invoiceDetailAPIValue && String.valueOf(fielddataType) != TEXTAREA) {
            return handleInvoiceConfigError(invoiceDetailAPIValue, mapOfProcessIdToTransactionParameterById, mapOfProcessIdToTransactionParameter);
        }
        // now check invoice line config
        if(NULL != invoiceLineDetailAPIValue) {
            fielddataType = ((Schema.getGlobalDescribe().get('blng__InvoiceLine__c')).getDescribe().fields.getMap()).get(invoiceLineDetailAPIValue).getDescribe().getType();
        }
        // field added has to be of type TEXTAREA, else it is an error
        if(NULL != invoiceLineDetailAPIValue && String.valueOf(fielddataType) != TEXTAREA) {
            return handleInvoiceConfigError(invoiceLineDetailAPIValue, mapOfProcessIdToTransactionParameterById, mapOfProcessIdToTransactionParameter);
        }
        return mapOfProcessIdToTransactionParameter;
    }

    private static Map<String, blng.TransactionResult> handleInvoiceConfigError(
            string configAPIValue,
            Map<String, blng.TransactionParameter> mapOfProcessIdToTransactionParameterById,
            Map<String, blng.TransactionResult> mapOfProcessIdToTransactionParameter) {
        string idToProcess = (new list<string>(mapOfProcessIdToTransactionParameterById.keySet())[0]);
        blng.TransactionParameter transactionParameterToProcess = mapOfProcessIdToTransactionParameterById.get(idToProcess);
        transactionParameterToProcess.transactionResult.setIsSuccess(false);
        transactionParameterToProcess.transactionResult.setResponseToValidate('FAILURE');
        transactionParameterToProcess.transactionResult.setResponseMessage(configAPIValue + ' field Data type must be Text Area (Long)');
        transactionParameterToProcess.transactionResult.setId(idToProcess);
        transactionParameterToProcess.transactionResult.setResponseCode('ERROR');
        transactionParameterToProcess.transactionResult.setGatewayStatus(blng.TransactionResult.GatewayStatusType.ValidationError);
        mapOfProcessIdToTransactionParameter.put(idToProcess,transactionParameterToProcess.transactionResult);
        return mapOfProcessIdToTransactionParameter;
    }
        /**
        * @name getErrorCyberSourceCode
        * @description Return's Map of Cyber source error description By code
        * @param NA
        * @return Map [Key => String [Code] , Value => String [Error Message]]
        * @exception To do
        * @author Manigandan SA / Vinod KR
        * @created 2016-07-15
        * @remark
        * @change
        */
    public static map<string,string> getErrorCyberSourceCode()
    {
        Map<string, string> mapOfMessageByErrorCode = new Map<string, string>();
        mapOfMessageByErrorCode.put('100','Successful transaction');
        mapOfMessageByErrorCode.put('101','The request is missing one or more required fields.Possible action: see the reply fields missingField_0...N for which fields are missing. Resend the request with the complete information. For information about missing or invalid fields');
        mapOfMessageByErrorCode.put('102','Invalid data');
        mapOfMessageByErrorCode.put('110','Partial amount approved');
        mapOfMessageByErrorCode.put('150','General system failure');
        mapOfMessageByErrorCode.put('151','This error does not include timeouts between the client and the server.To avoid duplicating the transaction, do not resend the request until you have reviewed the transaction status at the Business Center');
        mapOfMessageByErrorCode.put('152','The request was received, but a service did not finish running in time.To avoid duplicating the transaction, do not resend the request until you have reviewed the transaction status at the Business Center');
        mapOfMessageByErrorCode.put('200','The authorization request was approved by the issuing bank but declined by CyberSource because it did not pass the AVS check');
        mapOfMessageByErrorCode.put('201','The issuing bank has questions about the request. You will not receive an authorization code programmatically, but you can obtain one verbally by calling the processor');
        mapOfMessageByErrorCode.put('202','Expired card');
        mapOfMessageByErrorCode.put('203','General decline of the card');
        mapOfMessageByErrorCode.put('204','Insufficient funds in the account');
        mapOfMessageByErrorCode.put('205','Stolen or lost card');
        mapOfMessageByErrorCode.put('207','Issuing bank unavailable');
        mapOfMessageByErrorCode.put('208','Inactive card or card not authorized for card-not-present transactions');
        mapOfMessageByErrorCode.put('210','The card has reached the credit limit');
        mapOfMessageByErrorCode.put('211','Invalid card verification number');
        mapOfMessageByErrorCode.put('220','The processor declined the request based on a general issue with the customer’s account');
        mapOfMessageByErrorCode.put('221','The customer matched an entry on the processor’s negative file');
        mapOfMessageByErrorCode.put('231','Invalid account number Possible action: Request a different card or other form of payment ');
        mapOfMessageByErrorCode.put('236','Processor failure');
        mapOfMessageByErrorCode.put('240','The card type sent is invalid or does not correlate with the card number');
        mapOfMessageByErrorCode.put('104','The merchant reference code for this authorization request matches the merchant reference code of another authorization request that you sent within the past 15 minutes');
        mapOfMessageByErrorCode.put('209','CVN did not match');
        mapOfMessageByErrorCode.put('232','The card type is not accepted by the payment processor');
        mapOfMessageByErrorCode.put('234','There is a problem with the information in your CyberSource account');
        mapOfMessageByErrorCode.put('235','The requested capture amount exceeds the originally authorized amount');
        mapOfMessageByErrorCode.put('237','The authorization has already been reversed');
        mapOfMessageByErrorCode.put('238','The authorization has already been captured');
        mapOfMessageByErrorCode.put('239','The requested transaction amount must match the previous transaction amount');
        mapOfMessageByErrorCode.put('240','The card type sent is invalid or does not correlate with the credit card number');
        mapOfMessageByErrorCode.put('241','The request ID is invalid');
        mapOfMessageByErrorCode.put('242','You requested a capture, but there is no corresponding, unused authorization record. Occurs if there was not a previously successful authorization request or if the previously successful authorization has already been used by another capture request');
        mapOfMessageByErrorCode.put('243','The transaction has already been settled or reversed');
        mapOfMessageByErrorCode.put('246','One of the following- The capture or credit is not voidable because the capture or credit information has already been submitted to your processor or You requested a void for a type of transaction that cannot be voided');
        mapOfMessageByErrorCode.put('247','You requested a credit for a capture that was previously voided');
        mapOfMessageByErrorCode.put('250','The request was received, but there was a timeout at the payment processor.');
        mapOfMessageByErrorCode.put('254','Stand-alone credits are not allowed');
        mapOfMessageByErrorCode.put('222','The customer bank account is frozen');
        mapOfMessageByErrorCode.put('223','The customer payment or credit has been declined. This could relate to an existing duplicate check, the original transaction was not approved, or a valid authorization could not be located');
        mapOfMessageByErrorCode.put('233','The processor declined the request based on an issue with the request itself');
        mapOfMessageByErrorCode.put('234','There is a problem with your merchant configuration');
        mapOfMessageByErrorCode.put('246','The debit or credit is not voidable because the debit or credit information has already been submitted to your processor');
        mapOfMessageByErrorCode.put('247','You requested a credit for a debit that was previously voided');
        mapOfMessageByErrorCode.put('250','Error: The request was received, but there was a timeout at the payment processor');
        mapOfMessageByErrorCode.put('388','Error: The routing number did not pass verification');
        return mapOfMessageByErrorCode;
    }

    /**
    * @name validateCurrency
    * @description Method used to validate Currency
    * @param blng.TransactionParameter instance
    * @return String
    * @exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-15
    * @remark 
    * @change
    */ 
    public String validateCurrency(blng.TransactionParameter transactionParameterToProcess)
    {
       
       if(IS_MULTICURRENCY_ORG)
        {
            if(NULL != transactionParameterToProcess.getInvoice())
            {
                return getCurrencyISOCode(transactionParameterToProcess.getInvoice());
            }
            else if(NULL != transactionParameterToProcess.getAccount())
            {
                return getCurrencyISOCode(transactionParameterToProcess.getAccount());
            }
            else if(NULL != transactionParameterToProcess.getTransaction() )
            {
                return getCurrencyISOCode(transactionParameterToProcess.getTransaction());
            }
            
        }
        else
        {
            return UserInfo.getDefaultCurrency();
        }

       return NULL;     
    }
    
    /**
    * @name getCurrencyISOCode
    * @description Method used to get urrency ISOCode
    * @param SObject instance
    * @return String
    * @exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-15
    * @remark 
    * @change
    */ 
   public String getCurrencyISOCode(SObject sObjectInstance)
   {
      if(UserInfo.isMultiCurrencyOrganization()) 
      {
          return (String)sObjectInstance.get(CURRENCYISOCODE);
      }
      return NULL;
   } 

   /**
    * @name getCardMapping
    * @description Method is to get Card Mapping
    * @param 
    * @return String
    * @exception NA
    * @author DL
    * @created 2017-06-13
    * @remark 
    * @change
    */
    public String getCardMapping(blng__PaymentMethod__c paymentMethod) 
    {
        blng__BillingConfig__c cardMappingConfig = blng__BillingConfig__c.getValues('CARD_MAPPING');
        if(NULL != cardMappingConfig.blng__StringValue__c)
        {
            String paymentMethodQuery = 'SELECT Id, ' + cardMappingConfig.blng__StringValue__c + ' FROM blng__PaymentMethod__c WHERE Id =' + '\'' + paymentMethod.Id + '\'';
            blng__PaymentMethod__c paymentMethodObject = Database.query(paymentMethodQuery);
            if(NULL != paymentMethodObject.get(cardMappingConfig.blng__StringValue__c))
            {
                return String.valueOf(paymentMethodObject.get(cardMappingConfig.blng__StringValue__c));
            }
            else
            {
                return paymentMethod.blng__PaymentGatewayToken__c;
            }
        }
        else
        {
            return paymentMethod.blng__PaymentGatewayToken__c;
        }
    }
    /**
    * @name getInvoiceDetail
    * @description Method is to get Invoice Details
    * @param 
    * @return String
    * @exception NA
    * @author DL
    * @created 2017-06-13
    * @remark 
    * @change
    */
    public string getInvoiceDetail(String xMLRequest, Id invoiceId, blng.TransactionParameter transactionParameterToProcess) 
    {
        String invoiceDetailAPIValue = blng__BillingConfig__c.getValues('INVOICE_DETAIL').blng__StringValue__c;
        String invoiceObject = 'blng__Invoice__c';
        if(NULL != invoiceDetailAPIValue)
        {
            String invoiceQuery = 'SELECT Id, ' + invoiceDetailAPIValue + ' FROM blng__Invoice__c WHERE Id =' + '\'' + invoiceId + '\'';
            blng__Invoice__c invoiceObj = Database.query(invoiceQuery);
            if(NULL != invoiceObj.get(invoiceDetailAPIValue))
            {
                String xMLRequestBeforeMRC =  xMLRequest.substringBefore('</merchantReferenceCode>'); 
                String xMLRequestAfterMRC =  xMLRequest.substringAfter('</merchantReferenceCode>');
                if(String.valueOf(invoiceObj.get(invoiceDetailAPIValue)).Contains('<purchaseTotals>'))
                {

                    String xMLRequestBeforePT =  String.valueOf(invoiceObj.get(invoiceDetailAPIValue)).substringBefore('<purchaseTotals>');
                    String xMLRequestAfterPT =  String.valueOf(invoiceObj.get(invoiceDetailAPIValue)).substringAfter('<purchaseTotals>');
                    
                    if(NULL != xMLRequestBeforePT)
                    {
                        xMLRequest = xMLRequestBeforeMRC + '</merchantReferenceCode>' + xMLRequestBeforePT  + xMLRequestAfterMRC;
                    }
                    if(String.valueOf(invoiceObj.get(invoiceDetailAPIValue)).Contains('<discountAmount>'))
                    {
                        String discountAmount = String.valueOf(invoiceObj.get(invoiceDetailAPIValue)).substringBetween('<discountAmount>','</discountAmount>');
                        String xMLRequestBeforeCurrency =  xMLRequest.substringBefore('</currency>'); 
                        String xMLRequestAfterCurrency =  xMLRequest.substringAfter('</currency>');
                        if(NULL != discountAmount)
                        {
                            xMLRequest = xMLRequestBeforeCurrency + '</currency><discountAmount>' + discountAmount + '</discountAmount>' + xMLRequestAfterCurrency;
                        }
                    }
                    if(xMLRequest.Contains('<discountAmount>') && String.valueOf(invoiceObj.get(invoiceDetailAPIValue)).Contains('<dutyAmount>'))
                    {
                        String dutyAmount = String.valueOf(invoiceObj.get(invoiceDetailAPIValue)).substringBetween('<dutyAmount>','</dutyAmount>');
                        String xMLRequestBeforeDiscountAmount =  xMLRequest.substringBefore('</discountAmount>'); 
                        String xMLRequestAfterDiscountAmount =  xMLRequest.substringAfter('</discountAmount>');
                        xMLRequest = xMLRequestBeforeDiscountAmount + '</discountAmount><dutyAmount>' + dutyAmount + '</dutyAmount>' + xMLRequestAfterDiscountAmount;

                    }
                    else if(String.valueOf(invoiceObj.get(invoiceDetailAPIValue)).Contains('<dutyAmount>'))
                    {
                        String xMLRequestBeforeCurrency =  xMLRequest.substringBefore('</currency>'); 
                        String xMLRequestAfterCurrency =  xMLRequest.substringAfter('</currency>');
                        String dutyAmount = String.valueOf(invoiceObj.get(invoiceDetailAPIValue)).substringBetween('<dutyAmount>','</dutyAmount>');
                        xMLRequest = xMLRequestBeforeCurrency + '</currency><dutyAmount>' + dutyAmount + '</dutyAmount>' + xMLRequestAfterCurrency;
                    }
                    if(String.valueOf(invoiceObj.get(invoiceDetailAPIValue)).Contains('<freightAmount>'))
                    {
                        String freightAmount = String.valueOf(invoiceObj.get(invoiceDetailAPIValue)).substringBetween('<freightAmount>','</freightAmount>');
                        String xMLRequestBeforeGT =  xMLRequest.substringBefore('</grandTotalAmount>');
                        String xMLRequestAfterGT =  xMLRequest.substringAfter('</grandTotalAmount>');
                        xMLRequest = xMLRequestBeforeGT + '</grandTotalAmount><freightAmount>' + freightAmount + '</freightAmount>' + xMLRequestAfterGT;
                    }
                }
                else
                {
                    xMLRequest = xMLRequestBeforeMRC + '</merchantReferenceCode>' + String.valueOf(invoiceObj.get(invoiceDetailAPIValue)) + xMLRequestAfterMRC;
                }
            }  
        }
         System.debug('invice-->xMLRequest===='+xMLRequest);
        return getInvoiceLineDetail(xMLRequest, invoiceId,transactionParameterToProcess);
     }

    /**
    * @name getInvoiceLineDetail
    * @description Method is to get Invoice Details
    * @param 
    * @return String
    * @exception NA
    * @author DL
    * @created 2017-06-13
    * @remark 
    * @change
    */
    public string getInvoiceLineDetail(String xMLRequest, Id invoiceId, blng.TransactionParameter transactionParameterToProcess) 
    {
        String invoiceLineDetailAPIValue = blng__BillingConfig__c.getValues('INVOICE_LINE_DETAIL').blng__StringValue__c;
        String invoiceLineObject = 'blng__InvoiceLine__c';
        if(NULL != invoiceLineDetailAPIValue)
        {
            String invoiceLineQuery = 'SELECT Id, ' + invoiceLineDetailAPIValue + ' FROM blng__InvoiceLine__c WHERE blng__Invoice__c =' + '\'' + invoiceId + '\'';
            List<blng__InvoiceLine__c> listOfInvoiceLines = Database.query(invoiceLineQuery);
            String xMLRequestBeforeMRC =  xMLRequest.substringBefore('<purchaseTotals>');
            String xMLRequestAfterMRC =  xMLRequest.substringAfter('<purchaseTotals>');
            String invoiceLineDetail = '';
            integer counter = 0;
            for(blng__InvoiceLine__c invoiceLine : listOfInvoiceLines)
            {
                if(NULL != invoiceLine.get(invoiceLineDetailAPIValue))
                {   
                     
                    invoiceLineDetail += '<item id= "' +counter+'">';
                    invoiceLineDetail += invoiceLine.get(invoiceLineDetailAPIValue);
                    invoiceLineDetail += '</item>';
                    counter = counter + 1;
                }
            }
            xMLRequest = xMLRequestBeforeMRC + invoiceLineDetail + '<purchaseTotals>' + xMLRequestAfterMRC;
            System.debug('inviceline-->xMLRequest===='+xMLRequest);
        }
        return xMLRequest;
    }
}