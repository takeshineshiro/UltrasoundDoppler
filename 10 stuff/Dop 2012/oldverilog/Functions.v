macromodule function();
function burst;
		input enablefreq8, enablefreq4, enablefreq2, Freq8, Freq4, Freq2;
		
		burst = (enablefreq8) ? Freq8 : (enablefreq4) ? Freq4 : (enablefreq2) ? Freq2 : 0;
endfunction

endmacromodule