module top_tb (
);
    
    reg    clk,rst_n,rxd,rx_dv;
    wire   txd,tx_en;

    dut dut_inst(
            .clk(clk),
            .rst_n(rst_n), 
            .rxd(rxd),
            .rx_dv(rx_dv),
            .txd(txd),
            .tx_en(tx_en)
            );



    initial begin

    end

endmodule