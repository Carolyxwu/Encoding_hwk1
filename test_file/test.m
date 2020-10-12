adress=["sim_10-Oct-2020 08_58_30_#11.mat" "sim_10-Oct-2020 09_10_18_#12.mat"...
        "sim_10-Oct-2020 09_40_49_#13.mat" "sim_10-Oct-2020 09_16_41_#14.mat"...
        "sim_10-Oct-2020 21_54_19_#15.mat"];
%SNR_arr=[];
%N_Sim,L_encoded,N_info_bits
err_bit_cnt_after_coding_matrix=zeros(17,5);
err_bit_cnt_before_coding=zeros(17,5);
for k=1:5
    load(adress(k));
    err_bit_cnt_after_coding_matrix(:,k)=err_bit_cnt_after_coding;
    err_bit_cnt_before_coding_matrix(:,k)=err_bit_cnt_before_coding;
end

%display
%err_bit_cnt_before_coding
figure;
hold on;
set(gca, 'yscale', 'log');
for k=2:5
    plot(SNR_arr, (err_bit_cnt_before_coding_matrix(:,k)/(L_encoded(1)*N_sim)).');
end
legend('b=0', 'b=0.1 rho=0.1','b=0.5 rho=0.95','b=1 rho=1');
title('BER-SNR Curve');
xlabel('SNR(dB)');
ylabel('BER');
grid on;
%err_bit_cnt_after_coding
figure;
hold on;
set(gca, 'yscale', 'log');
for k=2:5
    plot(SNR_arr, ((err_bit_cnt_after_coding_matrix(:,k))/(N_info_bits*N_sim)).');
end
legend('b=0', 'b=0.1 rho=0.1','b=0.5 rho=0.95','b=1 rho=1');
title('BER-SNR Curve');
xlabel('SNR(dB)');
ylabel('BER');
grid on;