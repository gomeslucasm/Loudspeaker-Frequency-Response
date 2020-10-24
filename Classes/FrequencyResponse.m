%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                        %
%         Measurement frequency response                 %
%                                                        %
%   Authors: Eduardo Laux, Gabrielle Hoffmann,           %
%        Lucas Gomes, Marcelo Brites, Sidney Candido     %
%                                                        %
%         University Federal of Santa Maria              %
%                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classdef FrequencyResponse<master_audio
    
    properties
        Type;
        Reponse;
    end
    methods
        function this = FrequencyResponse(varargin)           
            % Input and default arguments
            sArgs = containers.Map({'Time','Signal','Type','Fs','T_win'},...
                {[],[],'Near',44100,[]});
            if strcmp(sArgs('Type'),'Near')
                sArgs('T_win')=1;
            else
                sArgs('T_win') = 0.002;
            end
            for i=1:2:length(varargin)
               sArgs(varargin{i}) = varargin{i+1}; 
            end
            
            % Case of itaAudio
            if isa(sArgs('Time'),'itaAudio')
               x = sArgs('Time');
               sArgs('Time') = x.time;
               sArgs('Fs') = x.samplingRate;
            end       
            if isa(sArgs('Signal'),'itaAudio')
               x = sArgs('Signal');
               sArgs('Signal') = x.time;
            end
            % Impulse response
            IR = ifft(fft(sArgs('Time'))./fft(sArgs('Signal')),'symmetric');         
            
            % Windowing 
            [~,idx_Peak_IR] = max(abs(IR));
            L_win = sArgs('T_win')*sArgs('Fs')*2;
            Win = hann(L_win);
            Win = Win(round(length(Win)/2):end);
            %%
%             figure()
%             time = linspace(0,length(IR)/44100,length(IR))
%             plot(time,IR)
            %%
            IR(idx_Peak_IR+1:idx_Peak_IR+length(Win)) = ...
                IR(idx_Peak_IR+1:idx_Peak_IR+length(Win)).*Win;
            IR = IR(1:idx_Peak_IR+length(Win));
            %Saving date on object
            this.time_data = IR.';
            this.Type = sArgs('Type'); 
            %%
%             figure()
%             time = linspace(0,length(IR)/44100,length(IR))
%             plot(time,IR)
            %%
        end
    end
end