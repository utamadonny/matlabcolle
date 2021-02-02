syms phi theta psi;

lpsi = [cos(psi) sin(psi) 0; -sin(psi) cos(psi) 0; 0 0 1]; %Yaw
ltheta =[cos(theta) 0 -sin(theta); 0 1 0; sin(theta) 0 cos(theta)]; %Pitch
lphi= [1 0 0; 0 cos(phi) sin(phi); 0 -sin(phi) cos(phi)]; %Roll

a=lphi*ltheta*lpsi; %Earth to Body
b=lpsi.'*ltheta.'*lphi.'; %Body to Earth (do transpose of a)