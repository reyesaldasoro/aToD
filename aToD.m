function aToD(action)
%        analogue to digital conversion        ----------
%------------------------------------------------------ 
%------  Author :   Constantino Carlos Reyes-Aldasoro -
%------             PHD     the University of Warwick -
%------  Supervisor :   Abhir Bhalerao    -------------
%------  January 2002    ------------------------------
%------------------------------------------------------ 
%------   Based on a previous version developed for   -
%------   ITAM : http://lamport.rhon.itam.mx/~creyes  -
%------   back in time .... 1998 ?                    -
%------------------------------------------------------
%clear;
fig=gcf;
%obj=gco;
%clf
global  popfunc slifrec pbend valorfrec slifrec slifrmu valorfrmu pmuest
global   slibits valorbits  valorfrmu pcuanti panadi y_t t ys_t ts frec
global y_bin maxbits y_bin_tx panadi numbits niveles y_binmat factor
if (nargin<1)
    action = 'initialize';
end

if strcmp(action,'initialize')
    set(figure(1),'MenuBar','none');
    set(figure(1),'Name','Analogue to Digital Conversion');
    set(figure(1),'NumberTitle','off');
    %----------------------------------------------
    % Solamente se genera el tipo de función y su frecuencia
    %----------------------------------------------
    %tipo de funcion
    nomfunc=uicontrol(fig,'Style','text','position',[5 50 115 35],...
        'string','signal');
    popfunc = uicontrol(fig,'Style','popup',...
        'String','sine|square|triangular',...
        'position',[5 39 115 30],...
        'CallBack','aToD(''signal'')');
    %----------------------------------------------
    %terminar
    pbend= uicontrol(fig,'Style','push','position',[5 10 115 30],...
        'String','close','CallBack','close');
    slifrec= uicontrol(fig,'Style','slider','position',[125 10 130 35],...
        'Min',1,'Max',10,'Value',1,'CallBack','aToD(''signal'')');
    nomfrec=uicontrol(fig,'Style','text','position',[125 50 100 35],...
        'string','Signal Freq');
    valorfrec=uicontrol(fig,'Style','text','position',[225 50 30 35],...
        'string',num2str(get(slifrec,'Value')));
    
    
elseif  strcmp(action,'signal')
    %--------------------------------------
    % Genera la señal y la grafica
    % y da las opciones de muestreo
    %--------------------------------------
    
    %--------------------------------------
    %opcion de frecuencia de muestreo
    %el slider con la frecuencia
    slifrmu= uicontrol(fig,'Style','slider','position',[275 10 130 35],...
        'Min',4,'Max',50,'Value',10,'CallBack','aToD(''sampl'')');
    nomfrmu=uicontrol(fig,'Style','text','position',[275 50 100 35],...
        'string','sampling frequency');
    valorfrmu=uicontrol(fig,'Style','text','position',[375 50 30 35],...
        'string',num2str(get(slifrmu,'Value')));
    
    %el botón que llama a muestrear
    pmuest= uicontrol(fig,'Style','push','position',[5 90 110 35],...
        'String','Sample','CallBack','aToD(''sampl'')');
    
    %--------------------------------------
    %toma valores de la frecuencia de la señal y vuelve a graficarlos
    nomfrec=uicontrol(fig,'Style','text','position',[125 50 100 35],...
        'string','signal frequency');
    valorfrec=uicontrol(fig,'Style','text','position',[225 50 30 35],...
        'string',(num2str(round(get(slifrec,'Value')))));
    
    %-----------------------------------------
    % genera la señal
    frec=round(get(slifrec,'value'));        %frecuencia de la senal
    t=0:0.005:2*pi-0.01;                     %eje del tiempo
    signalnum=get(popfunc,'value');          %tipo de senal
    
    %-----------------------------------------
    %decide las funciones
    if signalnum ==1
        x_t2=((sin(t*frec)));                  %senoidal
    elseif signalnum ==2
        x_t2=sign(sin(t*frec));                   %square
    elseif signalnum ==3
        %    t=0:0.002:2*pi-0.01;                     %eje del tiempo
        xa_t2=cumsum(sign(sin(t*frec)));          %triangular
        x_t2=1-2*xa_t2/max(xa_t2);
    end
    y_t=x_t2;
    
    %-----------------------------------------
    % grafica
    figure(1)
    subplot(2,1,1)
    plot(t,y_t)
    title('analogue signal');
    axis([-0.1 6.3 -1.1 1.1]);
    
