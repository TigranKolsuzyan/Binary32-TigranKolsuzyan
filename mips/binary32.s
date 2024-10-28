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
                                                    ##$zero = 0;                            
                                                                           
                    
                        li $t4, 45                  #negative_sign = '-';                                                
                                                              
                                                                        
                        beq $a0, $t4, signNeg       #if (sign == negative_sign) 
                                                    #{
signPos:                nop                         #;                                   
                        li $t5, 0                   #  encoded_sign = 1;
                        j ifconditional             #}
                                                    #else
                                                    #{
signNeg:                nop                         #;                                  
                        li $t5, 1                   #  encoded_sign = 0;
                                                    #}
                                                                          
ifconditional:          nop
                        beq $a2, $t4, exponNeg
                                                    #if (expon_sign == negative_sign) 
                                                    #{#
exponPos:               nop                         #;                                  
                        add $t6, $a3, $t0           #  exponent = exponent * -1;
                        j startAgain                #  encoded_exponent = exponent + bias;
                                                    #}
                                                    #else
                                                    #{#
exponNeg:               nop                         #;                                  
                        mul $a3, $a3, $t4           #}
                        add $t6, $a3, $t0           #  encoded_exponent = exponent + bias;
                                                    #}
                                                                      
                                                                         
startAgain:             nop                         #;                                                      
                        call pos_msb $a1  
                        move $t7, $v0               #position = pos_msb(coefficient);
                        mul $t7, $t7, -1            #position = position * -1;
                    
mantissashift:          nop                         #;
                                                    #encoded_mantissa = 0;
                        addi $t9, $t7, 33           #coefficient_shift = position + 33;
                        sllv $t8, $a1, $t9          #encoded_mantissa = (coefficient << coefficient_shift);
                                
                    
finalencoding:          nop                         #;                                                      
                        sllv $t5, $t5, $t1          #encoded_sign     = encoded_sign << sign_shift;
                        sllv $t6, $t6, $t2          #encoded_exponent = encoded_exponent << expon_shift;
                        srlv $t8, $t8, $t3          #e#ncoded_mantissa = encoded_mantissa >>> mantissa_shift;
                                
                                                                          
                        or $v0, $t5, $t6            #encoding = encoding = encoded_sign | encoded_exponent | encoded_mantissa; 
                        or $v0, $v0, $t8
                        jr $ra                      #r#eturn encoding;
                                                    #}


pos_msb:
                        li $t0, 0
loop:
                        bne $a0, $zero, body
                        j done
body:
                        srl $a0, $a0, 1
                        addi $t0, $t0, 1
                        j loop
done:
                        move $v0, $t0
                        jr $ra                             