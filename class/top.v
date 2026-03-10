module top(
    input [15:0]sw,
    input btnL, btnU, btnD, btnR, btnC,
    output [15:0]led
);

    wire [1:0] muxSelect;
    wire [1:0] demuxSelect;
    wire [3:0] sharedLine;
    
    assign muxSelect = {btnU, btnL};
    assign demuxSelect = {btnR, btnD};
    
    assign sharedLine = btnC ? (
    (muxSelect == 2'b00) ? sw[3:0] :
    (muxSelect == 2'b01) ? sw[7:4] :
    (muxSelect == 2'b10) ? sw[11:8] :
    sw[15:12]
    ) : 4'b0000;
    
    assign led[3:0] = (btnC && demuxSelect == 2'b00) ? sharedLine : 4'b0000;
    assign led[7:4] = (btnC && demuxSelect == 2'b01) ? sharedLine : 4'b0000;
    assign led[11:8] = (btnC && demuxSelect == 2'b10) ? sharedLine : 4'b0000;
    assign led[15:12] = (btnC && demuxSelect == 2'b11) ? sharedLine : 4'b0000;

endmodule