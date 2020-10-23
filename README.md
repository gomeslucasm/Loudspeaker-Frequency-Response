# Speaker Frequency Response


Matlab scripts for processing speaker frequency response by taking a merge of *far* and *near* impulse reponse measurement.



<p align="center">
  <img src="https://github.com/gomeslucasm/Speaker-Frequency-Response/blob/master/image1.png">
</p>



## How to use

- Impulse response:

```
% Calculating impulse response 
Response = FrequencyResponse('Time',Measure,'Signal',Excitation_signal,'Type',Near or Far,...
                      'T_win',Time length to cut the signal after the maximum peak);
```


- Combined response:

```
Combined_response = ProcessCombinedResponse(Near Response,Far Reponse,'a',Length of speaker);
```



