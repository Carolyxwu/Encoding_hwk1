clear all;
setup_wave;
setup_mapper;
load('data/message.mat');
%% Generate complex symbols with energy 1.
N_syms = 4000;
N_sim = 1;
Ebn0_arr = [20, 15, 12.5, 10, 8, 6, 5, 4, 3, 2.5, 2, 1.5, 1, 0.5, 0, -0.5, -1, -1.5];     % Eb/n0 in dB.

Es = 0.5;                                   % 1 sym in waveform channel: 0.5 energy.
Eb = Es/mapping_conf.bps;   % Notice: if hard-decision, Eb is different.
n0_arr = Eb ./ (10.^(Ebn0_arr/10));
n0 = n0_arr(4);
len_signal = N_syms * waveform_conf.oversample_rate + 2*waveform_conf.Group_delay;

for sim_iter = 1:N_sim
    syms_transmit = bit_mapping(random_bits, mapping_conf);
    [transmit_signal] = syms2waveform(syms_transmit,waveform_conf,false);

    [recv_syms, recv_signal] = waveform2syms(transmit_signal,n0,N_syms,waveform_conf,false);


end
time=[0:length(transmit_signal)-1]/waveform_conf.fs;%ones(size(transmit_signal))/waveform_conf.fs;
figure(1);
hold on;
plot(time(1:100),transmit_signal(1:100));
plot(time(1:100),recv_signal(1:100));
title('Transmit Signal & Receive Signal(Eb/n0=10dB)');
xlabel('Time/s');
ylabel('Amplitude');
set(gca,'XLim',[0,100/waveform_conf.fs]);
legend('Transmit Signal','Receive Signal');

%% Analyze RF signal spectrum.
% Spectrum estimation.
% L_spec = length(transmit_signal_RF{1});
% psd = zeros(L_spec,1);      % Calculate power spectrum density estimator.
% 
% for sim_iter = 1:N_sim
%     psd = psd + abs(fft(transmit_signal_RF{sim_iter})).^2;
% end
% psd = fftshift(psd / N_sim);
% figure(5);
% plot(psd);
