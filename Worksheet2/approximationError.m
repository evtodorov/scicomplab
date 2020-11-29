function e = approximationError(pk,pk_check,dt,end)
%approximationError Compute approximation error
%   Detailed explanation goes here

e = sqrt(dt/tend*sum((pk-pk_check).^2));
end