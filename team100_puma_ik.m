function thetas = team100_puma_ik(x, y, z, phi, theta, psi)
%% team100_puma_ik.m
%
% Calculates the full inverse kinematics for the PUMA 260.
%
% This Matlab file provides the starter code for the PUMA 260 inverse
% kinematics function of project 1 in MEAM 520 at the University of
% Pennsylvania.  The original was written by Professor Katherine J.
% Kuchenbecker. Students will work in teams modify this code to create
% their own script. Post questions on the class's Piazza forum.
%
% The first three input arguments (x, y, z) are the desired
% coordinates of the PUMA's end-effector tip in inches, specified in
% the base frame.  The origin of the base frame is where the first
% joint axis (waist) intersects the table. The z0 axis points up, and
% the x0 axis points out away from the robot, perpendicular to the
% front edge of the table.  These arguments are mandatory.
%
%     x: x-coordinate of the origin of frame 6 in frame 0, in inches
%     y: y-coordinate of the origin of frame 6 in frame 0, in inches
%     z: z-coordinate of the origin of frame 6 in frame 0, in inches
%
% The fourth through sixth input arguments (phi, theta, psi) represent
% the desired orientation of the PUMA's end-effector in the base frame
% using ZYZ Euler angles in radians.  These arguments are mandatory.
%
%     phi: first ZYZ Euler angle (Z) for orientation of frame 6 in frame 0, in radians
%     theta: second ZYZ Euler angle (Y) for orientation of frame 6 in frame 0, in radians
%     psi: third ZYZ Euler angle (Z) for orientation of frame 6 in frame 0, in radians
%
% The output (thetas) is a matrix that contains the joint angles
% needed to place the PUMA's end-effector at the desired position and
% in the desired orientation. The first row is theta1, the second row
% is theta2, etc., so it has six rows.  The number of columns is the
% number of inverse kinematics solutions that were found; each column
% should contain a set of joint angles that place the robot's
% end-effector in the desired pose. These joint angles are specified
% in radians according to the order, zeroing, and sign conventions
% described in the documentation.
%
% This function calculates the joint angles that would be necessary to
% place the PUMA in the desired configuration.  Importantly, it does
% not check whether the required joint angles are within the joint
% limits for the PUMA; that checking needs to be done elsewhere.
% Similarly, this function does not count angles that differ by 2*pi
% to be different; only one such solution is returned because
% otherwise there would be infinitely many solutions.  If this
% function cannot find a solution to the inverse kinematics problem,
% it will pass back NaN (not a number) for all of the thetas.
%
% Please change the name of this file and the function declaration on
% the first line above to include your team number rather than 100.


%% CHECK INPUTS

% Look at the number of arguments the user has passed in to make sure
% this function is being called correctly.
if (nargin < 6)
    error('Not enough input arguments.  You need six.')
end


%% CALCULATE INVERSE KINEMATICS SOLUTION(S)

% For now, just set the first solution to NaN (not a number) and the
% second to zero radians.  You will need to update this code.
%
% NaN is what you should output if there is no solution to the inverse
% kinematics problem for the position and orientation that were passed
% in. For example, this would be the correct output if the desired
% position for the end-effector was outside the robot's reachable
% workspace.  We use this sentinel value of NaN to be sure that the
% code calling this function can tell that something is wrong and shut
% down the PUMA.

Rz = @(x) [cos(x) -sin(x) 0; sin(x) cos(x) 0; 0 0 1];
Ry = @(x) [cos(x) 0 sin(x); 0 1 0; -sin(x) 0 cos(x)];
R06 = Rz(psi)*Ry(theta)*Rz(phi);


d6 = 2.5;

xc = x - d6*R06(1,3);
yc = y - d6*R06(2,3);
zc = z - d6*R06(3,3);


th1 = [NaN 0];
th2 = [NaN 0];
th3 = [NaN 0];
th4 = [NaN 0];
th5 = [NaN 0];
th6 = [NaN 0];

% You should update this section of the code with your IK solution.
% Please comment your code to explain what you are doing at each step.
% Feel free to create additional functions as needed - please name
% them all to start with team1XX_, where 1XX is your team number.  For
% example, it probably makes sense to handle inverse position
% kinematics and inverse orientation kinematics separately.


%% FORMAT OUTPUT

% Stack all of the thetas on top of one another to return.
thetas = [th1; th2; th3; th4; th5; th6];

% By the very end, each column of thetas should hold a set of joint
% angles in radians that will put the PUMA's end-effector in the
% desired configuration.  If the desired configuration is not
% reachable, set all of the joint angles to NaN.