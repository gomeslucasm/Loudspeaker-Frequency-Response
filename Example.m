%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                        %
%         Processing script example of a  merged         % 
%        frequency response of a loudspeaker             %
%                                                        %
%   Authors: Eduardo Laux, Gabrielle Hoffmann,           %
%        Lucas Gomes, Marcelo Brites, Sidney Candido     %
%                                                        %
%         University Federal of Santa Maria              %
%                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clear all; close all;
%% Loading data
load('Measurement.mat')
%% Processing frequency response
%%%%%%% Near measurement %%%%
Near_response = FrequencyResponse('Time',Near_measurement,'Signal',signal,'Type','Near','T_win',1,'Fs',Fs);
Near_response.plot_freq
title('Near frequency response')
%%%%%%% Far measurement %%%%%
Far_response = FrequencyResponse('Time',Far_measurement,'Signal',signal,'Type','Far','T_win',0.002,'Fs',Fs);
Far_response.plot_freq
title('Far frequency response')
%%
Out_combined = ProcessMergedResponse(Near_response,Far_response,'a',0.0508,'PlotMerged',1);
Out_combined.plot
title('Merged frequency response')
%%