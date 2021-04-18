% Copyright (c) 2021-  Yilei Chen
% For research purpose only. Cannot be used for any other purpose without permission from the author(s).

% Inputs:
% -nU : Resolution of u dimension.
% -nX : Resolution of x dimension.
% -sigma : The width (standard deviation) of kernal.
% -alpha : The angle of EPI line.

% Outputs:
% -ray_gaussian_kernal : The Ray-Gaussian kernal.
function ray_gaussian_kernal = get_ray_gaussian_kernal(nU, nX, sigma, alpha)

ray_gaussian_kernal = zeros(nU,nX);
uC = ceil((nU+1)/2);
xC = ceil((nX+1)/2);

for u = 1 : nU
    for x = 1 : nX
        ray_gaussian_kernal(u,x) = exp(-((x-xC)+(u-uC)*tan(alpha))^2/(2*sigma^2))/(sigma*sqrt(2*pi));
%        ray_gaussian_kernal(u,x) = exp(-((nX/2+1-x)+(u-1)*tan(alpha))^2/(2*sigma^2))/(sigma*sqrt(2*pi));
    end
end
% ray_gaussian_kernal = mat2gray(ray_gaussian_kernal);

% extract the scope (mean-3*sigma, mean+3*sigma)
idx1 = round(xC + (1-uC)*tan(alpha));
idx2 = round(xC + (nU-uC)*tan(alpha));
idx_min = min(idx1, idx2);
idx_max = max(idx1, idx2);
ray_gaussian_kernal = ray_gaussian_kernal(:,floor(idx_min - 3*sigma):ceil(idx_max + 3*sigma));
