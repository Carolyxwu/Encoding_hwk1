
function [transmit_signal] = syms2waveform(syms, waveform_conf, disp_flag)

%Summary of this function goes here
%��ƽ����ת���ε�һ��ʵ��
%���룺syms                    ����ƽ��������
%      waveform_conf           ���β��� 
%�����transmit_signal         �ز�����
%   Detailed explanation goes here

    if ~exist('disp_flag', 'var') || isempty(disp_flag)
        disp_flag = false;
    end
     
    oversample_rate = waveform_conf.oversample_rate;
    fs = waveform_conf.fs;      % sample rate 16000Hz

    fc = waveform_conf.fc;      % carrier freq = 1850Hz    
    Group_delay=waveform_conf.Group_delay;
    g_arr=waveform_conf.g_arr;
    
    N_syms = length(syms);
    len_signal = N_syms * oversample_rate + 2*Group_delay;
    transmit_delta_sequence = zeros(len_signal,1);    

    
    for k = 1:N_syms
        transmit_delta_sequence(1+(k-1)*oversample_rate) = syms(k);
    end
    transmit_signal_baseband = filter(g_arr, [1], transmit_delta_sequence);  % generate I/Q signals  && put into physical AWGN channel.
    if disp_flag
        figure;

        
        n_arr = (0:length(transmit_delta_sequence)-1).';
        stem(n_arr, real(transmit_delta_sequence));
        hold on;
        stem(n_arr, real(transmit_signal_baseband));
        title('(Re) delta sequence && x_B_B_,_I(n)');
        legend('transmit delta', 'transmit baseband');
        xlabel('n');
        ylabel('Amplitude');

    end
    % up-convert.
    % channel parameters.

    transmit_signal = real(transmit_signal_baseband .* exp(1j*2*pi*((0:len_signal-1).')*fc/fs));    % upconvert.    
    transmit_signal=transmit_signal.';
end

