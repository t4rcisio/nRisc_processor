/*Projeto processador nRisc
Aluno: Tarcisio Batista Prates 
*********************/

/**********************
MODULO: PROGRAM COUNTER

-> SEQUENCIADOR PARA A LEITURA DAS INSTRUCOES
**********************/


module program_counter(CLOCK, USER, USER_PC, PC);

input CLOCK, USER;
input [7:0]USER_PC;

output [7:0]PC;

reg [7:0]counter;

initial counter = 8'b00000000;

assign PC = counter;


always @(negedge CLOCK or posedge USER) begin

		if(USER) begin
			counter = USER_PC;
		end else
			counter = counter + 1;
end



endmodule