elseif  strcmp(action,'sampl')
    % Seccion de muestreo
    % se abre la opcion de cuantizar
    
    %--------------------------------------
    %slider de cuantización
    % slibits= uicontrol(gcf,'Style','slider','position',[415 10 130 35],...
    %     'Min',1,'Max',15,'Value',3,'CallBack',['set(valorbits,''String'',',...
    %        'num2str(round(get(slibits,''Val'')))),aToD(''cuanti'')']);
    slibits= uicontrol(gcf,'Style','slider','position',[415 10 130 35],...
        'Min',1,'Max',15,'Value',3,'CallBack',['aToD(''cuanti'')']);
    nombits=uicontrol(gcf,'Style','text','position',[415 50 100 35],...
        'string','Number of bits');
    valorbits=uicontrol(gcf,'Style','text','position',[515 50 30 35],...
        'string',num2str(get(slibits,'Value')));
    
    %-----------------------------------------
    %retoma la frecuencia de muestreo y la grafica
    nomfrmu=uicontrol(fig,'Style','text','position',[275 50 100 35],...
        'string','sampling frequency');
    valorfrmu=uicontrol(fig,'Style','text','position',[375 50 30 35],...
        'string',num2str(round(get(slifrmu,'Value'))));
    
    %-----------------------------------------
    % Toma valores de bits y muestras de las reglas
    frec=round(get(slifrec,'value'));         %frecuencia de la senal
    frmu=round(get(slifrmu,'value'));         %frecuencia de muestreo
    %genera el eje de muestreo y la nueva señal muestreada
    ts=0:2*pi/frmu:2*pi-0.01;                 %muestras en el eje x
    pm=floor(ts*length(t)/2/pi+1);                 %posiciones de muestreo
    ys_t=y_t(pm);                             %senal muestreada
    %decide el numero de niveles
    %numbits=round(get(slibits,'value'));      %numero de bits
    %niveles=2^numbits;                        %numero de niveles de cuantizacion
    
    %-----------------------------------------
    %grafica
    figure(1)
    subplot(2,1,1)
    plot(t,y_t,'b:',ts,ys_t,'r*')
    title('sampled signal');
    axis([-0.1 6.3 -1.1 1.1]);
    
    %-----------------------------------------
    %botones de muestreo y cuantización
    pcuanti = uicontrol(fig,'Style','push','position',[125 90 130 35],...
        'String','Quantise','CallBack','aToD(''cuanti'')');
    
elseif  strcmp(action,'cuanti')
    valorbits=uicontrol(gcf,'Style','text','position',[515 50 30 35],...
        'string',num2str(round(get(slibits,'Value'))));
    
    %--------------------------------------
    %programa de cuantización, se abrela opción
    % de la conversion A/D
    
    %--------------------------------------
    %botón de conversion A/D
    panadi= uicontrol(fig,'Style','push','position',[275 90 130 35],...
        'String','A/D','CallBack','aToD(''anadig'')');
    %--------------------------------------
    %numero de niveles
    numbits=round(get(slibits,'value'));      %numero de bits
    niveles=2^numbits;                        %numero de niveles de cuantizacion
    
    %--------------------------------------
    % realiza la cuantización de la señal
    figure(1)
    subplot(2,1,1)
    %--------------------------------------
    %grafica la señal original y las muestras
    plot(t,y_t,'b:',ts,ys_t,'r*')
    title('quantised signal');
    hold on
    if niveles<33 
        %niveles con los que se compara
        linea=ones(1,length(t));
        aux=-1;
        incremento=2/(niveles-1);
        for i=1:niveles
            cuant(i,:)=linea*aux;
            aux=aux+incremento;
            %niveles de comparación
            plot(t,cuant(i,:),'g:'); 
            niv_bits=dec2bin(i-1,numbits);
            %bits correspondientes al nivel
            if niveles<17
                text(6.3,cuant(i,1),niv_bits);
            end   
        end
    end
    
    % cuantizacion: asigna digitos a cada valor
    factor=(niveles-1)/2;    
    y_cuant=((round((ys_t+1)*factor))/factor)-1;
    %--------------------------------------
    %grafica las aproximaciones de las muestras a los niveles
    plot(ts,y_cuant,'ko');
    axis([-0.1 7 -1.1 1.1]);
    hold off;
    
