# aToD:  Analogue To Digital Conversion
A simple and intuitive graphical user interface to explore and analyse the process of analogue to digital conversion

<h2 id="2">Start the Graphical User Interface aToD</h2>

<p>Call aToD from the command line without any arguments</p>

<pre class="codeinput"> aToD
boxPlot3D(xx)
</pre>
![Screenshot1](Figures/aToD1.png)



<p>aToD will create a graphical user interface. Initially, the interface gives you the option to select a type of signal (<i>sine, triangular or square</i>) or to change the frequency. When you select either of these two options, a signal will be drawn. </p>

![Screenshot1](Figures/aToD2.png)

<p>You will have now two more options, related with the sampling of the signal. If you select these, the signal will be sampled.
</p>

<p>You can change the type of signal or its frequency at any time.</p>



![Screenshot1](Figures/aToD3.png)

![Screenshot1](Figures/aToD4.png)

<p></p>



<p>When you select to sample the signal, or change the sampling frequency, the signal will be sampled and you will be presented with new options related to quantisation. A proper combination of sampling frequency, and quantisation levels or number of bits is crucial in the analogue to digital conversion process.
</p>

![Screenshot1](Figures/aToD5.png)

<p>Once you sample and quantise your signal, the signal will be presented in dotted lines with the actual samples in red stars with the quantised samples in black circles. This illustrates the quantisation error that is due to the number of levels. Change the number of bits and compare.
</p>

![Screenshot1](Figures/aToD6.png)

<p> The digital signal is illustrated with a No-Return-to-zero code (1 as a high level and 0 as a low level), and only some bits are written down under the digital signal.
</p>

![Screenshot1](Figures/aToD7.png)

<p>Finally, you can convert back from digital to analogue.
</p>

![Screenshot1](Figures/aToD8.png)

<p>Explore the differences in A/D and D/A conversions with different sampling and quantising values
</p>

![Screenshot1](Figures/aToD9.png)

<p>
</p>

![Screenshot1](Figures/aToD10.png)

<p>A final experiment is to sample below the critical sampling frequency, also known as Nyquist rate. See what happens with the signal as you convert to digital and back!
</p>

![Screenshot1](Figures/aToD11.png)


[![View aToD on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://uk.mathworks.com/matlabcentral/fileexchange/96469-atod)
