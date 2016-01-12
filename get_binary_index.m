function [ Binary_Index ] = get_binary_index( grid1,grid2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

MAT = [1,2,1;1,3,2;1,4,3;1,5,4;1,6,5;1,7,6;1,8,7;1,9,8;2,3,9;2,4,10;2,5,11;2,6,12;2,7,13;2,8,14;2,9,15;3,4,16;3,5,17;3,6,18;3,7,19;3,8,20;3,9,21;4,5,22;4,6,23;4,7,24;4,8,25;4,9,26;5,6,27;5,7,28;5,8,29;5,9,30;6,7,31;6,8,32;6,9,33;7,8,34;7,9,35;8,9,36;2,1,1;3,1,2;4,1,3;5,1,4;6,1,5;7,1,6;8,1,7;9,1,8;3,2,9;4,2,10;5,2,11;6,2,12;7,2,13;8,2,14;9,2,15;4,3,16;5,3,17;6,3,18;7,3,19;8,3,20;9,3,21;5,4,22;6,4,23;7,4,24;8,4,25;9,4,26;6,5,27;7,5,28;8,5,29;9,5,30;7,6,31;8,6,32;9,6,33;8,7,34;9,7,35;9,8,36];
index = ismember(MAT(:,1:2), [grid1,grid2],'rows');
Binary_Index = MAT(index==1,3);
end

