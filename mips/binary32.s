                            .text
                            .globl binary32
                            .include "include/stack.s"
                            .include "include/syscalls.s"
                            .include "include/subroutine.s"

                            .macro call( %sub, %arg)
                              save_state()
                              push($a0)
                              move $a0, %arg
                              jal %sub
                              pop($a0)
                              restore_state()
                           .end_macro                                                     





                                                    ##public static int binary32(int sign, int coefficient, int expon_sign, int exponent){
                         
                    
binary32:               nop                         #;
                                                    ##int encoding; // : return value
                                                    ##int encoded_sign;
                                                    ##int encoded_mantissa;
                                                    ##int encoded_exponent;
                                                    ##int position;          // the location of the msb of the coefficient
                                                    ##int coefficient_shift;
                                                    ##int negative_sign;
                                                    ##final int bias           ;  // As defined by the spec
                                                    ##final int sign_shift     ;  //   << (8 + 23 )
                                                    ##final int expon_shift    ;  //   << (23)
                                                    ##final int mantissa_shift ;  //  >>> (1 + 8)  // the mantissa is left-justified
                                                    ##final int $zero          ;              
                        li $t0, 127                 ##bias = 127;
                        li $t1, 31                  ##sign_shift = 31;                                  
                        li $t2, 23                  ##expon_shift = 23;
                        li $t3, 9                   ##mantissa_shift = 9;                                
                        li $t4, 0                   ##$zero = 0;                            
                                                                           
                    
                        li $t5, 45                  #negative_sign = '-';                                                
                                                              
                                                                        
                        beq $a0, $t5, signNeg       #if (sign == negative_sign) 
                                                    #{
signNeg:                nop                         #;                                   
                                                    #  encoded_sign = 1;
                                                    #}
                                                    #else
                                                    #{
signPos:                                            #;                                  
                                                    #  encoded_sign = 0;
                                                    #}
                                                                          
                                                    #if (expon_sign == negative_sign) 
                                                    #{#
exponPos:                                           #;                                  
                                                    #  exponent = exponent * -1;
                                                    #  encoded_exponent = exponent + bias;
                                                    #}
                                                    #else
                                                    #{#
exponNeg:                                           #;                                  
                                                    #  encoded_exponent = exponent + bias;
                                                    #}
                                                                          
                                                                         
startAgain:                                         #;                                                      
                                                    #position = pos_msb(coefficient);
                                                    #position = position * -1;
                    
mantissashift:                                      #;
                                                    #encoded_mantissa = 0;
                                                    #coefficient_shift = position + 33;
                                                    #encoded_mantissa = (coefficient << coefficient_shift);
                                
                    
finalencoding:                                      #;                                                      
                                                    #encoded_sign     = encoded_sign << sign_shift;
                                                    #encoded_exponent = encoded_exponent << expon_shift;
                                                    #e#ncoded_mantissa = encoded_mantissa >>> mantissa_shift;
                                
                                                                          
                                                    #encoding = encoding = encoded_sign | encoded_exponent | encoded_mantissa; 
                    
                                                    #r#eturn encoding;
                                                    #}