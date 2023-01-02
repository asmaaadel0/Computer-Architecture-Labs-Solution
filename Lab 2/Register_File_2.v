
////////////////////////////BONUS GENERICS//////////////////////////
module reg_file_2 #(parameter Num_of_bits=16, Num_of_registers=8, Address_Width = 3)(input reset,
            input clk,
            input write_enable, read_enable,
            input [Address_Width -1:0] read_addr ,
            input [Address_Width -1:0] write_addr ,
            input [Num_of_bits-1:0]write_data,
            output wire [Num_of_bits-1:0]read_data,
			output wire error_signal);
			wire [2**Address_Width -1 :0] read_enables;
			wire [2**Address_Width -1 :0] write_enables;




//decoder to know which register will be enabled
decoder decoder_read(read_addr,read_enables);
decoder decoder_write(write_addr,write_enables);


genvar i;



generate


  for (i=0; i<Num_of_registers; i=i+1) begin
    register #(Num_of_bits) register_i (

      .reset (reset),

      .clk (clk),

      .read_data (read_data),

      .write_data (write_data),

      .read_enable (read_enables[i] & read_enable),

      .write_enable (write_enables[i] & write_enable),
	   
	  .error_signal(error_signal)

    );

  end

endgenerate
endmodule