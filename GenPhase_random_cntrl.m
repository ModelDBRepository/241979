
tt = 0:0.01:1;
total_t = length(tt);

sigR = 0:0.25:1; % Sigma of phase distribution: Randon level sigR= 0 = no randomness, 1 = full randomness
NN = 1150; %Number of neuron

Af= 1; %Amplitude
f= 5; %Frequency

FIG_PLOT = true;
VISUALIZE= false;
%% 
savedir = 'Heterogeneity/';
mkdir(savedir);

for tr = 1 : N_TRIAL
    tmp_rand = rand(1,NN); % generate random number for # of cells
    tmp_base_phi = pi*(2*(tmp_rand - 0.5));

    tmp_phi = repmat(tmp_base_phi, length(sigR),1); % copy base_phi for length(sigR) row
    tmp_sig = repmat(sigR',1,NN);
    phi = tmp_phi.*tmp_sig; % By rows --> sigR , by column --> cells

    if (FIG_PLOT)  
        figure(tr);
    end
    xbins = -pi:pi/8:pi;
    for ii = 1: length(sigR)  
        if (FIG_PLOT)
        %Histogram
        subplot(length(sigR), 1, ii);
        hold on;
        histogram(phi(ii,:), xbins);
        title(['sig = ' num2str(sigR(ii))]);
        end

        %Save
        fname = [savedir '/Heterogeneity_N' num2str(NN) '_RandomSig' num2str(sigR(ii)) '_Trial' num2str(tr) '.txt'];
        fileID = fopen(fname,'w');
        for nn = 1 : NN
        fprintf(fileID,'%f\n' ,'phi(ii,nn)'); 
        end
        disp(['Finished writing : ' fname ]);
        fclose(fileID);
    end
    if (FIG_PLOT)
        figure(tr); suptitle({'Distribution of phase', ['N = ' num2str(NN) ' Trial#' num2str(tr) ]});
    end
end


%% Visualize
if (VISUALIZE)
    fTest = f;
    for ff = 1 : length(sigR)
        figure;  plot(tt, 1+Af*sin(2*pi*fTest*(tt))); hold on;
        for nn = 1: NN
        plot(tt, 1+Af*sin(2*pi*fTest*(tt)+phi(ff,nn)));
        end
        title(['Sig = ' num2str(sigR(ff))]);
    end
end

