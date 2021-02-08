module top;

    reg [511:0]Mem[8*1024 -1:0];
    reg [15:0][31:0]CacheMem[1023:0];
    reg [2:0]CacheTag[1023:0];
    reg [1:0]CacheFlags[1023:0];   // 1 --> valid, 0 --> dirty

    reg [16:0]MemoryAddr;
    reg Mode;                  // 1 --> Read; 0--> Write
    reg [31:0]Data;

    reg [9:0]LineNumber;
    integer i = 1;             //For Clk

    reg clk;


    //Basic Cache functions
    always @(posedge clk) 
    begin

        LineNumber = MemoryAddr[13:4];


        //Replace previous data in memory if it was dirtied
        if(CacheFlags[LineNumber]==2'b11 && CacheTag[LineNumber]!=MemoryAddr[16:14])
        begin
            $display("Dirty Memory Updated");
            Mem[{CacheTag[LineNumber],LineNumber}] = CacheMem[LineNumber];
            CacheFlags[LineNumber] = 2'b10;
        end

        //Case for Read from memory
        if(Mode == 1'b1)
        begin

            //If the data is not present in Cache load it from memory
            if(CacheTag[LineNumber]!=MemoryAddr[16:14] || CacheFlags[LineNumber][1] == 1'b0)
            begin
                $display("Cache Miss (Read) occured");
                CacheMem[LineNumber] = Mem[MemoryAddr[16:4]];
                CacheFlags[LineNumber] = 2'b10;
                CacheTag[LineNumber] = MemoryAddr[16:14];
            end      

            Data = CacheMem[LineNumber][MemoryAddr[3:0]];
        end

        //Case for write
        else if(Mode == 1'b0)
        begin

            //If the data is not present in Cache load it from memory
            if(CacheTag[LineNumber]!=MemoryAddr[16:14] || CacheFlags[LineNumber][1] == 1'b0)
            begin
                $display("Cache Miss (Write) occured");
                CacheMem[LineNumber] = Mem[MemoryAddr[16:4]];  
                CacheFlags[LineNumber] = 2'b11;    
                CacheTag[LineNumber] = MemoryAddr[16:14];
            end

            CacheMem[LineNumber][MemoryAddr[3:0]] = Data;
            CacheFlags[LineNumber] = 2'b11;    
        end
    end

    //Intiialize the Memory,Cache Tags at Program start
    initial 
    begin
        for(i=0;i<1024*8;i=i+1)
            Mem[i] = i;

        for(i=0;i<1024;i=i+1)
            CacheFlags[i] = 2'b0;  
    end

    initial 
    begin
        #0 clk <= 1;
        for(i=0;i<17;i=i+1)
        begin
            #5 clk <= ~clk;
        end
    end

    initial 
    begin
        //read initial data
        #0 Mode = 1'b1; MemoryAddr = 17'd128;
        #10 Mode = 1'b0; MemoryAddr = 17'd128; Data = 32'd129;
        #10 Mode = 1'b1; MemoryAddr = 17'd128;
        #10 Mode = 1'b1; MemoryAddr = 17'd0;
        #10 Mode = 1'b1; MemoryAddr = 17'd128;
        #10 Mode = 1'b0; MemoryAddr = 17'd0; Data = 32'd420;
        #10 Mode = 1'b1; MemoryAddr = 17'd0;
        #10 Mode = 1'b1; MemoryAddr = 17'd9;
        #10 Mode = 1'b0; MemoryAddr = 17'd16384; Data = 32'd20;
    end

    initial
    begin
        $monitor($time," Clk=%b, Mode=%b , MemoryAdress=%d ,Data=%d, Line number=%d",clk,Mode,MemoryAddr,Data,MemoryAddr[13:4]);
    end

endmodule
