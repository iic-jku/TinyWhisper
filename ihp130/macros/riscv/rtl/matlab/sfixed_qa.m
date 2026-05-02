% SPDX-FileCopyrightText: 2025-2026 The TinyWhisper Team
% SPDX-License-Identifier: Apache-2.0

function [xq, OC] = sfixed_qa(x, LSB, mode)
  % x   : input signal
  % LSB : least significant bit; 2^-fractbits for signed
  % modes: 
  % 'rw'...rounding and two's-complement overflow mode (wrap)
  % 'rs'...rounding and saturation overflow mode
  % 'tw'...truncation and two's-complement overflow mode (wrap)
  % 'ts'...truncation and saturation overflow mode
  % y  : output sequence
  % OC : number of overflows that occurred during filtering
  % xq : quantized signal
  
  OC = 0;

  % rounding / truncating (default)
  if strcmp(mode(1), 't')
    % equivalents for same Bit pattern (e.g. LSB = 0.25 [-4, 3] --> [-1, 0.75])
    % int * LSB = sfixed
    % sfixed / LSB = int
    xq = floor(x/LSB)*LSB;
  else
%     xq = nearest(x/LSB)*LSB;  
    xq = round(x/LSB)*LSB; 
  end

  xq_temp = xq;
  
  % saturation / wrapping (default)        
  if strcmp(mode(2), 's')
    % clip to upper boundary
    xq = min(1 - LSB, xq);
    % clip to lower boundary
    xq = max(-1, xq);
  else
    xq = (xq + 1)/LSB; % has to be an uint number for modulo operation
    maxval = 1/LSB*2; % uint range [0, maxval[
    xq = mod(xq, maxval); % wrap to [0, maxval[  
    xq = xq*LSB; % int to ufixed [0, 2[
    xq = xq - 1; % ufixed to sfixed [-1, 1[
  end

  if (xq ~= xq_temp)
    OC = 1;
  end
end