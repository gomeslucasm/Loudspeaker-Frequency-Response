%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                        %
%         Function to process the merged                 %
%        frequency response of a loudspeaker             %
%                                                        %
%   Authors: Eduardo Laux, Gabrielle Hoffmann,           %
%        Lucas Gomes, Marcelo Brites, Sidney Candido     %
%                                                        %
%         University Federal of Santa Maria              %
%                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function out = ProcessMergedResponse(Audio1,Audio2,varargin)


%%%%%%%% Inputs %%%%%%%%%%
sArgs = containers.Map({'a','c0'},{0.1,343});

for i=1:2:length(varargin)
   sArgs(varargin{i}) = varargin{i+1}; 
end

if strcmp(Audio1.Type,'Near')
    Near = Audio1;
    Far = Audio2;
else
    Near = Audio2;
    Far = Audio1;
end

%%%%%%%%%%%% Processing %%%%%%%%%%%%%%%%
%%% Adjusting length of vectors %%%
L_near = length(Near.time_data);
L_far = length(Far.time_data);
if L_near>L_far
    Far.time_data(L_far+1:L_near) = 0;
else
    Near.time_data(L_near+1:L_far) = 0;
end
%%% Transition frequency %%%
f = sArgs('c0')/(sArgs('a')*2*pi);
[~,idx] = min(abs(Far.freq_vector-f));
%%% Normalizing
amp1 = abs(Near.freq_data(idx));     
amp2 = abs(Far.freq_data(idx)); 
adjust_val = amp1/amp2;
%%% Merging near and far response %%%
f_near = abs(Near.freq_data);
f_far = abs(Far.freq_data).*adjust_val;
%%
f_v = Far.freq_vector;
figure()
semilogx(f_v,20*log10(f_near))
hold on
semilogx(f_v,20*log10(f_far))
xlim([20 22050])
%%
f_out = zeros(length(f_near),1);
f_out(1:idx) = f_near(1:idx);
f_out(idx+1:end) = f_far(idx+1:end);
f_out = f_out./max(f_out);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out = MergedFrequencyResponse(f_out,Near.Fs);
end