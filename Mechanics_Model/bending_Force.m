function [bending_total] = bending_Force(pos1, pos2, pos3)

x1 = pos1(1);
x2 = pos2(1);
x3 = pos3(1);

y1 = pos1(2);
y2 = pos2(2);
y3 = pos3(2);

k = 0.001; %constant, sets how strong of a bending force we have. Can change

vector1 = [x1-x2, y1-y2];
vector2 = [x3-x2, y3-y2];

magnitudes = norm(vector1)*norm(vector2);
dotproduct = dot(vector1, vector2);

force_X_2 = -k*((2*x2-x1-x3)/magnitudes + ((x3-x2)*dotproduct)/(norm(vector1)*(norm(vector2))^3) + ((x1-x2)*dotproduct)/((norm(vector1))^3*norm(vector2)));

force_Y_2 = -k*((2*y2-y1-y3)/magnitudes + ((y3-y2)*dotproduct)/(norm(vector1)*(norm(vector2))^3) + ((y1-y2)*dotproduct)/((norm(vector1))^3*norm(vector2)));

bending_total_pos2 = [force_X_2, force_Y_2];

%Also need the forces in x1/y1 and x3/y3

force_X_1 = -k*((x3-x2)/(magnitudes)-((x1-x2)*dotproduct)/((norm(vector1))^3*norm(vector2)));
force_Y_1 = -k*((y3-y2)/(magnitudes)-((y1-y2)*dotproduct)/((norm(vector1))^3*norm(vector2)));

bending_total_pos1 = [force_X_1, force_Y_1];



force_X_3 = -k*((x1-x2)/(magnitudes)-((x3-x2)*dotproduct)/(norm(vector1)*(norm(vector2))^3));
force_Y_3 = -k*((y1-y2)/(magnitudes)-((y3-y2)*dotproduct)/(norm(vector1)*(norm(vector2))^3));

bending_total_pos3 = [force_X_3, force_Y_3];

bending_total = [bending_total_pos1;bending_total_pos2;bending_total_pos3];

end