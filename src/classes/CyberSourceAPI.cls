/*
 * Copyright (c) 2020, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root
 * https://github.com/forcedotcom/SalesforceBillingPaymentGatewayReferenceImplementation/blob/master/LICENSE.txt 
 */

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
global class CyberSourceAPI implements blng.PaymentGateWay
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
    * @name generateToken
    * @description Method to generate Token
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return 
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
    * @name authorizeTransaction
    * @description Method to Authorize a payment for a Invoice
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return 
    * @exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-22
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
    * @return 
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
    * @name voidTransaction
    * @description Method to Void a payment for a Invoice
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return 
    * @exception
    * @author Manigandan SA / Vinod KR
    * @created 2016-07-22
    * @remark 
    * @change
    */      
    global static Map<String, blng.TransactionResult> voidTransaction(Map<String, blng.TransactionParameter> mapOfTransactionParameterById) 
    {
        return service().voidTransaction(mapOfTransactionParameterById);
    }

     /**
    * @name refundTransaction
    * @description Method to Refund a payment for a Invoice
    * @param Map[Key => String [unique Id],Value => TransactionParameter]
    * @return 
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
}
