



module memory(controler, disk_controler, index_lw, index, data_in, operation, data_out, RESPONSE);

input [7:0] index;
input [7:0] index_lw;
input [7:0] data_in;
input disk_controler;
input operation;
input controler;

output [7:0] data_out;
output RESPONSE;

reg [7:0] CACHE;
reg [7:0] MEMORY [255:0];
reg res;

initial res = 0;

assign data_out = CACHE;
assign RESPONSE = res;

always @(controler or disk_controler) begin

	if(operation == 0) begin //Leitura
		CACHE = MEMORY[index_lw];
		res = !res;
	end  else
	if(operation == 1) begin //Gravacao
		MEMORY[index] = data_in;
		res = !res;
	end
end



endmodule