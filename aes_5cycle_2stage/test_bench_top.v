/////////////////////////////////////////////////////////////////////
////                                                             ////
////  	 Test Bench for 5 cycles - 2 stage AES128-ENC            ////
////                                                             ////
////                                                             ////
////  Author: Tariq Bashir Ahmad		                 ////
////          tariq.bashir@gmail.com                             ////
////     	                                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2010 	 Tariq Bashir Ahmad 		 ////	
////                         http://www.ecs.umass.edu/~tbashir   ////
////                                                		 ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////


`timescale 1 ns/1 ps

module test;

reg		clk;
reg		rst;
reg      aes_en;
reg		kld;
reg	[127:0]	key; 
reg	[127:0]	text_in;

wire	[127:0]	text_out;
wire		done;



initial
   begin
	
	clk <=  0;
	aes_en =  1;
	repeat(1) @(posedge clk);
	rst =  1;
	repeat(200) @(posedge clk);
	rst =  0;
//	kld = 0;
	repeat(1) @(posedge clk);
	kld 		=  1;                   
	key 		=  128'h0;
	text_in  =  128'h00112233445566778899aabbccddeeff;
	repeat(1) @(posedge clk);            //you need 2 cycles after loading the key and input
	kld  =  0;
	repeat(8) @(posedge clk);
	aes_en =  0;
	end


/*
initial
   begin
	aes_en = 1;
	kld = 0;
	clk = 0;
	rst = 1;
	key = 128'b0;
	text_in  = 128'h00112233445566778899aabbccddeeff;
	repeat(2) @(posedge clk);
	rst = 0;
	end	
*/	
	
	
aes_cipher_top uut(
	.clk(		clk		),
	.rst(		rst		),
	.ld(		kld		),
	.done(		done		),
	.key(		key		),
	.text_in(	text_in		),
	.text_out(	text_out	),
	.aes_en(aes_en)
	);

/*
initial
begin
	#50 kld = 1;
end

initial
	#90 kld = 0;
*/

initial
	forever #10 clk = ~clk;

initial
	#4300 $stop;
	
initial
		$monitor($time," TEXT_OUT is %h, DONE is %b\n",text_out,done);

endmodule


