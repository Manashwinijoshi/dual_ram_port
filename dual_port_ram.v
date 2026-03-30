/*
   a dual port ram with  same clock
   we_x = 1 for write 
   we_x = 0 for read
   initial block that initializes the mem is for simulation purpose only 
   this is synchrnous read hence 
   the addr is registered at posedge and the output is at the next clock 
  if you use assign then the output follows the address immediately — no clock needed, purely combinational.
*/
module dual_port_ram #(parameter WIDTH=8 , DEPTH = 32)
(
     input clk,
  	 input resetn,
  input [$clog2(DEPTH)-1: 0]addr_a,
  input [$clog2(DEPTH)-1: 0]addr_b,
  input [WIDTH-1: 0]data_in_a,
  input [WIDTH-1: 0]data_in_b,
  input  we_a,
  input  we_b,
  output reg [WIDTH-1: 0]data_out_a,
  output reg [WIDTH-1: 0]data_out_b
  
);

  reg [WIDTH-1:0]mem[0:DEPTH-1];

integer i;
initial begin
  for (i = 0; i < DEPTH; i = i + 1)
    mem[i] = 0;
end
  always@(posedge clk)
    begin
      if(!resetn)
        begin
            data_out_a<=0;
        end
      else 
        begin
          if(we_a)
            mem[addr_a] <= data_in_a;
          else
            data_out_a<= mem[addr_a];
          
        end
      
    end
  
  
  always@(posedge clk)
    begin
      if(!resetn)
        begin
            data_out_b<=0;
        end
      else 
        begin
          if(we_b)
            mem[addr_b] <= data_in_b;
          else
            data_out_b<= mem[addr_b];
          
        end
      
    end

endmodule
