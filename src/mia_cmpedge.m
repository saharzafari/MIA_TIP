function  [gradmag, y, x, dy, dx] = mia_cmpedge(I,verbose)

    % extract the grardient image
    [gradmag] = edge(I, 'canny');
    
    % thin edge points
    gradmag = bwmorph(gradmag, 'Skel', inf);
    
    [y,x] = find(gradmag);
    
    if ~isa(I,'double') && ~isa(I,'single')
        a = im2single(I);
    end
    
    [dx, dy] = smoothGradient(a,2);
    if verbose
        subplot(1,3,1), imshow(gradmag);
        subplot(1,3,2), imshow(dx);
        subplot(1,3,3), imshow(dy);
    end


end
function [GX, GY] = smoothGradient(I, sigma)

    % Create an even-length 1-D separable Derivative of Gaussian filter

    % Determine filter length
    filterLength = 8*ceil(sigma);
    n = (filterLength - 1)/2;
    x = -n:n;

    % Create 1-D Gaussian Kernel
    c = 1/(sqrt(2*pi)*sigma);
    gaussKernel = c * exp(-(x.^2)/(2*sigma^2));

    % Normalize to ensure kernel sums to one
    gaussKernel = gaussKernel/sum(gaussKernel);

    % Create 1-D Derivative of Gaussian Kernel
    derivGaussKernel = gradient(gaussKernel);

    % Normalize to ensure kernel sums to zero
    negVals = derivGaussKernel < 0;
    posVals = derivGaussKernel > 0;
    derivGaussKernel(posVals) = derivGaussKernel(posVals)/sum(derivGaussKernel(posVals));
    derivGaussKernel(negVals) = derivGaussKernel(negVals)/abs(sum(derivGaussKernel(negVals)));

    % Compute smoothed numerical gradient of image I along x (horizontal)
    % direction. GX corresponds to dG/dx, where G is the Gaussian Smoothed
    % version of image I.
    GX = imfilter(I, gaussKernel', 'conv', 'replicate');
    GX = imfilter(GX, derivGaussKernel, 'conv', 'replicate');

    % Compute smoothed numerical gradient of image I along y (vertical)
    % direction. GY corresponds to dG/dy, where G is the Gaussian Smoothed
    % version of image I.
    GY = imfilter(I, gaussKernel, 'conv', 'replicate');
    GY  = imfilter(GY, derivGaussKernel', 'conv', 'replicate');
end
