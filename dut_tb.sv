module dut_tb (
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

    int b1[5] = '{1,2,3,4,5};//加单引号固定用法吧，一次性为5个元素赋值
    byte c1[2][3] = '{'{111,23,3},'{3{5}}};//数组赋值一定是'{}
    bit[31:0] d1[5] = '{5{5}};
    /* ********************************************************************以上为定宽数组 */

    bit [3:0] [7:0] e1 ;    //合并数组

    int f1[],f2[];//动态数组

    int q1[$],q2[$];//队列






    initial begin
        automatic bit a1 = 5; //在initial中，需要加static或者automatic
        foreach(b1[i])
            $display("b1[%0d]:%0d",i,b1[i]); //%d是输出和你的系统默认位宽一致的整数，前面补差额的空格数；%0d是根据你的实际整数位宽来输出，前面不补足
        foreach(c1[i,j])//!!!这里需注意，不是c1[i][j],而是c1[i,j]
            $display("c[%0d][%0d]",i,j,c1[i][j]);//遍历数组所有维度
        foreach(c1[i]) begin//遍历第一个维度
            $write("%0d:",i);
            foreach(c1[,j])//遍历第二个维度
                $write("%2d",c1[i][j]);
                $display();
        end 
        $displayb(d1[1],,d1[1][2],,d1[1][2:1]);//两个逗号，出现空格,打印二进制

        f1=new[3];//给动态数组分配3个元素
        f1='{1,2,3};//赋值
        $display("%0d,%0d",f1.size(),$size(f1));//这两个函数返回的值是一样的
        f2=new[10](f1);//给f2分配10个元素，并将f1复制给他
        f1=new[10];//释放原有空间，重新分配大小
        f1.delete();//删除数组
        f2.delete();
        
        q2={11,21,31,41,1,1,1};//队列赋常量，不需要加单引号
        q1= b1;
        q1.insert(0,0);//在第一个元素前插入0
        a1 = q1.pop_front;
        $display(a1,"!!!",q1);

        $display("%2p,%2p",q1.max(),q2.find_first with (item>30) );//数组求最大值
        q2=q2.find_index with (item==1);//返回的下标
        $display(q2);
        q2=q2.find_first with (item>1);
        $display(q2);



    end


        typedef struct {
        bit [7:0] r;
        bit [7:0] g;
        bit [7:0] b;
        } color_s;
        typedef struct {
        bit [7:0] r, g, b;
        } color1_s;

initial begin
        color_s t1 ;//结构体实例化最好单独在一个initial中，或者在initial之外
        color1_s t2;
        bit [7:0] t ,s[4];
        bit [11:0] l[4];
        typedef enum { dw,qwed,dfew } mye;
        mye one;
        real x;
        int a;
        string ss,ss1,ss2;

        ss="zhanglinfeng";
        ss = {ss,"123"};
        t1 ='{8'd1,
            8'd3,
            8'd2};
        s = '{8'h4,8'h5,8'ha,8'hc };
        t2 ='{8'd0,8'd10,8'd100};
        one = dw;
        $display("struct:",t1,,t2);

        $display("2023,7,10");
        x= real'(6-4);//静态转化
        l={<<byte{s}};//动态转化，左值位宽必须不小于右值，默认是位倒序，前面加byte按照字节转为比特流
        a = {>>{s}};
        $displayh("result:%p",l,a );
        $display("enum %s:%2d",one.name(),one);//内建函数访问枚举变量值对应名字
        ss1=$psprintf("%s",ss);//新建一个新的临时字符串
        ss2=$psprintf("%s %s",ss,"321");//新建一个新的临时字符串
        $display("string:%s，%s",ss1,ss2);
        print_time;
end

initial begin:three_chapt //第三章
    bit[127:0] cmd;
    int file,c;
    file = $fopen("F:/vs_code_fpga/git_save/learngit/git_way.txt","r");
    if (file) begin
    while (!$feof(file)) begin
        c = $fscanf(file,"%s",cmd);
        case (cmd)
            " ":continue;
            "--global":break;
            default: $display("%2s",cmd);
        endcase
    end    
    end
    
end
function void print_time;
    $display("@%0t:state=",$time);
endfunction

endmodule