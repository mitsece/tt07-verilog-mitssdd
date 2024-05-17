/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_mitssdd (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out[7:6]=2'b0; // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;
     co_processor co_processor  (
    .clk(clk),
    .reset(rst_n),
	.r0(ui_in),
	.check(uio_in[1:0]),
	     .Q(uo_out[0]),.Q1(uo_out[7:6])
	
);
    fault_pro fault_pro  (
    .clk(clk),
    .reset(rst_n),
	.r0(ui_in),
	.check(uio_in[1:0]),
	.out(uo_out[3:1]),
	.out1(uo_out[5:4])
		
	
);

endmodule
