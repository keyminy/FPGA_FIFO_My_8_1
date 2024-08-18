`timescale 1ns / 1ps

module tb_fifo();
        reg       clk;
        reg       reset;
        reg       wr;
        reg       rd;
        reg       [7 : 0] wr_data;
        wire      [7 : 0] rd_data;
        wire      full;
        wire      empty;
FIFO #(
    .ADDR_WIDTH(2), // address 4개,data를 4개만 보겠다
    // addr_width 10개하면 1024개 주소가 생김
    .DATA_WIDTH(8) // data길이
) dut_fifo (
        .clk(clk),
        .reset(reset),
        .wr(wr),
        .rd(rd),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .full(full),
        .empty(empty)
    );

    always #5 clk = ~clk;

    initial begin
        #00 clk = 0; reset = 1'b1; wr = 1'b0; rd = 1'b0; wr_data = 8'b0; // 전원이 딱 들어간 초기값
        #10 reset = 1'b0;
        #10 wr_data = 8'h01; wr = 1'b1; // 쓰기
        @(posedge clk); // wait 1 clk
        #10 wr_data = 8'h02; wr = 1'b1; // 쓰기
        @(posedge clk); // wait 1 clk
        #10 wr_data = 8'h03; wr = 1'b1; // 쓰기
        @(posedge clk); // wait 1 clk
        #10 wr_data = 8'h04; wr = 1'b1; // 쓰기
        @(posedge clk); // wait 1 clk
        #10 wr_data = 8'h05; wr = 1'b1; // full이 나야함
        @(posedge clk); // wait 1 clk

        #10 rd = 1'b1; wr=1'b0; // 읽기
        @(posedge clk); // wait 1 clk
        #10 rd = 1'b1; wr=1'b0;// 읽기
        @(posedge clk); // wait 1 clk
        #10 rd = 1'b1; wr=1'b0;// 읽기
        @(posedge clk); // wait 1 clk
        #10 rd = 1'b1; wr=1'b0;// 읽기
        @(posedge clk); // wait 1 clk
        #10 rd = 1'b1; wr=1'b0;// 읽기
        @(posedge clk); // wait 1 clk
        #10 rd = 1'b1; wr=1'b0;// 읽기
        @(posedge clk); // wait 1 clk
        #10 $finish;
    end
endmodule
