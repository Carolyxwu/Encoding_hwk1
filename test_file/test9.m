%������ͼ�� 17��������¸���һ�����ֽ�ӳ��ĺͽ����
%��ӳ���Ӧencoded_bits��pred_bits
%�����Ӧradom_bits_with_crc��decoded_bits_with_crc
%load('sim_10-Oct-2020 00_56_54_#6.mat')
setup_mapper;
SNR_arr = [0, 0.5, 1, 1.5, 2, 2.5, 3, 4, 5, 6, 7, 8, 9, 10, 12.5, 15, 17.5];   % target SNR.
SNRs_abs = 10.^(SNR_arr/10);
sigma_arr = sqrt(Ps./SNRs_abs);
N_sigmas = length(sigma_arr);
encoded_bits_matrix=zeros(length(encoded_bits),length(SNR_arr));
pred_bits_matrix=zeros(length(pred_bits),length(SNR_arr));
parfor sigma_iter = 1:N_sigmas
    
    pred_bits = bit_demapping(syms_with_noise, length(encoded_bits), mapping_conf, ch, ch_conf, sigma);
end


