%画误码图案 17个信噪比下各画一个，分解映射的和解码的
%解映射对应encoded_bits和pred_bits
%解码对应random_bits_with_crc和decoded_bits_with_crc
%load('sim_10-Oct-2020 00_56_54_#6.mat')
setup_mapper_1;
setup_encoder_1;
%SNR_arr = [0, 0.5, 1, 1.5, 2, 2.5, 3, 4, 5, 6, 7, 8, 9, 10, 12.5, 15, 17.5];   % target SNR.
%SNRs_abs = 10.^(SNR_arr/10);
%sigma_arr = sqrt(Ps./SNRs_abs);
%N_sigmas = length(sigma_arr);
select_sim=100;
encoded_bits_matrix=zeros(length(SNR_arr),length(encoded_bits));
pred_bits_matrix=zeros(length(SNR_arr),length(pred_bits));
random_bits_with_crc_matrix=zeros(length(SNR_arr),length(random_bits_with_crc));
decoded_bits_with_crc_matrix=zeros(length(SNR_arr),length(decoded_bits_with_crc));
error_map_demapping=zeros(length(SNR_arr),length(encoded_bits));
error_map_decoded=zeros(length(SNR_arr),length(random_bits_with_crc));
%通过星座点复原比特 计算误码图案
for idx = 1:N_sigmas 
    sigma_temp = sigma_arr(idx);
    soft_decode = false;
    ch_temp=CSI{idx}(select_sim, :);
    pred_bits_matrix(idx,:) = bit_demapping(SYMS_RECEIVE{idx}(select_sim, :), length(encoded_bits), mapping_conf, ch_temp, ch_conf, sigma_temp);
    encoded_bits_matrix(idx,:) = bit_demapping(SYMS_TRANSMIT{idx}(select_sim, :), length(encoded_bits), mapping_conf, ch_temp, ch_conf, sigma_temp);
    
    random_bits_with_crc_matrix(idx,:) = fast_conv_decode(encoded_bits_matrix(idx,:), conv_encoder_conf, soft_decode);
    decoded_bits_with_crc_matrix(idx,:) = fast_conv_decode(pred_bits_matrix(idx,:), conv_encoder_conf, soft_decode);
    error_map_demapping(idx,:)=bitxor(encoded_bits_matrix(idx,:),pred_bits_matrix(idx,:));
    error_map_decoded(idx,:)=bitxor(random_bits_with_crc_matrix(idx,:),decoded_bits_with_crc_matrix(idx,:));
end
%画出误码图案
for idx = 1:N_sigmas
    figure;
    plot(error_map_demapping(idx,:));
    title('error_map_demapping(b=0.3 rho=0.9 '+string(SNR_arr(idx))+'dB)');
    figure;
    plot(error_map_decoded(idx,:));
    title('error_map_decoded(b=0.3 rho=0.9 '+string(SNR_arr(idx))+'dB)');
end

save('sim_6_error_map','encoded_bits_matrix','pred_bits_matrix',...
    'random_bits_with_crc_matrix','decoded_bits_with_crc_matrix',...
    'error_map_demapping','error_map_decoded');
