vlog encoder.v
vsim encoder
add wave -position end  sim:/encoder/enable
add wave -position end  sim:/encoder/in
add wave -position end  sim:/encoder/out
add wave -position end  sim:/encoder/validOut

############################ bonus solution ############################
#set enable = 1
force -freeze sim:/encoder/enable 1 0
#loop for each element in the main values set
for { set a 0 }  {$a < 256} {incr a} {
#transform the number to binary format.
binary scan [binary format c $a] B8 a_bin
force -freeze sim:/encoder/in $a_bin 0
run
}
#set enable = 0
force -freeze sim:/encoder/enable 0 0
#loop for each element in the main values set
for { set a 0 }  {$a < 256} {incr a} {
#transform the number to binary format.
binary scan [binary format c $a] B8 a_bin
force -freeze sim:/encoder/in $a_bin 0
run
}

############################ normal solution ############################

#set enable = 1
force -freeze sim:/encoder/enable 1 0

#put input with the 8 valid input.
force -freeze sim:/encoder/in 00000001 0
run

force -freeze sim:/encoder/in 00000010 0
run

force -freeze sim:/encoder/in 00000100 0
run

force -freeze sim:/encoder/in 00001000 0
run

force -freeze sim:/encoder/in 00010000 0
run

force -freeze sim:/encoder/in 00100000 0
run

force -freeze sim:/encoder/in 01000000 0
run

force -freeze sim:/encoder/in 10000000 0
run

#set enable = 0.
force -freeze sim:/encoder/enable 0 0

#try some cases with enable = 0.
force -freeze sim:/encoder/in 00000000 0
run

force -freeze sim:/encoder/in 00000001 0
run

force -freeze sim:/encoder/in 00000010 0
run

force -freeze sim:/encoder/in 00000011 0
run

#set enable = 1.
force -freeze sim:/encoder/enable 1 0

#try some cases with invalid input.
force -freeze sim:/encoder/in 00001001 0
run

force -freeze sim:/encoder/in 00001010 0
run

force -freeze sim:/encoder/in 00001011 0
run

force -freeze sim:/encoder/in 00001100 0
run