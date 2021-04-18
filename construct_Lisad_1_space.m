% Copyright (c) 2021-  Yilei Chen
% For research purpose only. Cannot be used for any other purpose without permission from the author(s).

% Inputs:
% -epi_horizontal : Input EPI.
% -nOctave : Number of octaves.
% -nLayer : Number of layers in each octave
% -scale_0 : Initial scale value (1.6 by default).
% -nAngle : Number of angles.

% Outputs:
% -L_1 : The Lisad-1 space.
function L_1 = construct_Lisad_1_space(epi_horizontal, nOctave, nLayer, scale_0, nAngle)
nScale = nOctave*nLayer;
nX = size(epi_horizontal,2);
nU = size(epi_horizontal,1);
uC = ceil((nU+1)/2);
L_1 = zeros(nX,nScale,nAngle,'double');
for scale_idx = 1:nScale
    for alpha_idx = 1:nAngle
        % construct ray-gaussian kernal using current scale and alpha
        octave_idx = ceil(scale_idx / nLayer);
        if mod(scale_idx,nLayer)==0
            layer_idx = nLayer;
        else
            layer_idx = mod(scale_idx,nLayer);
        end
        scale_layer = 2^((layer_idx-1)/nLayer)*scale_0; % log2
        scale = 2^(octave_idx-1)*scale_layer;
        alpha = -pi/3+(alpha_idx-1)*pi*2/(3*(nAngle-1));
        ray_gaussian_kernal = get_ray_gaussian_kernal(nU, nX, scale, alpha);
        
        % construct Lisad-1 space
        ray_gaussian_kernal_diff1 = scale * imfilter(ray_gaussian_kernal,[-0.5,0,0.5],'symmetric');
        cur_L_1 = imfilter(epi_horizontal,ray_gaussian_kernal_diff1,'symmetric');
        L_1(:,scale_idx,alpha_idx) = cur_L_1(uC,:);
        
    end
end
