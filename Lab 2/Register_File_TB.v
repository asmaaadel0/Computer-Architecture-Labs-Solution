module regfile_TB();    
			localparam Num_of_bits=16;
			localparam Num_of_registers=8;
			localparam Address_Width=3;
			localparam Clk_Time=5;
			localparam Time=10;
            reg reset, clk;
            reg write_enable, read_enable;
            reg [Address_Width-1:0] read_addr, write_addr;
            reg [Num_of_bits-1:0] write_data;
            wire [Num_of_bits-1:0] out_1,out_2;
			wire error_signal;

//call module to test it, if I want to test one of them, comment the other one

reg_file_1 #(Num_of_bits, Num_of_registers, Address_Width) register_memory(reset,clk,write_enable,read_enable,read_addr,write_addr,write_data,out_1,error_signal);
reg_file_2 #(Num_of_bits, Num_of_registers, Address_Width) register_For_Loop(reset,clk,write_enable,read_enable,read_addr,write_addr,write_data,out_2,error_signal);

//for each 5 ps, I toggle the clk
always  #Clk_Time clk = ~clk; 

initial begin

////////////////////////////BONUS MONITOR//////////////////////////
$monitor("at time = %3d \nreset = %d\nread_enable = %d read data from address = %d, out_1 = %d out_2 = %d \nwrite_enable = %d write data to address = %d, data = %d \n\n\n",$time,reset,read_enable,read_addr,out_1,out_2,write_enable,write_addr,write_data);
end

 initial begin
 //intialize all inputs with 0
 clk=0;
 reset=0;
 write_enable=0;
 read_enable=0;
 read_addr=0;
 write_addr=0;
 write_data=0;



//test reset, all registers should cary value of 0
    reset=1;

 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);
    reset=0;
	//read values of all register to check them to be all zeros
    read_enable=1;
    read_addr=0;  

 #Time 
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);
    read_addr=1;

 #Time  
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    read_addr=10;

 #Time  
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    read_addr=11;

 #Time 
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    read_addr=100;

 #Time 
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    read_addr=101;

 #Time  
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    read_addr=110;

 #Time   
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    read_addr=111;

 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    //make read enable 0, write enable 1 to test writing
	read_enable=0;
    write_enable=1;
    write_data=16'b0000000010000000;
    write_addr=10;

 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);	
    write_data=16'b0000001111100000;
    write_addr=111; 

 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);
	
    write_enable=0;
    read_enable=1;
	//read data that I write
    read_addr=10;
    
 #Time  
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);
    read_addr=111;
    
    
 #Time 
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);   
   //test reading and writing at the same time for the same location
   //write_data should be ignored, read_data should be 16'bz
	write_enable=1;
    write_data=16'b0000001111100000;
    write_addr=11; 
    read_enable=1;
    read_addr=11;
 #Time 
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);    
	//when I read only, the value will be the old value
	write_enable=0;
	read_enable=1;
    read_addr=11;
 #Time 
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);	
	//test writing at all registers then read them with different order
	read_enable=0;    
    write_enable=1;
    write_data=16'b000000000000001;
    write_addr=0;  
 
 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);
    write_data=16'b001111000000001;
    write_addr=1;  
 
 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    write_data=16'b101100011000101;
    write_addr=10;  
 
 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);
    write_data=16'b000011100000001;
    write_addr=11;  
 
 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    write_data=16'b001010100110000;
    write_addr=100;  
 
 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    write_data=16'b001100011000011;
    write_addr=101;  
 
 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    write_data=16'b000111000011001;
    write_addr=110;  
 
 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    write_data=16'b000000000111111;
    write_addr=111;  
 #Time 
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);	
    write_enable=0;
    read_enable=1;
    read_addr=110;

 #Time 
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    read_addr=0;

 #Time  
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    read_addr=100;

 #Time  
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    read_addr=101;

 #Time 
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    read_addr=1;

 #Time 
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    read_addr=111;

 #Time 
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
    read_addr=10;

 #Time 
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);
    read_addr=11;
 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);	
	//test read from address 3, write at address 7, it should work correctly
	write_enable=1;
    write_data=16'b0000001111100000;
    write_addr=111; 
    read_enable=1;
    read_addr=11;
	
 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2);
    //reset while writing at location 6 and reading from location 6
	reset=1;
	read_enable=1;
    write_enable=1;
    write_data=16'b0000000010000000;
    write_addr=110;   
	read_addr=110;
	
 #Time
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 
	reset=0;	
    write_enable=0;
    read_enable=1;
    read_addr=110;
	
 #Time	
    if(out_1 != out_2)
    $display("failed executed out_1 = %d, out_2 = %d",out_1,out_2);
    else
    $display("Successfully executed out_1 = %d, out_2 = %d",out_1,out_2); 	
	
 #1000 $finish;
end

endmodule

