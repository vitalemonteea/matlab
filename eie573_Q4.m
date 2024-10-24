% Constants
d = 200;
K = 10^(-30/10);  % K in linear scale (converted from -30 dB)
d0 = 1;
gamma = 3.5;
sigma_psi_dB = sqrt(10);
Pt = 1;
F = 24.067358;

% Convert Pt to dBm
Pt_dBm = 10 * log10(Pt * 1000);

% Generate realizations
num_realizations = round(F * 1e7);  % Use round() instead of int32()
psi_dB = sigma_psi_dB * randn(1, num_realizations);

% Calculate path loss
PL = -(10 * log10(K) + 10 * gamma * log10(d0/d));

% Calculate received power in dBm for each realization
Pr_dBm = Pt_dBm - PL + psi_dB;

% Calculate outage probability 
P_min_dBm = -90;
outage_count = sum(Pr_dBm < P_min_dBm);
outage_probability = outage_count / num_realizations;
fprintf('Outage Probability (P_min = %.0f dBm): %.6f\n', P_min_dBm, outage_probability);