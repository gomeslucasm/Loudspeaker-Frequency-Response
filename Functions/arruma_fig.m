function arruma_fig(preciX,preciY,separador,figura,KX,KY,Getlabel)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Função para arrumar os eixos da figura.
% 
% Desenvolvido pelo professor da Engenharia Acústica 
%                                William D'Andrea Fonseca, Dr. Eng.
%
% Última atualização: 07/07/2019
%
% Entradas (precisãoX, precisãoY, separador, figura, KX, KY, Getlabel)
%   preciX, preciY = '%3.1f' (padrão Matlab).
%   Se utilizar 'no' ele não faz o eixo.
%   Se utilizar 'spec' ele faz marcadores para o espectro audível.
%   Se utilizar 'spec2' ele faz marcadores para o espectro audível com
%   freqs determinadas por esse código.
%
%   sepeparador = 'ponto' ou 'virgula' (opcional).
%
%   figura = objeto da figura a sert ajustada (opcional).
%
%   KX e KY = 0 ou 1 para escrever o numero de forma compacta com um 'k' no
%   final (opcional). Se K = 1.5 divide os valore por 1000 porém não
%   adiciona o 'k'. K = 2 utiliza 'k' apenas nos valores maiores que 1000.
%
%   Getlabel = [1, 1] carrega os números do vetor de labels e não do vetor
%   numérico.
%
%%% Exemplos:
% arruma_fig('% 4.0f','% 2.2f','virgula',fig.Impedancia,1,0,[1,0])
% arruma_fig('% 4.0f','% 2.2f','virgula',fig.Impedancia,1,0)
% arruma_fig('% 4.0f','% 2.2f','virgula',fig.Impedancia)
% arruma_fig('% 4.0f','% 2.2f','virgula',gcf)
% arruma_fig('% 4.0f','% 2.2f','virgula')
% arruma_fig('% 4.0f','% 2.2f')
% arruma_fig('% 2.2f') % Pecisão igual em X e Y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Consulte sep_convert
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Development test
% preciX = '% 4.0f'; preciY = '% 2.2f'; separador = 'virgula'; figura = gcf; KX = 0; KY = 0;

%% Corrige entradas
if nargin<1; error('Declare as precisões dos eixos.'); end
if nargin<2; preciY = preciX; separador = 'virgula'; figura = gcf; ax = figura.CurrentAxes; KX = 0; KY = 0; Getlabel= [0, 0]; end
if nargin<3; separador = 'virgula'; figura = gcf; ax = figura.CurrentAxes; KX = 0; KY = 0; Getlabel= [0, 0]; end
if ~exist('separador','var') || isempty(separador); separador = 'virgula'; end
if nargin<4; figura = gcf; ax = figura.CurrentAxes; KX = 0; KY = 0; Getlabel= [0, 0]; end
if nargin<7; figura = gcf; ax = figura.CurrentAxes; KX = 0; KY = 0; Getlabel= [0, 0]; end
if ~exist('figura','var') || isempty(figura); figura = gcf; ax = figura.CurrentAxes; end
if ~exist('ax','var') || isempty(ax); ax = figura.CurrentAxes; end

%% Arrumando

%%% Eixo X
if strcmp(preciX,'no') || strcmp(preciX,'NO')
      % Não corrige eixo X
elseif strcmp(preciX,'spec') % Corrige eixo com labels para spectro
    xtick.GetNum = ax.XTick; xtick.GetLabel = ax.XTickLabel; 
    xtick.NewLabelSpec = removeNum(xtick.GetNum,separador);
    set(ax,'XTick',xtick.GetNum); set(ax,'XTickLabel',xtick.NewLabelSpec);
elseif strcmp(preciX,'spec2') % Corrige eixo com labels para spectro
    xtick.GetNum = [20 40 60 100 200 400 1000 2000 4000 6000 10000 20000];
    xtick.NewLabelSpec = removeNum(xtick.GetNum,separador);
    set(ax,'XTick',xtick.GetNum); set(ax,'XTickLabel',xtick.NewLabelSpec);    
else  % Corrige eixo X
xtick.GetNum = ax.XTick; xtick.GetLabel = ax.XTickLabel; 
if Getlabel(1) == 1 % Via GetLabel
   xtick.NumFromLabel = str2double(xtick.GetLabel);
   if ~max(isnan(xtick.NumFromLabel)) % Cofere se tem NaN no vetor
    [xtick.NewLabel,~]=sep_convert(xtick.NumFromLabel,preciX,separador,KX);
   else
    disp('I found NaN in the X vector... I will try to help you in another mode.')
    [xtick.NewLabel,~]=sep_convert(xtick.GetNum,preciX,separador,KX);
   end
else                % Via vetor numérico
   [xtick.NewLabel,~]=sep_convert(xtick.GetNum,preciX,separador,KX);
end

set(ax,'XTick',xtick.GetNum); set(ax,'XTickLabel',xtick.NewLabel);
end



%%% Eixo Y
if strcmp(preciY,'no') || strcmp(preciY,'NO')
      % Não corrige eixo Y
elseif strcmp(preciY,'spec') % Corrige eixo com labels para spectro
    ytick.GetNum = ax.YTick; ytick.GetLabel = ax.YTickLabel; 
    ytick.NewLabelSpec = removeNum(ytick.GetNum,separador);
    set(ax,'YTick',ytick.GetNum); set(ax,'YTickLabel',ytick.NewLabelSpec);      
else  % Corrige eixo Y
ytick.GetNum = ax.YTick; ytick.GetLabel = ax.YTickLabel; 
if Getlabel(2) == 1 % Via GetLabel
   ytick.NumFromLabel = str2double(ytick.GetLabel);
   if ~max(isnan(ytick.NumFromLabel)) % Cofere se tem NaN no vetor
   [ytick.NewLabel,~]=sep_convert(ytick.NumFromLabel,preciY,separador,KY);
   else
    disp('I found NaN in the Y vector... I will try to help you in another mode.')
    [ytick.NewLabel,~]=sep_convert(ytick.GetNum,preciY,separador,KY);
   end   
else                % Via vetor numérico
  [ytick.NewLabel,~]=sep_convert(ytick.GetNum,preciY,separador,KY); 
end

 set(ax,'YTick',ytick.GetNum); set(ax,'YTickLabel',ytick.NewLabel);
end

%%%%%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Função que remove número do vetor do label
function Vec = removeNum(vec,separador)
SpecNum   = [3 7 8 9]; 
% AudioSpec = [20 40 60 100 200 400 1000 2000 4000 6000 10000 20000];
Verify = [SpecNum./10 SpecNum SpecNum.*10 SpecNum.*100 SpecNum.*1000 SpecNum.*10000];
vecLow = vec(vec<1); vecHigh = vec(vec>=1);
idx1=ismember(vecLow,Verify); idx2=ismember(vecHigh,Verify);
if ~isempty(vecLow);  VecL = sep_convert(vecLow,'% 1.2f',separador,2);  VecL(idx1==1) = {''}; else; VecL=[]; end
if ~isempty(vecHigh); VecH = sep_convert(vecHigh,'% 1.0f',separador,2); VecH(idx2==1) = {''}; else; VecH=[]; end
Vec = [VecL VecH];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%