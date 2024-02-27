
module Preprocesado(
    input logic Ai, Bi, // Define las entradas Ai y Bi
    output logic P, G   // Define las salidas P y G
);

    // Implementa la lógica para las operaciones
    assign P = Ai ^ Bi; // P es el resultado de Ai XOR Bi
    assign G = Ai & Bi; // G es el resultado de Ai AND Bi

endmodule


module Black_Cell(
    input logic Gi, Pi, Gi_1, Pi_1, // Define las entradas Gi, Pi, Gi-1, Pi-1
    output logic P, G               // Define las salidas P y G
);

    // Implementa la lógica para las operaciones
    assign P = Pi & Pi_1;           // P es el resultado de Pi AND Pi-1
    assign G = (Pi & Gi_1) | Gi;    // G es el resultado de (Pi AND Gi-1) OR Gi

endmodule


module Suma(
    input logic Pi,       // Define la entrada Pi
    input logic Ci_1,     // Define la entrada del acarreo Ci-1
    output logic Si       // Define la salida Si
);

    // Implementa la lógica de la operación
    assign Si = Pi ^ Ci_1; // Si es el resultado de Pi XOR Ci-1

endmodule

module kogge_stone_4bit_adder(
    input logic sw [8:0] ,    // Entradas A0 a B3 y Cin
    output logic LED0, LED1, LED2, LED3, LED4  //carreo de salida
);

    logic P0_pre, G0_pre, P1_pre, G1_pre, P2_pre, G2_pre, P3_pre, G3_pre, P0_black, G0_black, P1_black, G1_black, P2_black, G2_black ;
    

Preprocesado Pre_0 (.Ai(sw[1]), .Bi(sw[5]), .P(P0_pre), .G(G0_pre) );
Preprocesado Pre_1 (.Ai(sw[2]), .Bi(sw[6]), .P(P1_pre), .G(G1_pre) );
Preprocesado Pre_2 (.Ai(sw[3]), .Bi(sw[7]), .P(P2_pre), .G(G2_pre) );
Preprocesado Pre_3 (.Ai(sw[4]), .Bi(sw[8]), .P(P3_pre), .G(G3_pre) );

Black_Cell black_0 (.Gi_1(G0_pre), .Pi_1(P0_pre), .Gi(G1_pre), .Pi(P1_pre), .P(P0_black), .G(G0_black) );
Black_Cell black_1 (.Gi_1(G1_pre), .Pi_1(P1_pre), .Gi(G2_pre), .Pi(P2_pre), .P(P1_black), .G(G1_black) );
Black_Cell black_2 (.Gi_1(G2_pre), .Pi_1(P2_pre), .Gi(G3_pre), .Pi(P3_pre), .P(P2_black), .G(G2_black) );

Black_Cell black_4 (.Gi_1(G0_pre), .Pi_1(P0_pre), .Gi(G1_black), .Pi(P1_black));
Black_Cell black_5 (.Gi_1(G0_black), .Pi_1(P0_black), .Gi(G2_black), .Pi(P1_black), .G(LED4));

Suma S_0 (.Pi(P0_rojo), .Ci_1(sw[0]), .Si(LED0));
Suma S_1 (.Pi(P1_rojo), .Ci_1(G0_pre), .Si(LED1));
Suma S_2 (.Pi(P2_rojo), .Ci_1(G1_pre), .Si(LED2));
Suma S_3 (.Pi(P3_rojo), .Ci_1(G2_pre), .Si(LED3));


endmodule