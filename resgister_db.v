/*********************
LAB AOC1
Projeto processador nRisc
Aluno: Tarcisio Batista Prates 
*********************/

/**********************
MODULO: BANCO DE REGISTRADORES

-> ARMAZENA OS DADOS DOS REGISTRADORES
**********************/


module register_db(LI_CONTROLER,OPERATION, INDEX_0, INDEX_1, DATA_IN, DATA_OUT_0, DATA_OUT_1, RESPONSE);

input [2:0]INDEX_0; //REGISTRADOR A
input [2:0]INDEX_1; //REGISTRADOR B

input [7:0]DATA_IN; //VALOR IMEDIATO

input LI_CONTROLER;
input [1:0] OPERATION;

output [7:0]DATA_OUT_0; // VALOR DOS REGISTRADORES
output [7:0]DATA_OUT_1;
output RESPONSE;


reg [7:0] MEMORY [7:0];       //MATRIZ MEMORIA

reg [7:0]CACHE_0;					//TROCA OS DADOS ENTRE A MEMORIA E A SAIDA
reg [7:0]CACHE_1;					// RAGISTRADORES A E B
reg res;

assign DATA_OUT_0 = CACHE_0;
assign DATA_OUT_1 = CACHE_1;
assign RESPONSE = res;

initial MEMORY[0] = 0;
initial res = 0;


always @(LI_CONTROLER) begin

	if(OPERATION == 2'b00) begin   //ESCRITA
		MEMORY[INDEX_0] = DATA_IN;
	end 
	else
	if(OPERATION == 2'b01) begin   //LEITURA
		CACHE_0 = MEMORY[INDEX_0];
		CACHE_1 = MEMORY[INDEX_1];
		res = !res;
	end
	else
	if(OPERATION == 2'b10) begin   //LEITURA
		CACHE_0 = MEMORY[INDEX_0];
		res = !res;
	end
end


endmodule 

