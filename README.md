# Loudspeaker Frequency Response 🔊


Matlab scripts for processing **speaker frequency response** by taking a merge of **far** and **near** impulse reponse measurement.



<p align="center">
  <img src="https://github.com/gomeslucasm/Speaker-Frequency-Response/blob/master/image1.png">
</p>

The scripts were used for a work in a Loudspeakers course teached by Professor Willian D'Andrea at University Federal of Santa Maria,  .

Authors: Eduardo Laux, Gabrielle Hoffmann, Lucas Gomes, Marcelo Brites, Sidney Candido.

## How to use

In the repository there is an example file (example.m) that contains a processing script for a real measurement of a loudspeaker.

- Impulse response:

```
% Calculating impulse response 
Response = FrequencyResponse('Time',Measure,'Signal',Excitation_signal,'Type',Near or Far,...
                      'T_win',Time length to cut the signal after the maximum peak,'Fs',Sampling Rate);

```

A time data vector or an itaAudio is accepted as the 'time' and 'signal' input parameter.

- Combined response:

```
Merged_response = ProcessMergedResponse(Near_Response,Far_Reponse,'a',Speaker Radius);

% Optional Inputs - 'c0',sound velocity (default = 343)
%                 - 'PlotMerged', 1 for plotting both impulse responses (far and near) in the same plot (default = 0)
```



