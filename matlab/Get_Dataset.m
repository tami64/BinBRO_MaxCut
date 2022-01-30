function [fsource, OptimumSol] = Get_Dataset(N)
%GET_DATASET Summary of this function goes here
%   Detailed explanation goes here

switch N
    case 1
        fsource = '..\Dataset\cap71.txt';
        OptimumSol = 932615.750;
    case 2
        fsource = '..\Dataset\cap72.txt';3
        OptimumSol = 977799.400;
    case 3
        fsource = '..\Dataset\cap73.txt';
        OptimumSol = 1010641.450;
    case 4
        fsource = '..\Dataset\cap74.txt';
        OptimumSol = 1034976.975;
    case 5
        fsource = '..\Dataset\cap101.txt';
        OptimumSol = 796648.438;
    case 6
        fsource = '..\Dataset\cap102.txt';
        OptimumSol = 854704.200;
    case 7
        fsource = '..\Dataset\cap103.txt';
        OptimumSol = 893782.113;
    case 8
        fsource = '\Dataset\cap104.txt';
        OptimumSol = 928941.750;
    case 9
        fsource = '..\Dataset\cap131.txt';
        OptimumSol = 793439.563;
    case 10
        fsource = '..\Dataset\cap132.txt';
        OptimumSol = 851495.325;
    case 11
        fsource = '..\Dataset\cap133.txt';
        OptimumSol = 893076.713;
    case 12
        fsource = '..\Dataset\cap134.txt';
        OptimumSol = 928941.750;
    case 13
        fsource = '..\Dataset\capa.txt';
        OptimumSol = 17156454.478;
    case 14
        fsource = '..\Dataset\capb.txt';
        OptimumSol = 12979071.581;
    case 15
        fsource = '..\Dataset\capc.txt';
        OptimumSol = 11505594.33;
end
