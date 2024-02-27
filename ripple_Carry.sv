

// Se crea el primer modulo el cual sera la base del funcionamiento, este es un full adder de 1 bit 
module one_bit_full_adder(
    input logic a, b, cin,
    output logic s,cout
    );
    
    logic p, g; 
    always_comb
        begin
            p = a ^ b ;
            g = a & b;
            s = p ^ cin;
            
            cout = g | (p & cin);
         end

endmodule

// Tomando de base el full adder anterior se obtiene un full adder de 2 bits
module two_bit_full_adder(
    input logic A0, B0, A1, B1, Cin,
    output logic s0, s1, cout
    );

    logic cout_bit0;
    
    one_bit_full_adder adder_bit0 (.a(A0), .b(B0), .cin(Cin), .s(s0), .cout(cout_bit0));
    one_bit_full_adder adder_bit1 (.a(A1), .b(B1), .cin(cout_bit0), .s(s1), .cout(cout));
    

endmodule

// Tomando de base el full adder de 2 bits podemos llamar a sus atributos y obtener un full adder de 4 bits
module four_bit_full_adder(
input logic A0, B0, A1, B1, A2, B2, A3, B3, Cin,
output logic s0, s1, s2, s3, cout
    );

    logic cout_bit0;

    two_bit_full_adder adder_bits0_1 (.A0(A0), .B0(B0), .A1(A1), .B1(B1), .Cin(Cin), .s0(s0), .s1(s1), .cout(cout_bit0));
    two_bit_full_adder adder_bits2_3 (.A0(A2), .B0(B2), .A1(A3), .B1(B3), .Cin(cout_bit0), .s0(s2), .s1(s3), .cout(cout));
endmodule
    
// Tomando de base el full adder de 4 podemos mapear las salidas a switches de la fpga asi como las salidas de las LED que representan una salida
module eight_bit_full_adder(

input logic [16:0]sw,
output logic [8:0]LED
    );


    logic cout_bit3;

    // Primera instancia de four_bit_full_adder para sumar los bits 0 a 3
    four_bit_full_adder adder_03 (.A0(sw[0]), .B0(sw[1]), .A1(sw[2]), .B1(sw[3]),.A2(sw[4]), .B2(sw[5]), .A3(sw[6]), .B3(sw[7]),.Cin(sw[8]), .s0(LED[0]), .s1(LED[1]), .s2(LED[2]), .s3(LED[3]), .cout(cout_bit3));
    four_bit_full_adder adder_47 (.A0(sw[9]), .B0(sw[10]), .A1(sw[11]), .B1(sw[12]),.A2(sw[13]), .B2(sw[14]), .A3(sw[15]), .B3(sw[16]),.Cin(cout_bit3), .s0(LED[4]), .s1(LED[5]), .s2(LED[6]), .s3(LED[7]), .cout(LED[8]));
endmodule

