function dvg = mia_cmpdivergence(xys,xye,dy,dx)
% mia_cmpdivergence compute the cosine distance between seedpoints and edge points.

%   Synopsis
        %       dvg = mia_cmpdivergence(xys,xye,dy,dx)
%   Description
            % The divergence function div(e-k , S-j ) measures the dif
            % ference between the direction of the line connecting the
            % edge point e k to seedpoint S j and the gradient direction
            % at point e-k

%   Inputs 
            % - xys   xy coordinates of seedpoint
            % - xye   xy coordinates of edgepoint
            % - dy,dx gradient image in y and x
                   

%   Outputs
            % -dvg  diverngence value.
%         
%   Authors
%          Sahar Zafari <sahar.zafari(at)lut(dot)fi>
%
%   Changes
%       14/01/2016  First Edition

    grad = [dx(xye(1,2),xye(1,1)), dy(xye(1,2),xye(1,1))];
    dvg  = abs(sum(repmat(grad, size(xys,1), 1).*normr(xye-xys), 2) / norm(grad));
end
