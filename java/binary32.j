public static int binary32(int sign, int coefficient, int expon_sign, int exponent){
            // $a0 : sign
            // $a1 : coefficient
            // $a2 : expon_sign
            // $a3 : exponent
            int encoding; // : return value

            int encoded_sign;
            int encoded_mantissa;
            int encoded_exponent;
            int position;          // the location of the msb of the coefficient
            int coefficient_shift;
            int negative_sign;

            final int bias           = 127;  // As defined by the spec
            final int sign_shift     =  31;  //   << (8 + 23 )
            final int expon_shift    =  23;  //   << (23)
            final int mantissa_shift =   9;  //  >>> (1 + 8)  // the mantissa is left-justified
            final int $zero          =   0;  

            /////////////////////////////////////////////////////////
            // BEGIN CODE of INTEREST
            /////////////////////////////////////////////////////////

            negative_sign = '-';     // Define the value

            /////////////////////////////////////////////////////////
            // 1. Encode each of the three fields of the floating point format:

            // 1.1 Sign Encoding: (encoded_sign = )
            //     - Based upon the sign, encode the sign as a binary value
            if (sign == negative_sign) 
            {
              sign = 1;
            }
            else
            {
              sign = 0;
            }
            // 1.2 Exponent Encoding: (encoded_expon = )
            //     - Make the exponent a signed quantity
            //     - Add the bias
            if (expon_sign == negative_sign) {
 
            }
            
            // 1.3  Mantissa Encoding: (encoded_mantissa = )
            //      - Determine the number of bits in the coefficient
            //        - that is to say, find the position of the most-significant bit
            //      - Shift the coefficient to the left to obtain the mantissa
            //        - the whole number is now removed, and
            //        - the mantissa (which is a fractional value) is left-justified
            position = pos_msb(coefficient);
  

            encoded_mantissa = 0;

            /////////////////////////////////////////////////////////
            // 2. Shift the pieces into place: sign, exponent, mantissa
            encoded_sign     = 0;
            encoded_exponent = 0;
            encoded_mantissa = 0;
            
            /////////////////////////////////////////////////////////
            // 3. Merge the pieces together
            encoding = 0;

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
