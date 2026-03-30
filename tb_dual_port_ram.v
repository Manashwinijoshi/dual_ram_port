module tb_dual_port_ram;
  reg clk;
  reg resetn;
  reg [4:0]addr_a;
  reg [4:0]addr_b;
  reg [7:0]data_in_a;
  reg [7:0]data_in_b;
  reg we_a;
  reg we_b;
  wire [7:0]data_out_a;
  wire [7:0]data_out_b;
  
  dual_port_ram #(8,32) ins ( clk , resetn , addr_a, addr_b , data_in_a , data_in_b , we_a , we_b , data_out_a , data_out_b);
  
  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $monitor( $time, "resetn = %b addr_a = %d addr_b = %d data_in_a = %d data_in_b = %d we_a = %b we_b = %b data_out_a = %d data_out_b = %d",
             resetn, addr_a , addr_b , data_in_a , data_in_b , we_a, we_b, data_out_a , data_out_b );
 
    resetn = 0;
    we_a = 0;
    we_b = 0;
    addr_a=0;
    addr_b=0;
    data_in_a=0;
    data_in_b=0;
    #10;
    resetn = 1;
    #10;
     // porta portb

    // write read 
        we_a = 1 ;
        addr_a = 5'd1;
        data_in_a = 8'd1;
        we_b = 0;
        addr_b = 5'd1;     
  #10;   
    // read  write 
        we_a = 0 ;
        addr_a = 5'd1;
        we_b = 1;
        addr_b = 5'd2;   
        data_in_b = 8'd2;
  #10;
   // read read 
        we_a = 0;
        addr_a = 5'd1;
        we_b = 0;
        addr_b = 5'd2;   
  #10;
   // write write 
        we_a = 1 ;
        addr_a = 5'd3;
        data_in_a = 8'd3;
        we_b = 1;
        addr_b = 5'd4;
        data_in_b = 8'd4;
  #10;
    
  #10;

      $finish;
    
  end
  
  initial begin
   $dumpfile("dump.vcd");
   $dumpvars(1, tb_dual_port_ram);
  end
  
  
endmodule 
