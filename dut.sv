//该代码功能为：通过rxd接收数据，再将数据通过txd发送出去，tx_en为数据有效指示
module dut(clk,
           rst_n, 
           rxd,
           rx_dv,
           txd,
           tx_en);
input clk;
input rst_n;
input[7:0] rxd;
input rx_dv;
output [7:0] txd;
output tx_en;

reg[7:0] txd;
reg tx_en;

always @(posedge clk) begin
   if(!rst_n) begin
      txd <= 8'b0;
      tx_en <= 1'b0;
   end
   else begin
      txd <= rxd;
      tx_en <= rx_dv;
   end
end
endmodule
