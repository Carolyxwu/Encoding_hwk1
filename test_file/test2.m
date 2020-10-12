adress_Linear=["sim_10-Oct-2020 16_19_03_#7.mat" "sim_10-Oct-2020 16_28_18_#8.mat"...
               "sim_10-Oct-2020 16_46_22_#9.mat" "sim_10-Oct-2020 22_03_59_#10.mat"];
adress_Kalman=["sim_10-Oct-2020 15_35_26_#3.mat" "sim_10-Oct-2020 15_47_26_#4.mat"...
               "sim_10-Oct-2020 22_32_17_#5.mat" ];
%SNR_arr=[];
%N_Sim,L_encoded,N_info_bits
err_bit_cnt_after_coding_Linear=zeros(17,4);
err_bit_cnt_before_coding_Linear=zeros(17,4);
err_bit_cnt_after_coding_Kalman=zeros(17,3);
err_bit_cnt_before_coding_Kalman=zeros(17,3);
for idx=1:4
    load(adress_Linear(idx));
    err_bit_cnt_after_coding_Linear(:,idx)=err_bit_cnt_after_coding;
    err_bit_cnt_before_coding_Linear(:,idx)=err_bit_cnt_before_coding;
end
for idx=1:3
    load(adress_Kalman(idx));
    err_bit_cnt_after_coding_Kalman(:,idx)=err_bit_cnt_after_coding;
    err_bit_cnt_before_coding_Kalman(:,idx)=err_bit_cnt_before_coding;
end
%display
%err_bit_cnt_before_coding Linear
figure;
hold on;
set(gca, 'yscale', 'log');
for idx=1:4
    plot(SNR_arr, (err_bit_cnt_before_coding_Linear(:,idx)/(L_encoded(1)*N_sim)).');
end
legend('b=0', 'b=0.1 rho=0.1','b=0.5 rho=0.95','b=1 rho=1');
title('BER-SNR Curve');
xlabel('SNR(dB)');
ylabel('BER');
grid on;
%err_bit_cnt_after_coding Linear
figure;
hold on;
set(gca, 'yscale', 'log');
for idx=1:4
    plot(SNR_arr, ((err_bit_cnt_after_coding_Linear(:,idx))/(N_info_bits*N_sim)).');
end
legend('b=0', 'b=0.1 rho=0.1','b=0.5 rho=0.95','b=1 rho=1');
title('BER-SNR Curve');
xlabel('SNR(dB)');
ylabel('BER');
grid on;

%err_bit_cnt_before_coding Kalman
figure;
hold on;
set(gca, 'yscale', 'log');
for idx=1:3
    plot(SNR_arr, (err_bit_cnt_before_coding_Kalman(:,idx)/(L_encoded(1)*N_sim)).');
end
legend('b=0.1 rho=0.1','b=0.5 rho=0.95','b=1 rho=1');
title('BER-SNR Curve');
xlabel('SNR(dB)');
ylabel('BER');
grid on;
%err_bit_cnt_after_coding Kalman
figure;
hold on;
set(gca, 'yscale', 'log');
for idx=1:3
    plot(SNR_arr, ((err_bit_cnt_after_coding_Kalman(:,idx))/(N_info_bits*N_sim)).');
end
legend('b=0.1 rho=0.1','b=0.5 rho=0.95','b=1 rho=1');
title('BER-SNR Curve');
xlabel('SNR(dB)');
ylabel('BER');
grid on;