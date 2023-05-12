function [Kano_value] = Kano_(x,Da)

Kano_safety =                          -(Da.CS(1)-Da.DS(1))*exp(1)/(exp(1)-1)*exp(-x)+...
                                                  (exp(1)*Da.CS(1)-Da.DS(1))/(exp(1)-1);

Kano_disassembly=                  (Da.CS(2)-Da.DS(2))*x + Da.DS(2);

Kano_charging_efficiency =     (Da.CS(3)-Da.DS(3))/(exp(1)-1)*exp(x)-...
                                                   (Da.CS(3)-exp(1)*Da.DS(3))/(exp(1)-1);

Kano_reliability =                      -(Da.CS(4)-Da.DS(4))*exp(1)/(exp(1)-1)*exp(-x)+...
                                                    (exp(1)*Da.CS(4)-Da.DS(4))/(exp(1)-1);
Kano_Operating_convenience= (Da.CS(5)-Da.DS(5))/(exp(1)-1)*exp(x)-...
                                                    (Da.CS(5)-exp(1)*Da.DS(5))/(exp(1)-1);

Kano_value = Kano_safety +Kano_disassembly+Kano_charging_efficiency +...
                        Kano_reliability+Kano_Operating_convenience;




end