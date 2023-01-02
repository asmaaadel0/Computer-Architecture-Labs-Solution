////////////////////////////BONUS GENERICS//////////////////////////
module register #(parameter Num_of_bits=16) (reset,clk,read_data,write_data,read_enable,write_enable,error_signal);

input [Num_of_bits-1:0] write_data; //data_in
input clk;
input reset;
input read_enable, write_enable;
output reg [Num_of_bits-1:0] read_data; //data_out
output reg error_signal;
reg [Num_of_bits-1:0] data_reg;
 

// priority of reset is higher than positive edge of the clk
always @ (posedge clk, reset)
begin

error_signal=0;
if(reset) begin
 data_reg <= 16'b0;
 read_data =16'bzzzzzzzzzzzzzzzz;
end

//if I want to write and read at the same time at the same register then
// read data will be 16'bz and the write data will be ignored
else if((write_enable) && (read_enable)) begin
error_signal=1'b1;
read_data = 16'bzzzzzzzzzzzzzzzz;
end


//if I want to write and the write address = my address then data of the register wil be the write data
//and the read data will be 16'bz 
else if (write_enable) 
   begin
      data_reg=write_data;
      read_data=16'bzzzzzzzzzzzzzzzz;
   end


//if I want to read data then read data will be the data which is in my register
else if (read_enable) 
   begin
      read_data = data_reg;
   end
   
//if it's not my address then read data will be 16'bz   
else  begin
read_data = 16'bzzzzzzzzzzzzzzzz;
error_signal=1'bz;
end


end


endmodule

