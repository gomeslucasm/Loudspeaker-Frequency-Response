%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                        %
%         Merged frequency response                      %
%                                                        %
%   Authors: Eduardo Laux, Gabrielle Hoffmann,           %
%        Lucas Gomes, Marcelo Brites, Sidney Candido     %
%                                                        %
%         University Federal of Santa Maria              %
%                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


classdef MergedFrequencyResponse
    
   properties
      freq_data; 
      freq_vector;
      Fs;
   end
   
   methods
       function this = MergedFrequencyResponse(data,Fs)
          this.freq_data = data;
          this.Fs = Fs;
          this.freq_vector = linspace(0,Fs/2,length(data));
       end
        
       function plot(obj,varargin)
           sArgs = containers.Map({'ref'},{1});
           for i=1:2:length(varargin)
            sArgs(varargin{i}) = varargin{i+1};
           end
           figure()
           semilogx(obj.freq_vector,20*log10(obj.freq_data/sArgs('ref')),...
               'Color','k','Linewidth',1.5);
           xlabel('Frequency [Hz]')
           ylabel(['Amplitude [dB] ref.: ' num2str(sArgs('ref'))])
           xlim([20 max(obj.freq_vector)])
           arruma_fig('spec2','%1.1f','ponto')
           set(gcf, 'Position',  [161,246,848,338])
           grid on 
       end
   end
    
end