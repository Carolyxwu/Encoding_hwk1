%不同符号映射
adress=["sim_10-Oct-2020 23_09_03_#19.mat" "sim_10-Oct-2020 23_50_51_#23.mat"...
        "sim_10-Oct-2020 23_24_36_#20.mat"];
%SNR_arr=[];
%N_Sim,L_encoded,N_info_bits
err_bit_cnt_after_coding_matrix=zeros(17,3);
err_bit_cnt_before_coding_matrix=zeros(17,3);
err_box_cnt_crc_matrix=zeros(17,3);
for k=1:3
    load(adress(k));
    err_bit_cnt_after_coding_matrix(:,k)=err_bit_cnt_after_coding;
    err_bit_cnt_before_coding_matrix(:,k)=err_bit_cnt_before_coding;
    err_box_cnt_crc_matrix(:,k)=err_box_cnt_crc;
end
%display
%BER对比 不编码
figure;
hold on;
set(gca, 'yscale', 'log');
for k=1:3
    plot(SNR_arr, (err_bit_cnt_before_coding_matrix(:,k)/(L_encoded(1)*N_sim)).');
end
legend('1 bit/char','2 bit/char','3 bit/char');
title('BER-SNR Curve Before Coding(b=0.5 rho=0.95)');
xlabel('SNR(dB)');
ylabel('BER');
grid on;


