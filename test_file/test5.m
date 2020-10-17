%硬软判决 ZF和MSE信道均衡的性能差别
adress=["sim_12-Oct-2020 21_25_55_#25.mat" "sim_12-Oct-2020 21_31_59_#26.mat"];
%SNR_arr=[];
%N_Sim,L_encoded,N_info_bits
err_bit_cnt_after_hard_decoding_matrix=zeros(17,2);
err_bit_cnt_after_soft_decoding_matrix=zeros(17,2);
err_box_cnt_crc_hard_matrix=zeros(17,2);
err_box_cnt_crc_soft_matrix=zeros(17,2);
for k=1:2
    load(adress(k));
    err_bit_cnt_after_hard_decoding_matrix(:,k)=err_bit_cnt_after_hard_decoding;
    err_bit_cnt_after_soft_decoding_matrix(:,k)=err_bit_cnt_after_soft_decoding;
    err_box_cnt_crc_hard_matrix(:,k)=err_box_cnt_crc_hard;
    err_box_cnt_crc_soft_matrix(:,k)=err_box_cnt_crc_soft;        
end
%display
%硬判决下是否编码的差别
% figure;
% hold on;
% set(gca, 'yscale', 'log');
% plot(SNR_arr, (err_bit_cnt_before_coding_matrix(:,1)/(L_encoded(1)*N_sim)).');
% plot(SNR_arr, ((err_bit_cnt_after_coding_matrix(:,1))/(N_info_bits*N_sim)).');
% legend('BER before coding', 'BER after coding');
% title('BER-SNR Curve (b=0.5 rho=0.95)');
% xlabel('SNR(dB)');
% ylabel('BER');
% grid on;

%编码时硬软判决的对比
figure;
hold on;
set(gca, 'yscale', 'log');
plot(SNR_arr, ((err_bit_cnt_after_hard_decoding_matrix(:,1))/(N_info_bits*N_sim)).');
plot(SNR_arr, ((err_bit_cnt_after_soft_decoding_matrix(:,1))/(N_info_bits*N_sim)).');
legend('硬判决', '软判决');
title('BER-SNR Curve After Coding(b=0.5 rho=0.95 ZF)');
xlabel('SNR(dB)');
ylabel('BER');
grid on;

%全图
% figure;
% hold on;
% set(gca, 'yscale', 'log');
% plot(SNR_arr, (err_bit_cnt_before_coding_matrix(:,1)/(L_encoded(1)*N_sim)).');
% for k=1:2
%     plot(SNR_arr, ((err_bit_cnt_after_coding_matrix(:,k))/(N_info_bits*N_sim)).');
% end
% legend('硬判决 编码前','硬判决 编码后',  '软判决 编码后');
% title('BER-SNR Curve (b=0.5 rho=0.95)');
% xlabel('SNR(dB)');
% ylabel('BER');
% grid on;

%编码时硬软判决的对比BLER
figure;
hold on;
%set(gca, 'yscale', 'log');
plot(SNR_arr, err_box_cnt_crc_hard_matrix(:,1));
plot(SNR_arr, err_box_cnt_crc_soft_matrix(:,1));
legend('硬判决', '软判决');
title('BLER-SNR Curve After Coding(b=0.5 rho=0.95 ZF)');
xlabel('SNR(dB)');
ylabel('BLER');
grid on;

%信道均衡方法
figure;
hold on;
set(gca, 'yscale', 'log');
plot(SNR_arr, ((err_bit_cnt_after_hard_decoding_matrix(:,1))/(N_info_bits*N_sim)).');
plot(SNR_arr, ((err_bit_cnt_after_hard_decoding_matrix(:,2))/(N_info_bits*N_sim)).');
legend('ZF', 'MSE');
title('BER-SNR Curve After Coding(b=0.5 rho=0.95 hard decoding)');
xlabel('SNR(dB)');
ylabel('BER');
grid on;

figure;
hold on;
%set(gca, 'yscale', 'log');
plot(SNR_arr, err_box_cnt_crc_hard_matrix(:,1));
plot(SNR_arr, err_box_cnt_crc_hard_matrix(:,2));
legend('ZF', 'MSE');
title('BLER-SNR Curve After Coding(b=0.5 rho=0.95 hard decoding)');
xlabel('SNR(dB)');
ylabel('BLER');
grid on;

figure;
hold on;
set(gca, 'yscale', 'log');
plot(SNR_arr, ((err_bit_cnt_after_soft_decoding_matrix(:,1))/(N_info_bits*N_sim)).');
plot(SNR_arr, ((err_bit_cnt_after_soft_decoding_matrix(:,2))/(N_info_bits*N_sim)).');
legend('ZF', 'MSE');
title('BER-SNR Curve After Coding(b=0.5 rho=0.95 soft decoding)');
xlabel('SNR(dB)');
ylabel('BER');
grid on;

figure;
hold on;
%set(gca, 'yscale', 'log');
plot(SNR_arr, err_box_cnt_crc_soft_matrix(:,1));
plot(SNR_arr, err_box_cnt_crc_soft_matrix(:,2));
legend('ZF', 'MSE');
title('BLER-SNR Curve After Coding(b=0.5 rho=0.95 soft decoding)');
xlabel('SNR(dB)');
ylabel('BLER');
grid on;