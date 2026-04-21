% Author: Simon Dorrer

% Variables
f_clk = 56e6; % Hz
nint = 1;
nfract = 19;
bitwidth = nint + nfract;
iterations = bitwidth + 1;
LSB = 2^-nfract;
f_s = f_clk / iterations; % Hz
f_sine = 125e3; % Hz
f_m = 0;
phi_m = 0;

% CORDIC Settings
mode = 'ROTATION';
coordinate_system = 'CIRCULAR';

quantmode = 'tw';
round_style_vhdl = dictionary(["r" "t"], ["fixed_round", "fixed_truncate"]);
overflow_style_vhdl = dictionary(["w" "s"], ["fixed_wrap", "fixed_saturate"]);
roundmode = round_style_vhdl(quantmode(1));
overflowmode = overflow_style_vhdl(quantmode(2));

[alpha, idx] = getRotationAngles(coordinate_system, iterations);
[~, k] = getCordicScaling(coordinate_system, idx);
f_c = (2 / f_s) * f_sine;

shift_value_bw = ceil(log2(iterations+1));

% Quantization
[f_c_qa, ~] = sfixed_qa(f_c, LSB, 'rs');
alpha_qa = sfixed_qa(alpha, LSB, 'rs');
k = sfixed_qa(k, LSB, 'rs');
xq = sfixed_qa(1, LSB, 'rs');
xq = sfixed_qa(k*xq, LSB, 'rs');
I = sfixed_qa(xq-LSB, LSB, 'rs');
Q = 0;

% Write Sine Values
fprintf('constant I : sfixed(FIXED_WIDTHS.n_int downto FIXED_WIDTHS.n_fract):= "%s";', dec2frac(I, nint, nfract));
fprintf('-- %f \n', I);
fprintf('constant Q : sfixed(FIXED_WIDTHS.n_int downto FIXED_WIDTHS.n_fract):= "%s";', dec2frac(Q, nint, nfract));
fprintf('-- %f \n', Q);
fprintf('constant F_C : sfixed(FIXED_WIDTHS.n_int downto FIXED_WIDTHS.n_fract):= "%s";', dec2frac(f_c_qa, nint, nfract));
fprintf('-- %f (quant.), %f (exact) \n', f_c_qa, f_c);
fprintf('constant F_M : sfixed(FIXED_WIDTHS.n_int downto FIXED_WIDTHS.n_fract):= "%s";', dec2frac(f_m, nint, nfract));
fprintf('-- %f \n', f_m);
fprintf('constant PHI_M : sfixed(FIXED_WIDTHS.n_int downto FIXED_WIDTHS.n_fract):= "%s";', dec2frac(phi_m, nint, nfract));
fprintf('-- %f \n', phi_m);
% =========================================================================

% Write CORDIC Values
fprintf('constant FIXED_WIDTHS : TSFIXED_WIDTH := (n_int => %d, n_fract => %d);\n', nint - 1, -nfract);
fprintf('constant ROUND_MODE : fixed_round_style_type := %s;\n', roundmode);
fprintf('constant OVERFLOW_MODE : fixed_overflow_style_type := %s;\n', overflowmode);

fprintf('constant SHIFT_VALUE_BITWIDTH : natural := %u;\n', shift_value_bw);
fprintf('constant N_CORDIC_ITERATIONS : natural := %u;\n', iterations);
fprintf('constant CORDIC_MODE: TCORDIC_MODE := %s;\n', mode);
fprintf('constant COORDINATE_SYSTEM: TCOORDINATE_SYSTEM := %s;\n', coordinate_system);
% =========================================================================

% For cordic_iterative.v
fprintf("localparam signed [BITWIDTH-1:0] PI_HALF = %u'b%s;", bitwidth, dec2frac(0.5, nint, nfract));
fprintf('\n');
fprintf('localparam [N_CORDIC_ITERATIONS*BITWIDTH-1:0] ATAN_TABLE = {\n');
for i = length(alpha):-1:1
    fprintf("%u'b%s", bitwidth, dec2frac(alpha(i), nint, nfract));
    if i == 1
        fprintf('}; // %f (quant.), %f (exact) \n\n', alpha_qa(i), alpha(i));
    else 
        fprintf(',  // %f (quant.), %f (exact) \n', alpha_qa(i), alpha(i));
    end
end
% =========================================================================