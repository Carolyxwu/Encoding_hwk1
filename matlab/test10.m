setup_mapper_1;
setup_encoder_1;

% Simulation parameters.

N_info_bits = 4096;
SNR_arr = [0, 0.5, 1, 1.5, 2, 2.5, 3, 4, 5, 6, 7, 8, 9, 10, 12.5, 15, 17.5];   % target SNR.
Ps = 1;


% Start simulation.
SNRs_abs = 10.^(SNR_arr/10);
sigma_arr = sqrt(Ps./SNRs_abs);
N_sigmas = length(sigma_arr);

soft_decode = false;
L_encoded = zeros(N_sigmas, 1);
error_map_demapping=zeros(length(SNR_arr),9862);
error_map_decoded=zeros(length(SNR_arr),4928);
for sigma_iter = 1:N_sigmas
    sigma = sigma_arr(sigma_iter);
    random_bits = (rand([1, N_info_bits])>0.5);
    random_bits_with_crc = CRC(random_bits);
    encoded_bits = conv_encode(random_bits_with_crc, conv_encoder_conf);    
    % Setup length of encoded bits.    
    L_encoded(sigma_iter) = length(encoded_bits);    
    % Simulation with channel.    
    syms = bit_mapping(encoded_bits, mapping_conf);    
    ch = ch_realization(length(syms), ch_conf);    
    syms_with_noise = syms .* ch + (get_cgaussian(sigma, length(syms))).';    
    pred_bits = bit_demapping(syms_with_noise, length(encoded_bits), mapping_conf, ch, ch_conf, sigma);
    % Decode.    
    decoded_bits_with_crc = fast_conv_decode(pred_bits, conv_encoder_conf, soft_decode);    
    decoded_validation = deCRC(decoded_bits_with_crc);    
    error_map_demapping(sigma_iter,:)=bitxor(encoded_bits,pred_bits);
    error_map_decoded(sigma_iter,:)=bitxor(random_bits_with_crc,decoded_bits_with_crc);
end        
        
%»­³öÎóÂëÍ¼°¸
for idx = 1:N_sigmas
    figure;
    plot(error_map_demapping(idx,:));
    title('error_map_demapping(b=0.3 rho=0.9 '+string(SNR_arr(idx))+'dB)');
    figure;
    plot(error_map_decoded(idx,:));
    title('error_map_decoded(b=0.3 rho=0.9 '+string(SNR_arr(idx))+'dB)');
end       
        
       
