// module stack_behaviour_lite(
//    output wire[3:0] O_DATA, 
//    input wire RESET, 
//    input wire CLK, 
//    input wire[1:0] COMMAND, 
//    input wire[2:0] INDEX,
//    input wire[3:0] I_DATA
//    );     
//    // put your code here, the other module MUST be deleted
//    // don't edit module interface
//endmodule

module stack_behaviour_normal(IO_DATA, RESET, CLK, COMMAND, INDEX);
    inout wire[3:0] IO_DATA;
    input wire[2:0] INDEX;
    input wire[1:0] COMMAND;
    input wire CLK, RESET;
    reg [3:0] array[4:0];
    integer i;
    reg[3:0] inx, inx2, get, result;
    reg flag;

    always @ (posedge CLK or negedge CLK) begin
        flag = 0;
    end
    
    always @ (posedge RESET) begin
        inx = 0;
        inx2 = 4;
        flag = 0;
        result = 0;
        for (i = 0; i < 5; i+=1) begin
            array[i] = 4'b0000;
        end
    end
    
    always @ (posedge CLK or negedge RESET) begin
        if (CLK == 1 & RESET == 0) begin
            if (COMMAND == 2'b01) begin
                flag = 0;
                for (i = 0; i < 5; i += 1) begin
                    if (inx == i) begin
                        array[i] = IO_DATA;
                    end
                end
                inx2 += 1;
                inx += 1;
                inx %= 5;
                inx2 %= 5;
            end else if (COMMAND == 2'b10) begin
                flag = 1;
                result = array[inx2];
                inx2 = (inx2 + 4) % 5;
                inx = (inx + 4) % 5;
            end else if (COMMAND == 2'b11) begin
                flag = 1;
                get = ((inx2 + 5)  - (INDEX % 5)) % 5;         
                result = array[get];
            end 
        end
    end
    
    assign IO_DATA = (flag) ? result : 4'bZZZZ;
endmodule
