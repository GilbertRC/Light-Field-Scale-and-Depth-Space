clear all;
LFDir = [fileparts(mfilename('fullpath')) '/'];

%% Parameters
LFName = 'buddha';
uRange = [1:9];		% list of u indices of the images to load from the files.
vRange = [1:9];		% list of v indices of the images to load from the files.
crop = [0 0 0 0];		% croped pixels form the input images [left,right,top,bottom].
nU = length(uRange);
nV = length(vRange);
nOctave = 3; % number of octave
nLayer = 4; % layer number of an octave
nScale = nOctave*nLayer;
nAngle = 64;
scale_0 = 1.6;
extreme_point = [];
count_ext = 0;

%% Load Light Field data
tic;fprintf('Load 4D Light Field...');
LF = loadLF([LFDir LFName], '', 'bmp', uRange, vRange, crop);
t=toc;fprintf(['\b\b\b (done in ' num2str(t) 's)\n']);

nY = size(LF, 1);
nX = size(LF, 2);
nC = size(LF, 3);

vC = ceil((nV+1)/2);
uC = ceil((nU+1)/2);
im_ref = LF(:,:,:,vC,uC);
imshow(im_ref);

%% Construct Lisad-1/2 and find extreme points(light field scale and depth space-diff1/2)
for epi_h = 1:nY
    fprintf(['Processing %d/',num2str(nY),'\n'],epi_h);
    
    %% Step1: Extract epipolar plane image (EPI) in center view row (v=vC)
    epi_horizontal = zeros(nU,nX,nC,'uint8');
    for u = 1 : nU
        epi_horizontal(u,:,:) = LF(epi_h,:,:,vC,u);
    end
    epi_horizontal = im2double(rgb2gray(epi_horizontal));
    
    %% Step2: Lisad-1 space for 3D keypoints detection (ray edge detection),
    % and Lisad-2 space for depth estimation (ray detection/blob detection)
    L1 = construct_Lisad_1_space(epi_horizontal, nOctave, nLayer, scale_0, nAngle);
    
    %% Step3: Find extreme points in Lisad-1 space
    [L1_1,L1_2,L1_3] = gradient(L1);
    [L1_11,L1_12,L1_13] = gradient(L1_1);
    [~,L1_22,L1_23] = gradient(L1_2);
    [~,~,L1_33] = gradient(L1_3);
    
    score = L1_11.*L1_22.*L1_33 + L1_12.*L1_23.*L1_13 + L1_13.*L1_12.*L1_23 - L1_13.*L1_22.*L1_13 - L1_12.*L1_12.*L1_33 - L1_11.*L1_23.*L1_23;
    points = (islocalmax(score,1) .* islocalmax(score,2) .* islocalmax(score,3)) + ...
        (islocalmin(score,1) .* islocalmin(score,2) .* islocalmin(score,3));
    points = points .* (abs(score) > 0.6*max(max(max(abs(score)))));
    index = find(points);
    if size(index,1)>0
        count_ext = count_ext + size(index,1);
        [x_ext,s_ext,a_ext] = ind2sub(size(L1),index);
        y_ext = repmat(epi_h,size(index,1),1);
        extreme_point(count_ext-size(index,1)+1:count_ext,:) = [x_ext,y_ext,s_ext,a_ext];
    end
    
end

%% Plot the 3D keypoints
for i = 1:count_ext
    angle = -pi/3+(extreme_point(i,4)-1)*pi*2/(3*(nAngle-1));
    color = (angle+pi/3)/(2*pi/3);
    color = im2double(label2rgb(im2uint8(color),jet(255)));
    hold on;
    plot(extreme_point(i,1),extreme_point(i,2),'x','color',[color(:,:,1) color(:,:,2) color(:,:,3)]);
end


function m = islocalmax(x,dim)
m  = (circshift(x,1,dim) < x) & (circshift(x,-1,dim) < x) ; % find the local maximum
end

function m = islocalmin(x,dim)
m = (circshift(x,1,dim) > x) & (circshift(x,-1,dim) > x) ;  % find the local minimum
end