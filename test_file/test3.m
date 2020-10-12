adress=["sim_10-Oct-2020 00_40_41_#1.mat" "sim_10-Oct-2020 00_56_54_#6.mat"...
        "sim_10-Oct-2020 22_15_23_#16.mat" ];
%SNR_arr=[];
%N_Sim,L_encoded,N_info_bits
err_bit_cnt_after_coding_matrix=zeros(17,3);
err_bit_cnt_before_coding=zeros(17,3);
for idx=1:3
    load(adress(idx));
    err_bit_cnt_after_coding_matrix(:,idx)=err_bit_cnt_after_coding;
    err_bit_cnt_before_coding_matrix(:,idx)=err_bit_cnt_before_coding;
end

%display
%err_bit_cnt_before_coding
figure;
hold on;
set(gca, 'yscale', 'log');
for idx=1:3
    plot(SNR_arr, (err_bit_cnt_before_coding_matrix(:,idx)/(L_encoded(1)*N_sim)).');
end
legend('Kalman', '线性插值','三次样条插值');
title('BER-SNR Curve');
xlabel('SNR(dB)');
ylabel('BER');
grid on;
%err_bit_cnt_after_coding
figure;
hold on;
set(gca, 'yscale', 'log');
for idx=1:3
    plot(SNR_arr, ((err_bit_cnt_after_coding_matrix(:,idx))/(N_info_bits*N_sim)).');
end
legend('Kalman', '线性插值','三次样条插值');
title('BER-SNR Curve');
xlabel('SNR(dB)');
ylabel('BER');
grid on;