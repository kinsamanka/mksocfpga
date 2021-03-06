module hm2reg_io (
        // signals to connect to an Avalon clock source interface
        input clk,
	input reset_n,
	// signals to connect to an Avalon-MM slave interface
	input [ADDRESS_WIDTH-1:0] slave_address,
	input slave_read,
	input slave_write,
	output reg [DATA_WIDTH-1:0] slave_readdata,
	input [DATA_WIDTH-1:0] slave_writedata,
	input slave_chipselect,
//	input slave_waitreq,
        // signals to connect to custom con logic
//	output waitrequest,
	output reg [DATA_WIDTH-1:0] con_dataout,
	input [DATA_WIDTH-1:0] con_datain,
	output reg [ADDRESS_WIDTH-1:0] con_adrout,
	output reg con_write_out,
	output reg con_read_out,
	output reg con_chip_sel
);

parameter ADDRESS_WIDTH = 14;          // address size width
parameter DATA_WIDTH = 32;          // word size of each input and output register

//reg [DATA_WIDTH-1:0] indata;
//reg [DATA_WIDTH-1:0] outdata;
//reg write_delay;
//reg reg_w_act;

//wire w_act = (write | write_delay);
//wire write_active = (write | reg_w_act); 

//assign con_chip_sel = slave_chipselect;
//assign dataout = (!read && write_active && !waitreq) ? outdata : 32'bz;
//assign con_dataout = outdata;
//assign slave_readdata = indata;
//assign con_adrout[ADDRESS_WIDTH-1:0] = slave_address[ADDRESS_WIDTH-1:0]; 
//assign con_read_out = slave_read;
//assign con_write_out = slave_write;

/*
always @(posedge clk) begin
	write_delay <= write;
	reg_w_act <= w_act;
end
*/

always @(posedge clk) begin
	if (!reset_n) begin
		slave_readdata[DATA_WIDTH-1:0] <= 0;
		con_dataout[DATA_WIDTH-1:0] <= 0;
		con_adrout[ADDRESS_WIDTH-1:0] <= 0;
		con_chip_sel <= 0;
		con_read_out <= 0;
		con_write_out <= 0;

	end
	else begin
		con_chip_sel <= slave_chipselect;
		con_read_out <= slave_read;
		con_write_out <= slave_write;
		con_adrout[ADDRESS_WIDTH-1:0] <= slave_address[ADDRESS_WIDTH-1:0];
		if (slave_read) begin
			slave_readdata[DATA_WIDTH-1:0] <= con_datain[DATA_WIDTH-1:0];
		end
		if	(slave_write) begin
			con_dataout <= slave_writedata;	
		end
	end
end

endmodule
