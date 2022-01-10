/*********************
LAB AOC1
Projeto processador nRisc
Aluno: Tarcisio Batista Prates 
*********************/

/**********************
MODULO: MEMORIA RAM

-> ARMAZENA O PROGRAMA A SER EXECUTADO
**********************/


module RAM(pc, memory_instruction);

input [7:0]pc;
output [7:0]memory_instruction;


reg [7:0] memory [255:0];

initial 
begin

	memory[0] = 8'b01111100;
	memory[1] = 8'b00001010;
	memory[2] = 8'b01101100;
	memory[3] = 8'b00000001;
	memory[4] = 8'b01110100;
	memory[5] = 8'b00000111;
	memory[6] = 8'b01111000;
	memory[7] = 8'b00000001;
	memory[8] = 8'b10001100;
	memory[9] = 8'b10110000;

end

assign memory_instruction = memory[pc];


endmodule