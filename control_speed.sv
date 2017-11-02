module control_speed(clock, dec_speed, inc_speed, defaultSpeed, speed_control, pressed);
	

	input logic clock, dec_speed, inc_speed, defaultSpeed;
	input logic [7:0] pressed;
	output logic [15:0] speed_control;

	always_ff @(posedge clock) begin
		if(defaultSpeed & !inc_speed & !dec_speed)
				speed_control <= 1136;     // no need to adjust speed for def

		else if(inc_speed)
				speed_control <= speed_control + 50;  //addin

		else if (dec_speed)
				speed_control <= speed_control - 50; // deducting 
			
		else if(pressed == 8'h45)
				speed_control <= 1136;
		end 

endmodule