elseif  strcmp(action,'anadig')
    
    % Conversión analógica a digital
    %abre la opción de conversión D/A
    %---------------------------------
    %botón D/A
    pdigan= uicontrol(fig,'Style','push','position',[415 90 130 35],...
        'String','D/A','CallBack','aToD(''digan'')');
    
    %---------------------------------
    %toma el numero de bits
    numbits=round(get(slibits,'value'));      %numero de bits
    niveles=2^numbits;                        %numero de niveles de cuantizacion
    factor=(niveles-1)/2;    
    
    % cuantizacion: asigna digitos a cada valor
    digitos=round((ys_t+1)*factor);
    
    %convierte a binario
    y_bin=[];
    y_binmat=[];
    for i=1:length(digitos)
        dat=[];
        div=digitos(i);
        for j=1:numbits
            dat=[rem(div,2) dat];
            div=floor(div/2);
        end
        y_bin=[y_bin dat];
        y_binmat=[y_binmat;dat];
    end
    %---------------------------------
    %comienza la gráfica con la señal digital y
    %los bits que corresponden a ella
    subplot(2,1,1)
    stairs((0:length(y_bin)-1),y_bin);
    hold on
    plot((0:length(y_bin)-1),y_bin,'r+');
    title('digital signal');
    axis([-0.1 length(y_bin)-0.9 -0.1 1.1]);
    %---------------------------------
    %genera el texto con los bits
    y_bin_tx=[]; 
    [aa,bb]=size(y_binmat);
    for ii=1:aa
        y_bin_tx=[y_bin_tx  num2str(y_binmat(ii,:)) ', '];
    end
    y_bin_tx=['bits = ' y_bin_tx]; 
    %---------------------------------
    %se limita la longitud de los bits
    maxbits=length(y_bin_tx);
    if maxbits>80
        maxbits=80;
    end
    xlabel(y_bin_tx(1:maxbits-2))
    hold off
    
elseif  strcmp(action,'digan')
    
    
    % reconversion a analógico usando matriz auxiliar y_binmat y otra matriz dos_ala_n
    
    %----------------------------------
    %recupera la señal original con la multiplicación de los valores de los niveles
    %por y_binmat que es una matriz con los bits como palabras de los bits
    niv2=(numbits-1:-1:0);
    dos_ala_n=(2.^niv2)';
    y_t_rec=((y_binmat*dos_ala_n)');
    y_fin=(y_t_rec-factor)/factor;
    
    %resolucion deseada
    resol=8192;   
    %----------------------------------
    %transformada de la señal original
    y_f=(abs(fft(y_t,resol)));
    aux1=length(y_t);
    frec_y_f=(aux1/resol:aux1/resol:aux1);
    %----------------------------------
    %transformada de la señal original
    ys_f=(abs(fft(ys_t,resol)));
    aux2=length(ys_t);
    frec_ys_f=(aux2/resol:aux2/resol:aux2);
    
    %-----------------------------------
    %graficas
    figure(1)
    subplot(3,2,1)               %primera grafica original en tiempo
    plot(t,y_t,ts,ys_t,'r*')
    title('analogue signal');
    ylabel('time');
    axis([-0.1 6.3 -1.1 1.1]);
    
    subplot(3,2,2)               %segunda grafica reconstruida en tiempo
    plot(ts,y_fin,ts,y_fin,'co');
    title('reconstructed signal');
    axis([-0.1 6.3 -1.1 1.1]);
    
    subplot(3,2,3)               %tercera grafica original en frecuencia
    %  plot(frec_y_f(1:resol*12/aux1),y_f(1:resol*12/aux1));
    plot(frec_y_f,y_f);
    axis([0 length(y_f)/160 0 max(y_f)*1.1]);
    ylabel('frequency');
    
    subplot(3,2,4)               %cuarta grafica reconstruida en frecuencia
    limfrec=resol*12/aux2;
    if (limfrec>resol/2) 
        limfrec=resol/2; 
    end
    plot(frec_ys_f(1:floor(limfrec)),ys_f(1:floor(limfrec)));
    %   plot(frec_ys_f,ys_f);
    %  plot(frec_ys_f(1:length(ys_f)/2),ys_f(1:length(ys_f)/2)); 
    axis([0 frec_ys_f(floor(limfrec)) 0 max(ys_f)*1.1]);
    hold off
    
end
