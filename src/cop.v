module co_processor (
    input [7:0] r0, // 8-bit input
    input [1:0] check, // sensor checking
    input reset,
    input clk, // clock input
    output reg Q, // output Q connected to LED
    output reg [1:0] Q1
);



reg [7:0] proc = 8'b0; // processing register
reg [7:0] r1 = 8'b0;
reg [7:0] r2 = 8'b0;
reg [7:0] r3 = 8'b0;
reg [7:0] r4 = 8'b0;
reg [7:0] res = 8'b0;
reg [7:0] data = 8'b0;
reg [1:0] sense = 2'b0;



always @(posedge clk or posedge reset) begin
    if (reset) begin
        r1 <= 8'b0;
        r2 <= 8'b0;
        r3 <= 8'b0;
        r4 <= 8'b0;
        Q <= 1'b0;
		Q1 <= 2'b0;
		data <= 8'b0;
		sense <= 2'b0;
		proc = 8'b0;
    end else begin
    data <= r0;
    sense <= check;

            case (sense)
                2'b00: proc = r1;
                2'b01: proc = r2;
                2'b10: proc = r3;
                2'b11: proc = r4;
            endcase

            if (proc == data) begin
                Q <= 1'b0;
                Q1 <= 2'b00;
            end else begin
                if (proc > data) begin
                    res = proc - data;
                end else begin
                    res = data - proc;
                end

                if (res > 8'b00000010) begin
                
                    if (sense == 2'b00) begin
                        r1 <= data;
                        Q1 <= 2'b00;
                        end
                    if (sense == 2'b01) begin
                        r2 <= data;
                        Q1 <= 2'b01;
                        end
                    if (sense == 2'b10) begin
                        r3 <= data;
                        Q1 <= 2'b10;
                        end
                    if (sense == 2'b11) begin
                        r4 <= data;
                        Q1 <= 2'b11;
                        end
                        
                    Q <= 1'b1;
                end else begin
                    Q <= 1'b0;
                    Q1 <= 2'b00;
                   
                end
            end
        
    end
end

endmodule
