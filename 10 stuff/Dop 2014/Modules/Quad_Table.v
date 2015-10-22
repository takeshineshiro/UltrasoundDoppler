
module Quad_Table(
	input wire[2:0] Theta,
	output signed[7:0] Sine, Cosine);

reg[7:0] LUT_sine [7:0];
reg[7:0] LUT_cosine [7:0];

initial begin : LAOD_INITIALS
	$readmemb("../Settings/MEM_sine.ini", LUT_sine);
	$readmemb("../Settings/MEM_cosine.ini", LUT_cosine);
end

assign Sine = LUT_sine[Theta];
assign Cosine = LUT_cosine[Theta];

endmodule