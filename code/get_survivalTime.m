function time = get_survivalTime(  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global MU;

time = exprnd(MU);
time=ceil(time);

end

