# Sound speaker Frequency Response


Matlab scripts for processing combined frequency response, using far and near impulse reponse measurement of a sound speaker .


<p align="center">
  <img src="https://github.com/gomeslucasm/Speaker-Frequency-Response/blob/master/image1.png">
</p>



## How to use

```

% Calculating impulse response 
Response = FrequencyResponse('Time',Measure,'Signal',Excitation_signal,'Type',Near or Far,'T_win',Time length to cut the signal after the maximum peak);


```
