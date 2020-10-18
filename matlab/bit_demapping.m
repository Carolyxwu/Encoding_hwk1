function bit_stream=bit_demapping(syms, L, mapping_conf, ch, ch_conf, sigma)
% demapping algorithm.
% Need To: Channel estimation; calculate LLR / L2 distance.
    mapping_vector = mapping_conf.M;    % Constellation points.
    bit_per_symbol = mapping_conf.bps;
    mode = mapping_conf.mode;       % Demapping mode: Channel Estimation mode.
    alg = mapping_conf.alg;         % Channel Equalization algorithm.
    output_mode = mapping_conf.out; 
    est_method= mapping_conf.est;
    % Assume PSK.
    Amp = abs(mapping_vector(1));
    SNR = 20*log10(Amp/sigma);
    
    if strcmp(mode, 'ch_known')
        assert(logical(exist('ch', 'var')));
        if strcmp(alg, 'zf')
            est_syms=syms ./ ch;
        elseif strcmp(alg, 'mse')
            snr = 10^(SNR/10);
            est_syms=syms .* conj(ch)./(ch.*conj(ch)+1/snr);
        end
    end

    if strcmp(mode, 'ch_unknown')
        pilot_rate = mapping_conf.pilotrate;
        est_ch = zeros([1,length(syms)]);
        pilot_flag = false([1,length(syms)]);
        for k=1:length(syms)
            if mod(k,pilot_rate) == 1 || k == length(syms)
                pilot_flag(k) = true;
                est_ch(k) = syms(k);
            end
        end
        % using linear interp to estimate channels.
        if strcmp(est_method, 'linear')
            est_ch = linear_interp(est_ch, pilot_flag);
        elseif strcmp(est_method, 'quad')
            est_ch = quad_interp(est_ch, pilot_flag, pilot_rate);
        else
            est_ch = est_kalman(est_ch, pilot_flag, pilot_rate, ch_conf.rho, ch_conf.b, sigma);
        end
        if strcmp(alg, 'zf')
            est_syms = syms ./ est_ch;
        elseif strcmp(alg, 'mse')
            snr = 10^(SNR/10);
            est_syms=syms .* conj(est_ch)./(est_ch.*conj(est_ch)+1/snr);
        end
        % remove pilots.
        est_syms = est_syms(~pilot_flag);
        syms = syms(~pilot_flag);
    end
    %% deinterleave
    interleave=mapping_conf.interleave;
    depth=mapping_conf.depth;
    if interleave
        Ls=length(est_syms);
        block_in=ceil(Ls/depth);
        remainder=mod(Ls, depth);
        syms_deinterleave=zeros(size(est_syms));
        for D=1:depth
            for B=1:block_in
                if(D<=remainder)
                    syms_deinterleave((B-1)*depth+D)=est_syms((D-1)*block_in+B);
                elseif((B-1)*depth+D<=Ls)
                    syms_deinterleave((B-1)*depth+D)=est_syms((D-1)*block_in+B-(D-remainder-1));
                end
            end
        end
        est_syms=syms_deinterleave;
    end     
    
    %% Perform demapping.
    if strcmp(output_mode, 'hard')
        L_extended = length(syms) * bit_per_symbol;
        bit_stream = false([1, L_extended]);
        % hard-decision.
        for block = 1:length(est_syms)
            [~, ind] = min(abs(mapping_vector-est_syms(block)));
            ind=ind-1;
            % convert to binary.
            b_index = bit_per_symbol*(block-1)+1;
            bit_stream(b_index:b_index+bit_per_symbol-1)=to_binary(ind, bit_per_symbol);
        end
        bit_stream = bit_stream(1:L);
    elseif strcmp(output_mode, 'L2')
        N_constellations = 2^bit_per_symbol;
        bit_stream = zeros([N_constellations, length(est_syms)]);
        % using L2 measure.
        for block=1:length(est_syms)
            bit_stream(:, block) = abs(mapping_vector-est_syms(block)).^2;
        end
    end    
    %bit_stream = bit_stream(:,1:L);
end