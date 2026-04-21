function [alpha, shiftseq] = getRotationAngles(coordinate_system, iterations)
% coordinate_system   ... 'CIRCULAR' or 'LINEAR' or 'HYPERBOLIC'
% alpha ... rotation angles
% shiftseq ... shift values

  if strcmp(coordinate_system, 'CIRCULAR')
    shiftseq = 0:iterations-1;
    alpha = atan(2.^(-shiftseq))/pi;

  elseif strcmp(coordinate_system, 'LINEAR')
    shiftseq = 1:iterations;
    alpha = 2.^(-shiftseq);

  elseif strcmp(coordinate_system, 'HYPERBOLIC')
    shiftseq = 1:iterations;
    k = 4;
    while k < iterations
      shiftseq(k+1) = shiftseq(k); % repeat 3k+1 element
      k = 3*k + 1;  
    end
    alpha = atanh(2.^(-shiftseq));
  end

end