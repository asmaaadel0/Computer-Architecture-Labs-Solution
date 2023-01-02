////////////////////////////BONUS GENERICS//////////////////////////
module reg_file_1 #(parameter Num_of_bits=16, Num_of_registers=8,Address_Width=3) (input reset,
            input clk,
            input write_enable,
            input read_enable,
            input [Address_Width-1:0]read_addr,
            input [Address_Width-1:0]write_addr,
            input [Num_of_bits-1:0]write_data,
            output reg [Num_of_bits-1:0]read_data,
			output reg error_signal);

    reg [Num_of_bits-1:0]mem[Num_of_registers-1:0];

    integer i;

    // priority of reset is higher than positive edge of the clk
    always @(posedge clk, reset)
    begin
	error_signal=0;
        if (reset) 
        begin
            read_data =16'bzzzzzzzzzzzzzzzz;
            for (i=0; i<Num_of_registers; i=i+1)
                mem[i]=0;
        end
		
		//if I want to write and read at the same time at the same register then
        // read data will be 16'bz and the write data will be ignored
		else if(write_enable & read_enable & write_addr==read_addr)
		begin
			read_data = 16'bzzzzzzzzzzzzzzzz;
			error_signal=1;
		end
		
		
		//if I write in registers, I write to the write_addr in memory
        else
		begin
		
		if (write_enable) 
		begin
            mem[write_addr]=write_data;
			read_data=16'bzzzzzzzzzzzzzzzz;
        end
		
		
		//if I read from registers, I read from the read_addr in memory
        if (read_enable) 
		begin
            read_data <= mem[read_addr];		
        end
		
		else read_data = 16'bzzzzzzzzzzzzzzzz;
		
		end
		
		

    end



endmodule

