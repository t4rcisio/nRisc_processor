/*********************
LAB AOC1
Projeto processador nRisc
Aluno: Tarcisio Batista Prates 
*********************/

/**********************
MODULO: MAIN

-> GERENCIA AS ETAPAS DO PROCESSADOR
**********************/

module nRisc_core(CLOCK);

input CLOCK;


wire [7:0] memory_instruction;
wire [7:0] pc;
wire [7:0] register_data;
wire [7:0] DATA_OUT_0;
wire [7:0] DATA_OUT_1;



reg [2:0] m_instruction; //Registra o tipo de instrucao
reg [2:0] INDEX_0;       //Registra o endereco do registrador "A" da instrucao
reg [2:0] INDEX_1;		 //Registra o endereco do registrador "B" da instrucao
reg [2:0] INDEX_LW;


reg disk_operation;		 //Regula o tipo de operacao no disco de memoria
reg [1:0]li_operation;			 //Regula o tipo de operacao no banco de registradores

reg [7:0] DATA_IN;		 //REGISTRADOR PARA AUXILIO DO IMEDIATO 

reg li_controler;   		 //Controla a execucao das instrucoes no banco de registradores
reg disk_controler;

reg li_signal;				 //Auxiliar para opercacoes de imediato (simula o multi-ciclo)




initial li_controler = 0;
initial li_signal = 0;
initial disk_controler = 0;



program_counter    pc_counter(CLOCK, USER, USER_PC, pc); 
RAM                loadInstruction(pc, memory_instruction);
register_db        register_table(li_controler, li_operation, INDEX_0, INDEX_1, DATA_IN, DATA_OUT_0, DATA_OUT_1, RDB_RESPONSE);
//memory             memory_disk(controler, index, data_in, operation, data_out);
memory             memory_disk(RDB_RESPONSE, disk_controler, INDEX_LW, DATA_OUT_1, DATA_OUT_0, disk_operation, data_out, DISK_RESPONSE);

always @(memory_instruction) begin

	m_instruction = memory_instruction[7:5];	//Obtem o tipo da instrucao
	
	if(m_instruction == 3'b011)begin				// load imediato
		INDEX_0 = memory_instruction[4:2];
		li_operation =  2'b00;
		li_signal = 1;
		end
	else if(li_signal == 1) begin					// Simula o multi-ciclo para load imediato
			DATA_IN = memory_instruction;
			li_controler = !li_controler;
			li_signal = 0;
			end
	else if (m_instruction == 3'b100) begin	//Store word
		INDEX_0 = memory_instruction [4:2];
		INDEX_1 = memory_instruction [1:0];
		li_operation = 2'b01;
		li_controler = !li_controler;
		disk_operation = 1;
		end
	else if(m_instruction == 3'b101) begin		//Load Word	
		li_controler = !li_controler;
		li_operation = 3'b010;
		INDEX_0 = memory_instruction[1:0];
	end
end


endmodule