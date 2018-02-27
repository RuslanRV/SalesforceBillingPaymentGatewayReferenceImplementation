// ============================================================================================= 
//  Object: CyberSourceAPI
//  Company: Salesforce
//  Author: Himanshu Kapoor/ Vinod KR/ Devender / Manigandan SA
//  Purpose: Service Layer - Transaction Service methods to perform operations related to Payment. 
//                           It contains declaration of all the behaviours to be performed by this class. This would  
//                           be the entry point for the client layer to access the api.
//  Methods: Following are the methods and their one line description
//              
//  Created: 2016-07-22
// ============================================================================================= 
// Use Cases or Requirements:  
// @UseCase number - @requirement Description       
// =============================================================================================  
// Changes: @Date Author
//          @Description
// ============================================================================================= 
global class CyberSourceAPI implements blng.PaymentGateWay,blng.PaymentGateWays
{
    // ============================================================================
    // CONSTANT 
    // ============================================================================
    
    // ============================================================================
    // STATIC VARIABLES
    // ============================================================================
    
    // Attribute to implement singleton pattern for CyberSource class
    private static CyberSource CyberSourceInstance;

    // ============================================================================
    // VARIABLES
    // ============================================================================
    // Attributes to implement singleton pattern for CyberSource class
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
    private static final String PROCESS_PAYMENTS = 'processPayments';
    // ============================================================================
    // Methods
    // ============================================================================
    /**
    * @name service
    * @description service method to create an only instance of TransactionService class
    *              if serviceInstance is NULL then only create a new instance otherwise 
    *              return the existing one
    * @param   NA 
    * @return TransactionService instance
    * @exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-22
    * @remark 
    * @change
    */   
    @TestVisible
    private static CyberSource service()
    {
        if (NULL == CyberSourceInstance)
        {
            CyberSourceInstance = CyberSource.getInstance();
        }
        return CyberSourceInstance;
    }
     /**
    * @name processPayments
    * @description Method to assign parameters
    * @param 
    * @return Map [key =>String, Value => blng.TransactionResult] mapOfTransactionResultById
    * @exception
    * @author Dhanalakshmi/Raghavendra/ Vinod KR
    * @created 2016-11-03
    * @remark 
    * @change
    */   
    global static Map<String, blng.TransactionResult> processPayments(Map<String, blng.TransactionParameter> mapOfTransactionParameterById, blng.PaymentGatewayParameter paymentGatewayParameter)
    {
        if(paymentGatewayParameter.getTransactionType() == GENERATE_TOKEN)
        {
            return generateToken(mapOfTransactionParameterById);
        }
        else if(paymentGatewayParameter.getTransactionType() == AUTHORIZE_TRANSACTION)
        {
            return authorizeTransaction(mapOfTransactionParameterById);
        }
        else if(paymentGatewayParameter.getTransactionType() == CHARGE_TRANSACTION)
        {
            return chargeTransaction(mapOfTransactionParameterById);
        }
        else if(paymentGatewayParameter.getTransactionType() == VOID_TRANSACTION)
        {
            return voidTransaction(mapOfTransactionParameterById);
        }
        else if(paymentGatewayParameter.getTransactionType() == REFUND_TRANSACTION)
        {
            return refundTransaction(mapOfTransactionParameterById);
        }
        else if(paymentGatewayParameter.getTransactionType() == CAPTURE_TRANSACTION)
        {
            return captureTransaction(mapOfTransactionParameterById);
        }
        else if(paymentGatewayParameter.getTransactionType() == VOID_REFUND_TRANSACTION)
        {
            return voidRefundTransaction(mapOfTransactionParameterById);
        }
        else if(paymentGatewayParameter.getTransactionType() == VOID_TOKEN_TRANSACTION)
        {
            return voidTokenTransaction(mapOfTransactionParameterById);
        }
        else if(paymentGatewayParameter.getTransactionType() == GET_PAYMENT_STATUS)
        {
            return getPaymentStatus(mapOfTransactionParameterById);
        }
        else if(paymentGatewayParameter.getTransactionType() == GET_REFUND_STATUS)
        {
            return getRefundStatus(mapOfTransactionParameterById);
        }
        else if(paymentGatewayParameter.getTransactionType() == NON_REFERRED_REFUND)
        {
            return nonReferredRefund(mapOfTransactionParameterById);
        }

        return NULL;
       }

    /**
    * @name generateToken
    * @description Method to generate Token for a Payment Method
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception 
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-22
    * @remark 
    * @change
    */    
    global static Map<String, blng.TransactionResult> generateToken(Map<String, blng.TransactionParameter> mapOfTransactionParameterById) 
    {
        return service().generateToken(mapOfTransactionParameterById);
    }

    /**
    * @name voidTokenTransaction
    * @description Method to void Token for a Payment method Token
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception
    * @author Dhanalakshmi
    * @created 2017-06-02
    * @remark
    * @change
    */    
    global static Map<String, blng.TransactionResult> voidTokenTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById) 
    {
        return service().voidTokenTransaction(mapOfTransactionParameterById);
    }


    /**
    * @name authorizeTransaction
    * @description Method to Authorize a payment for a Invoice
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception
    * @author Balachary 
    * @created 2017-06-01
    * @remark 
    * @change
    */  
    global static Map<String, blng.TransactionResult> authorizeTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById) 
    {
        return service().authorizeTransaction(mapOfTransactionParameterById);
    }

    /**
    * @name chargeTransaction
    * @description Method to Charge a payment for a Invoice
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception
    * @author Manigandan SA / Vinod KR 
    * @created 2016-07-22
    * @remark 
    * @change 
    */      
    global static Map<String, blng.TransactionResult> chargeTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById) 
    {
        return service().chargeTransaction(mapOfTransactionParameterById);
    }

    /**
    * @name captureTransaction
    * @description Method to capture a payment for a Authorize Transaction
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception 
    * @author Manigandan SA
    * @created 2017-05-30
    * @remark 
    * @change
    */      
    global static Map<String, blng.TransactionResult> captureTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById) 
    {
        return service().captureTransaction(mapOfTransactionParameterById);
    }


    /**
    * @name voidTransaction
    * @description Method to Void a payment for a Invoice
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception
    * @author Raghavendra Reddy
    * @created 2017-06-01
    * @remark 
    * @change 
    */      
    global static Map<String, blng.TransactionResult> voidTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById) 
    {
        return service().voidTransaction(mapOfTransactionParameterById);
    }

    /**
    * @name refundTransaction
    * @description Method to Refund a payment for a payment Transaction
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-22
    * @remark
    * @change
    */ 
    global static Map<String, blng.TransactionResult> refundTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById) 
    {
        return service().refundTransaction(mapOfTransactionParameterById);
    }

    /**
    * @name nonReferencedRefund
    * @description Method to non Referenced Refund a payment for a Invoice
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionParameter]
    * @exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-22
    * @remark
    * @change
    */ 
    global static Map<String, blng.TransactionResult> nonReferredRefund(Map<String, blng.TransactionParameter> mapOfTransactionParameterById) 
    {
        return service().nonReferencedRefund(mapOfTransactionParameterById);
    }

    /**
    * @name voidRefundTransaction
    * @description Method to Void refund for a Refund Transaction
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception
    * @author Raghavendra Reddy
    * @created 2017-06-01
    * @remark 
    * @change
    */      
    global static Map<String, blng.TransactionResult> voidRefundTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById) 
    {
        return service().voidRefundTransaction(mapOfTransactionParameterById);
    }
    
    /**
    * @name getPaymentStatus
    * @description Method to get payment status for a Payment Transaction
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception
    * @author Ramachandran
    * @created 2017-05-30
    * @remark 
    * @change
    */      
    global static Map<String, blng.TransactionResult> getPaymentStatus(Map<String, blng.TransactionParameter> mapOfTransactionParameterById) 
    {
        return service().getPaymentStatus(mapOfTransactionParameterById);
    }
    
    /**
    * @name getRefundStatus
    * @description Method to get refund status for a Refund Transaction
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return Map[Key => String [unique Id],Value => TransactionResult]
    * @exception
    * @author Ramachandran
    * @created 2017-05-30
    * @remark 
    * @change
    */      
    global static Map<String, blng.TransactionResult> getRefundStatus(Map<String, blng.TransactionParameter> mapOfTransactionParameterById) 
    {
        return service().getPaymentStatus(mapOfTransactionParameterById);
    }
}