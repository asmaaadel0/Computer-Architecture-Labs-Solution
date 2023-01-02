module encoder (enable, in, out, validOut);
input [7:0] in;
output reg [2:0] out;
output reg validOut;
input enable;
always @(enable, in)
begin 
///////////////////////////////////////////////////////////////////////////
//first initialize valid bit = 1.
validOut = 1;
if(enable == 0)
begin 
/////
//if inable =0, the output = zzz, and valid bit = 0.
out=3'bzzz;
validOut = 0;
/////
end

else if (enable == 1)
begin
////////////////////////
//if inable =1,and the input = 1|2|3|4|5|6|7|8,then valid bit = 1(like the initialization).
if(in == 8'b0000_0001) out=3'b000;
else if(in == 8'b0000_0010) out=3'b001;
else if(in == 8'b0000_0100) out=3'b010;
else if(in == 8'b0000_1000) out=3'b011;
else if(in == 8'b0001_0000) out=3'b100;
else if(in == 8'b0010_0000) out=3'b101;
else if(in == 8'b0100_0000) out=3'b110;
else if(in == 8'b1000_0000) out=3'b111;

else
begin
/////
//if the input is invalid then valid bit = 0, and output = xxx.
out = 3'bxxx;
validOut = 0;
/////
end

////////////////////////
end


///////////////////////////////////////////////////////////////////////////
end
endmodule
