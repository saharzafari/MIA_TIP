function e2s = mia_cmprelevence(seedpoints,I,lambda,r,vis)
% mia_cmprelevence performs edge point to seed point association.

%   Synopsis
        %       seedpoints = mia_cmprelevence(seedpoints,I,lambda,r,vis)
%   Description
                % exctract the visible part s of object for each 
                %  detected seedpoints as in the image as follows:
                % method combines the distance and the divergence metrics
                % to assign the edge pixel points to the seedpoints. 
                % Given the set of object seedpoints S = {S (1) , S (2) , ..., S (n) }
                % every edge pixel point e k in E = {e 1 , e 2 , ..., e m } in 
                % search space (r) is linked to the detected object seedpoints 
                % based on the relevance metric (distance and the divergence).

%   Inputs 
       %         - I      grayscale image
       %         -lambda     [0:1], divergence weight factor
       %         - r         radius to defirne circular search region 
       %         - vis       0 or 1, to visualize the contour evidenc extraction
                   

%   Outputs
%                   - e2s     cell array contating the objects boundaries 
%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%   Changes
%       14/01/2016  First Edition

    col_edge= linspecer(length(seedpoints)) ;
    imgsz = size(I);
    [gradmag, ye, xe, dy, dx] = mia_cmpedge(I,0);
    xye = [xe, ye];
    nmepnts = size(xye,1);
    nmspnts = length(seedpoints);
    xys = zeros(nmspnts,2);

    for i=1:nmspnts 
        xys(i,1) = floor(seedpoints(i).xmc);
        xys(i,2) = floor(seedpoints(i).ymc);
    end
    ids = 1:nmspnts;

    % iterate over edgepoints
    ed2sp = zeros(nmepnts,1);
    for i=1:nmepnts
    % %     i
        idx  = sum((xys-repmat(xye(i,:),nmspnts,1)).^2, 2) < r^2; 
        xysr = xys(idx,:);
        idsr = ids(idx);
        nmsrpnts = length(idsr);


       % iterate over seedpoints in search regions
        xyei = repmat(xye(i,:), nmsrpnts, 1);
       % compute distance      
       eg = mia_cmpdistance(xysr, xyei, I);
       % estimate divergenc
       dvg = mia_cmpdivergence(xysr, xyei,dy,dx);
       % compute relevance
       rel1 = 1./(1+eg); 
       rel2 = (dvg+1)/2; rel2(rel1==0) = 0;
       rel = (1-lambda)*rel1 + lambda*rel2;
          if all(rel == 0)
           continue;
          end
       [relmax, idxrm] = max(rel);

       % assign edge xye_i to seedpoint with the highest relevance value
       ed2sp(i) = idsr(idxrm); 
    end

    for k=1: length(seedpoints)
        e2s(k).xe = xe(ed2sp==k);
        e2s(k).ye = ye(ed2sp==k);
        e2s(k).eidx = sub2ind(imgsz,e2s(k).ye,e2s(k).xe);
    end

    if vis == 1
          figure();imshow(gradmag); hold on
          for k=1: length(seedpoints)
            plot(seedpoints(k).xmc,seedpoints(k).ymc,'.','color',col_edge(k,:,:)); hold on
            plot(e2s(k).xe,e2s(k).ye,'.','color',col_edge(k,:,:)); hold on
          end
          title('Contour Evidences')
          fprintf('press any key to strat contour estimation...\n')
          pause;
    end
      
end
