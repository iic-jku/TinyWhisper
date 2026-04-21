function [klist, k] = getCordicScaling(coordinate_system, shiftseq)
% coordinate_system   ... 'CIRCULAR' or 'LINEAR' or 'HYPERBOLIC'

  if strcmp(coordinate_system, 'CIRCULAR')
    klist = 1./sqrt(1+2.^(-2.*shiftseq));
    
  elseif strcmp(coordinate_system, 'LINEAR')
    klist = ones(size(shiftseq));

  elseif strcmp(coordinate_system, 'HYPERBOLIC')
    klist = 1./sqrt(1-2.^(-2.*shiftseq));
    
  end

  k = prod(klist);
end