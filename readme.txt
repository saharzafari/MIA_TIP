Microscopy Image Analysis (MIA) toolbox for segmentation of overlapping convex objects in microscopy images.
% Version 1.0 15-Jan-2016
The toolbox contains the following folders:
src:
	%   mia_befrs                    - Find the location of nanoparticles(objects) as seed points (center of symmetry).
	%   mia_cmpseedpoints            - Comput seed points in the image.
	%   mia_cmprelevence             - Associte the edge point to seedpoints.
	%   mia_cmpdistance              - Compute the distance between seedpoints and edge points.
	%   mia_cmpdivergence            - Compute the cosine distance between seedpoints and edge points.
	%   mia_cmpedge                  - Compute the edge coordiante and gradient image.

	% Demos
	%   readparam                   - Read the method parameters.
	%   config                      - Add necessary path.
	%   demo                        - Demonstrate all the method steps in one example image.
	%   mia_particles_segmentation -performs segmentation by using the concave points.
lib: 
	% modified/available matlab codes or toolbox
	%   mia_beresenham               - Creat a line beetween two point based on bresenham algorithm.
	%   mia_cmpparam      		 - Returns the paramters of ellipses fitted to the evidences.
	%   mia_fitellip_lsf     	 - Returns the 6 parameter vector of the algebraic circle fit
	%                        	   to a(1)x^2 + a(2)xy + a(3)y^2 + a(4)x + a(5)y + a(6) = 0.
	%   mia_drawellip_lsf      	 - Draw the ellipse by 100 points.
	%   mia_solveellipse_lsf         - Returns the ellipse parameters [r1 r2 cx cy theta].

img:
      % the input images



% References:
%   [1] Zafari, S.; Eerola, T.; Sampo, J.; Kalviainen, H.; Haario, H.,
%   "Segmentation of Overlapping Elliptical Objects in Silhouette Images," 
%   IEEE Transactions on in Image Processing, vol.24, no.12, pp.5942-5952, Dec. 2015


% Author(s):

%    Sahar Zafari <sahar.zafari@lut.fi>

%  Please, if you find any bugs contact the authors.


