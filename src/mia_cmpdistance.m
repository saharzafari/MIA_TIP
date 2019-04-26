function distance = mia_cmpdistance(xys,xye,mask)

% mia_cmpdistance compute the distance between seedpoints and edge points.

%   Synopsis
        %       distance  = mia_cmpdistance(xys,xye,mask)
%   Description
            %  The distance function g(e k , S j ) is defined as the
            %  distance from the edge point e k to the nearest point of
            %  object seedpoint S (i) , while it is assumed that all the
            %  pixel points on the line connecting the edge point to the
            %  seedpoint l(e k , S j ) reside in the foreground region of
            %  the image silhouette

%   Inputs 
            % - xys     xy coordinates of seedpoint
            % - xye     xy coordinates of edgepoint
            % - mask    binary mask image     

%   Outputs
            % distance        distance value
%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/01/2016  First Edition


    mask = imdilate(mask,strel('square',3));
    distance = sum((xys-xye).^2,2).^ 0.5;% candidate shorter distance
    
    for i=1:size(xys,1)
        [psubx,psuby]=mia_bresenham(xys(i,1),xys(i,2),xye(i,1),xye(i,2));
        pidx = sub2ind(size(mask),[xys(i,2);psuby;xye(i,2)],[xys(i,1);psubx;xye(i,1)]);

        if any(mask(pidx)==0)
            distance(i) = inf;
        end   
    end
    
    if ~all(isinf(distance ))
        distance = distance./max(distance(~isinf(distance)));
    end
end
