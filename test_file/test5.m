%Ӳ���о�
adress=["sim_10-Oct-2020 09_16_41_#14.mat" "sim_10-Oct-2020 22_56_30_#18.mat"];
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
%Ӳ�о����Ƿ����Ĳ��
figure;
hold on;
set(gca, 'yscale', 'log');
plot(SNR_arr, (err_bit_cnt_before_coding_matrix(:,1)/(L_encoded(1)*N_sim)).');
plot(SNR_arr, ((err_bit_cnt_after_coding_matrix(:,1))/(N_info_bits*N_sim)).');
legend('BER before coding', 'BER after coding');
title('BER-SNR Curve (b=0.5 rho=0.95)');
xlabel('SNR(dB)');
ylabel('BER');
grid on;

%����ʱӲ���о��ĶԱ�
figure;
hold on;
set(gca, 'yscale', 'log');
for k=1:2
    plot(SNR_arr, ((err_bit_cnt_after_coding_matrix(:,k))/(N_info_bits*N_sim)).');
end
legend('Ӳ�о�', '���о�');
title('BER-SNR Curve After Coding(b=0.5 rho=0.95)');
xlabel('SNR(dB)');
ylabel('BER');
grid on;

%ȫͼ
figure;
hold on;
set(gca, 'yscale', 'log');
plot(SNR_arr, (err_bit_cnt_before_coding_matrix(:,1)/(L_encoded(1)*N_sim)).');
for k=1:2
    plot(SNR_arr, ((err_bit_cnt_after_coding_matrix(:,k))/(N_info_bits*N_sim)).');
end
legend('Ӳ�о� ����ǰ','Ӳ�о� �����',  '���о� �����');
title('BER-SNR Curve (b=0.5 rho=0.95)');
xlabel('SNR(dB)');
ylabel('BER');
grid on;

%����ʱӲ���о��ĶԱ�BLER
figure;
hold on;
%set(gca, 'yscale', 'log');
for k=1:2
    plot(SNR_arr, err_box_cnt_crc_matrix(:,k));
end
legend('Ӳ�о�', '���о�');
title('BLER-SNR Curve After Coding(b=0.5 rho=0.95)');
xlabel('SNR(dB)');
ylabel('BLER');
grid on;
