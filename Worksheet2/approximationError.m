function e = approximationError(pk,pk_check,dt,tend)
%approximationError Compute approximation error
%   Detailed explanation goes here

e = sqrt(dt/tend*sum((pk-pk_check).^2));
end