public static int binary32(int sign, int coefficient, int expon_sign, int exponent){
                                                     
    int encoding; // : return value
    int encoded_sign;
    int encoded_mantissa;
    int encoded_exponent;
    int position;          // the location of the msb of the coefficient
    int coefficient_shift;
    int negative_sign;
    final int bias           ;  // As defined by the spec
    final int sign_shift     ;  //   << (8 + 23 )
    final int expon_shift    ;  //   << (23)
    final int mantissa_shift ;  //  >>> (1 + 8)  // the mantissa is left-justified
    final int $zero          ;              
    bias = 127;
    sign_shift = 31;                                  
    expon_shift = 23;
    mantissa_shift = 9;                                
    $zero = 0;                            
                                                       

     negative_sign = '-';                                                
                                          
                                                     
    if (sign == negative_sign) 
    {
      encoded_sign = 1;
    }
    else
    {
      encoded_sign = 0;
    }
                                                      
    if (expon_sign == negative_sign) 
    {
      exponent = exponent * -1;
      encoded_exponent = exponent + bias;
    }
    else
    {
      encoded_exponent = exponent + bias;
    }
                                                      
                                                     
                                                      
    position = pos_msb(coefficient);
    position = position * -1;

    encoded_mantissa = 0;
    coefficient_shift = position + 33;
    encoded_mantissa = (coefficient << coefficient_shift);
            

                                                      
    encoded_sign     = encoded_sign << sign_shift;
    encoded_exponent = encoded_exponent << expon_shift;
    encoded_mantissa = encoded_mantissa >>> mantissa_shift;
            
                                                      
    encoding = encoding = encoded_sign | encoded_exponent | encoded_mantissa; 

    return encoding;
  }

  /////////////////////////////////////////////////////////
  // END CODE of INTEREST
  /////////////////////////////////////////////////////////

  static int pos_msb(int number){
          // $a0 : number

          int counter;      // : counter: the return value

          counter = 0;
  init:   ;
  loop:   for(; number != 0 ;) {
  body:     ;
            number = number >>> 1;
            counter ++;
            continue loop;
          }
  done:   ;
          return counter;
  }
                                          // 