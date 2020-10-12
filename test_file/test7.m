%�Ƿ���β
adress=["sim_10-Oct-2020 09_16_41_#14.mat" "sim_10-Oct-2020 22_47_07_#17.mat"];
%SNR_arr=[];
%N_Sim,L_encoded,N_info_bits
err_bit_cnt_after_coding_matrix=zeros(17,2);
err_bit_cnt_before_coding_matrix=zeros(17,2);
err_box_cnt_crc_matrix=zeros(17,2);
for k=1:2
    load(adress(k));
    err_bit_cnt_after_coding_matrix(:,k)=err_bit_cnt_after_coding;
    err_bit_cnt_before_coding_matrix(:,k)=err_bit_cnt_before_coding;
    err_box_cnt_crc_matrix(:,k)=err_box_cnt_crc;
end
%display
%BER�Ա�
figure;
hold on;
set(gca, 'yscale', 'log');
for k=1:2
    plot(SNR_arr, ((err_bit_cnt_after_coding_matrix(:,k))/(N_info_bits*N_sim)).');
end
legend('��β', '����β');
title('BER-SNR Curve After Coding(b=0.5 rho=0.95)');
xlabel('SNR(dB)');
ylabel('BER');
grid on;

%BLER�Ա�
figure;
hold on;
%set(gca, 'yscale', 'log');
for k=1:2
    plot(SNR_arr, err_box_cnt_crc_matrix(:,k));
end
legend('��β', '����β');
title('BLER-SNR Curve After Coding(b=0.5 rho=0.95)');
xlabel('SNR(dB)');
ylabel('BLER');
grid on;
