function stats = mia_particles_segmentation(I,param)
% mia_particles_segmentation performs segmentation of overlapping elliptic
% al objects in silhouette Images.

%   Synopsis
        %       stats = mia_particles_segmentation(I,param)
%   Description
        %       Segmentation is as follows:
        %       1. Exctract the objects seedpoint (location) by applying BE-FRS 
        %            algorithem in first step.
        %       2. Exctract the object conoturs (visible parts) by assigning
        %           the edge pixles to detected seed point in second step
        %       3. Segment the overllaped nanoparticle by applying 
        %           LSF to the object's contours in thirs step.

%   Inputs 
            %         - I          grayscale image
            %         - param      parameters of the method as follow:
            %         - radii      radial range
            %         - alpha      radial stricness
            %         - stdFactor  gradient threshold
            %         - mode       Euclidean distance between contour center points
            %                      to define neighbouring segments 
            %         - t          number of erosion operations
            %         - se         type of structuring element
            %         - thr        thershold for removing duplicated seedpoints  
            %         -lambda      [0:1], divergence weight factor
            %         - r          radius to defirne circular search region 
            %         - vis1       0 or 1, to visualize the seedpoint extraction 
            %         - vis2       0 or 1, to visualize the contour evidenc extraction
            %         - vis3       0 or 1, to visualize the contour estimation
            %                      

%   Outputs
%                   - stats     cell array contating the objects boundaries 
%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/01/2016  First Edition

    radii = param.radii;
    alpha = param.alpha;
    stdFactor = param.stdFactor;
    mode = param.mode;
    t = param.t;
    se = param.se;
    vis1  = param.vis1;
    thr  = param.thr;
    lambda = param.lambda;
    r = param.r;
    vis2 = param.vis2;
    vis3 = param.vis3;
    % Image Binarization by otsu method
    level = graythresh(I);
    imgbw =  ~im2bw(I,level);
    % Step 1
    fprintf('Performs Seedpoint Extraction .....\n');
    seedpoints = mia_befrs(imgbw,radii, alpha, stdFactor, mode,t,se,thr,vis1);
   % Step 2     
   % Ede-to-seedpoints association
    fprintf('Performs Contour Evidence Extraction.....\n')
    contourevidence= mia_cmprelevence(seedpoints,imgbw,lambda,r,vis2);
    % Step 3
   %  Contour Estimation
    fprintf('Performs Contour Estimation.....\n')
    stats =  mia_estimatecontour_lsf(I,contourevidence,vis3);

end


