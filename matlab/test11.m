load('err_map.mat');
figure;
list=[1 3 5 7 9 10 11 13 15 17];
SNR_arr = [0, 0.5, 1, 1.5, 2, 2.5, 3, 4, 5, 6, 7, 8, 9, 10, 12.5, 15, 17.5];
for idx = 1:10
    subplot(10,2,2*idx-1)
    plot(error_map_demapping(list(idx),:));
    title('error map demapping(b=0.3 rho=0.9 '+string(SNR_arr(list(idx)))+'dB)');
    subplot(10,2,2*idx)
    plot(error_map_decoded(list(idx),:));
    title('error map decoded(b=0.3 rho=0.9 '+string(SNR_arr(list(idx)))+'dB)');
end 