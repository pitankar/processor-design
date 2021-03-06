/* Copyright © 2018 Piyush Itankar <pitankar@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the “Software”), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
 * OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/*
 * Module Name:     Instruction Memory.
 * Functional Req:  Takes in an address and outputs the WORD at the location.
 * Input:           addr.
 *                  addr: Address of which the WORD needs to be fetched.
 * Output:          instruction.
 *                  instruction: WORD at the given address
 * Parameters:      ADDRESS_BITS, MEMORY_DEPTH, WORD_SIZE.
 *                  ADDRESS_BITS: width of input address.
 *                  MEMORY_DEPTH: Depth of Instruction memory in terms of num of
 *                                instructions.
 *                  WORD_SIZE:    Size of the Instruction word.
 */
module instruction_memory #(parameter ADDRESS_BITS=32, MEMORY_DEPTH=1024, WORD_SIZE=32)
                           (input  [ADDRESS_BITS-1:0] addr,
                            output [WORD_SIZE-1:0]    instruction);

    // Create the memory
    reg [WORD_SIZE-1:0] instruction_memory [0:MEMORY_DEPTH-1];
    reg [WORD_SIZE-1:0] inst;

    always @(addr)
        inst <= instruction_memory[addr];

    assign instruction = inst;

    // TODO: These register value assignment should be removed after
    // a way to program the instruction memory has been provided
    initial instruction_memory[0] = 32'b000_00000_00001_00010_00000_000000000;
    initial instruction_memory[1] = 32'b001_00000_00001_00011_00000_000000000;
    initial instruction_memory[2] = 32'b011_00000_00001_00100_00000_000000000;
    initial instruction_memory[3] = 32'b010_00000_00001_00101_00000_000000000;
    initial instruction_memory[4] = 32'b101_00110_00000_00000_00000_000000000;
    initial instruction_memory[5] = 32'b111_00111_00000_00000_00000_000000000;
    initial instruction_memory[6] = 32'b110_00110_00111_00000_00000_000000001;
    initial instruction_memory[8] = 32'b100_11111_11111_11111_11111_111111001;
endmodule


/*
 * Module Name:     Register Bank.
 * Functional Req:  Takes in 3 Register addresses, output the content of later two,
 *                  selects the first one for saving the incoming data value if 'wr'
 *                  is enabled.
 * Input:           ra, rb, rc, wr, d_in.
 *                  ra:   Register number to be selected for input.
 *                  rb:   Register number to be selected for output 1.
 *                  rc:   Register number to be selected for output 2.
 *                  wr:   Write enable for the register.
 *                  d_in: Data to be saved in the register.
 * Output:          da_o, db_o.
 *                  da_o: Value stored at register rb
 *                  db_o: Value stored at register rc
 * Parameters:      REGISTER_COUNT, REGISTER_WIDTH, ADDRESS_BITS.
 *                  REGISTER_COUNT: Number of Register in File.
 *                  REGISTER_WIDTH: Width of each register.
 *                  ADDRESS_BITS:   Number of bits to address all the registers.
 */
module register_bank #(parameter REGISTER_COUNT=32, REGISTER_WIDTH=32, ADDRESS_BITS=5)
                      (input [ADDRESS_BITS-1:0]     ra, rb, rc,
                       input                        wr,
                       input  [REGISTER_WIDTH-1:0]  d_in,
                       output [REGISTER_WIDTH-1:0]  da_o, db_o);

    // Create a Register Bank
    reg [REGISTER_WIDTH-1:0] reg_file [0:REGISTER_COUNT-1];

    // Last register is always Zero!
    initial reg_file[REGISTER_COUNT-1] = 1'd0;

    assign da_o = reg_file[ra];
    assign db_o = reg_file[rb];

    always @(wr or d_in) begin
        // Load in the appropriate register when wr is true
        if (wr)
            reg_file[rc] <= d_in;
    end

    // Dummy values for testing
    initial reg_file[0]  = 8'h00_00_00_02;
    initial reg_file[1]  = 8'h00_00_00_05;
    initial reg_file[2]  = 8'h00_00_00_00;
    initial reg_file[3]  = 8'h00_00_00_00;
    initial reg_file[4]  = 8'h00_00_00_00;
    initial reg_file[5]  = 8'h00_00_00_00;
    initial reg_file[6]  = 8'h00_00_00_ff;
    initial reg_file[7]  = 8'h00_00_00_00;
    initial reg_file[8]  = 8'h00_00_00_00;
    initial reg_file[9]  = 8'h00_00_00_00;
    initial reg_file[10] = 8'h00_00_00_00;
    initial reg_file[11] = 8'h00_00_00_00;
    initial reg_file[12] = 8'h00_00_00_00;
    initial reg_file[13] = 8'h00_00_00_00;
    initial reg_file[14] = 8'h00_00_00_00;
    initial reg_file[15] = 8'h00_00_00_00;
    initial reg_file[16] = 8'h00_00_00_00;
    initial reg_file[17] = 8'h00_00_00_00;
    initial reg_file[18] = 8'h00_00_00_00;
    initial reg_file[19] = 8'h00_00_00_00;
    initial reg_file[20] = 8'h00_00_00_00;
    initial reg_file[21] = 8'h00_00_00_00;
    initial reg_file[22] = 8'h00_00_00_00;
    initial reg_file[23] = 8'h00_00_00_00;
    initial reg_file[24] = 8'h00_00_00_00;
    initial reg_file[25] = 8'h00_00_00_00;
    initial reg_file[26] = 8'h00_00_00_00;
    initial reg_file[27] = 8'h00_00_00_00;
    initial reg_file[28] = 8'h00_00_00_00;
    initial reg_file[29] = 8'h00_00_00_00;
    initial reg_file[30] = 8'h00_00_00_00;
    initial reg_file[31] = 8'h00_00_00_00;
endmodule

/*
 * Module Name:     Data Memory.
 * Functional Req:  Takes in an address and outputs the WORD at the location.
 *                  If write is enabled, then writes a WORD at given location
 * Input:           addr, d_in, wr.
 *                  addr: Address of which the WORD needs to be fetched/written.
 *                  d_in: Data to be written.
 *                  wr:   Write enable.
 * Output:          d_out.
 *                  d_out: WORD at the given address
 * Parameters:      ADDRESS_BITS, MEMORY_DEPTH, WORD_SIZE.
 *                  ADDRESS_BITS: width of input address.
 *                  MEMORY_DEPTH: Depth of Instruction memory in terms of num of
 *                                instructions.
 *                  WORD_SIZE:    Size of the Instruction word.
 */
module data_memory #(parameter ADDRESS_BITS=32, MEMORY_DEPTH=64, WORD_SIZE=32)
                    (input  [ADDRESS_BITS-1:0] addr,
                     input  [WORD_SIZE-1:0]    d_in,
                     input                     wr,
                     output [WORD_SIZE-1:0]    d_out);

    // Create the memory
    reg [WORD_SIZE-1:0] data_memory [0:MEMORY_DEPTH-1];
    reg [WORD_SIZE-1:0] data_out;

    always @(addr or wr) begin
        if (wr) data_memory[addr] <= d_in;
        else data_out <= data_memory[addr];
    end

    assign d_out = data_out;
endmodule
