classdef master_audio<handle
    properties
       time_data = []
       time_vector = []
       freq_data = []
       freq_vector = []
       Fs = 44100;
    end
    %%%%%%% Plot methods %%%%%%%%%%%%
    methods
        function plot_time(obj,num)
            if nargin<2
                z = size(obj.time_data);
                num = randi(z(1));
            end
            figure()
            plot(obj.time_vector(num,:),obj.time_data(num,:))
            xlabel('Tempo[s]')
            ylabel('Amplitude [-]')
            xlim([obj.time_vector(num,1) obj.time_vector(num,end)])
            arruma_fig('% 2.2f','% 2.3f','virgula')
        end
        function plot_time_dB(obj,num)
            if nargin<2
                z = size(obj.time_data);
                num = randi(z(1));
            end
            figure()
            plot(obj.time_vector(num,:),20*log10(abs(obj.time_data(num,:))/2e-5))
            xlabel('Tempo[s]')
            ylabel('Amplitude [dB] ref.: 2e-5')
            xlim([obj.time_vector(num,1) obj.time_vector(num,end)])
            arruma_fig('% 2.2f','% 2.1f','virgula')
        end
        function plot_freq(obj,num)
            if nargin<2
                z = size(obj.time_data);
                num = randi(z(1));
            end
           figure()
            semilogx(obj.freq_vector(num,:),20*log10(abs(obj.freq_data(num,:))/(2e-5)),...
                'LineWidth',1.5,'Color','k')
            grid on 
            xlabel('Frequency [Hz]')
            ylabel('Amplitude [dB] ref.: 2e-5')
            xlim([min(obj.freq_vector(num,:)) obj.Fs/2])
            arruma_fig('% 2.1f','% 2.1f','virgula')
            set(gcf, 'Position',  [161,246,848,338])
        end
        function plot_tf(obj,num)
            if nargin<2
                z = size(obj.time_data);
                num = randi(z(1));
            end
            figure()
            subplot(2,1,1)
            plot(obj.time_vector(num,:),obj.time_data(num,:))
            xlabel('Tempo[s]')
            ylabel('Amplitude [-]')
            xlim([obj.time_vector(num,1) obj.time_vector(num,end)])
            subplot(2,1,2)
            semilogx(obj.freq_vector(num,:),20*log10(abs(obj.freq_data(num,:))))
            xlabel('Frequency [Hz]')
            ylabel('Amplitude [-]')
            arruma_fig('% 2.2f','% 2.2f','virgula')
            xlim([min(f_v) obj.Fs/2])
        end
        function plot_spec(obj,varargin)
            %Optional Inputs
            % WLen - Window Length
            % Overlap-
            % FRange - 
            % dF - 
            sArgs = containers.Map({'N','WLen','Overlap','dF','NFFT'},...
                {1,2048,0.75,1,44100});
            
            sArgs('dF') = sArgs('WLen')/obj.Fs;
            sArgs('NFFT') = round(sArgs('dF')*obj.Fs);
            for i=1:2:length(varargin)
                sArgs(varargin{i}) = varargin{i+1};
            end
            num = sArgs('N');
            WLen = sArgs('WLen'); df = sArgs('dF'); NFFT = sArgs('NFFT');
            Overlap = sArgs('Overlap'); 
            %%%%%%%%%%% SPECTROGRAM %%%%%%%%%%%
            %[S,F,T] = spectrogram(obj.time_data(num,:),hann(WLen),round(WLen*Overlap),NFFT,obj.Fs,'yaxis');
            figure()
            spectrogram(obj.time_data(num,:),hann(WLen),round(WLen*Overlap),NFFT,obj.Fs,'yaxis');
            colorbar('off')
            colormap(jet)
            title(['Spectrogram ' 'Window Length = ' num2str(WLen)  ' Overlap = ' num2str(Overlap) ])
            
        end
    end
    %%%%%%% Extra methods
    methods
        function ExportAudio(obj,filename,varargin)
            sArgs = containers.Map({'Fit'},{0.001});
            for i =1:2:length(varargin)
                 sArgs(varargin{i}) = varargin{i+1};
            end
            if nargin<2
                filename = 'audio.wav';
            end
            audiowrite(['Audio\' filename],obj.time_data'.*sArgs('Fit')*0.9,obj.Fs)
        end
        function varargout = RMS(obj)
            val_rms = rms(obj.time_data,'dim',2);
            if nargout==0
                for i=1:1:length(val_rms)
                   fprintf(['Channel ' num2str(i) ...
                       ' - ' num2str(mag2dbPa(val_rms(i))) ' dB [pa] rms \n']) 
                end
                varargout{1} = val_rms;
            else    
                varargout{1} = val_rms;
            end
        end
    end   
    %%%%%%% Get methods %%%%%%%%%%%%%
    methods
        function a = get.time_vector(obj)
            if nargin==1
                z = size(obj.time_data);
                if z(1)>1
                    for i=1:1:z(1)
                        a(i,:)= linspace(0, length(obj.time_data(i,:))/obj.Fs, length(obj.time_data(i,:)));
                    end
                else
                    a = linspace(0, length(obj.time_data)/obj.Fs, length(obj.time_data));
                end
            
            else
                a = obj.time_vector;
            end
        end
        function f = get.freq_data(obj)
            z = size(obj.time_data);
            if z(1)>1
                for i=1:1:z(1)
                    [f(i,:) ,~] = get_fft(obj.time_data(i,:),'Fs',obj.Fs);
                end
            else    
                [f ,~] = get_fft(obj.time_data,'Fs',obj.Fs);
            end
        end
        function f_v = get.freq_vector(obj)
            z = size(obj.time_data);
            if z(1)>1
                for i=1:1:z(1)
                    [~,f_v(i,:)] = get_fft(obj.time_data(i,:),'Fs',obj.Fs);
                end
            else 
                [~,f_v] = get_fft(obj.time_data,'Fs',obj.Fs);
            end
        end
     end
end

