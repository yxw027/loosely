function kf = update_z(kf, ins, gnss, vbf, update_mode)
    %UPDATE_Z Summary of this function goes here
    %   Detailed explanation goes here
    if nargin<5, update_mode = 'nhc';end
        if strcmp(update_mode, 'nhc')
            zvb = vbf.CTMab*(ins.CTMbn'*ins.v) + skew(vbf.w)*vbf.lo - [norm(ins.v);0;0];
            kf.z = [zvb];
        elseif strcmp(update_mode, 'horizontal')
            zvb = vbf.CTMab*(ins.CTMbn'*ins.v) + skew(vbf.w)*vbf.lo - [norm(ins.v);0;0];
            zpsi = vbf.CTMab*(ins.CTMbn'*ins.w) - [0;0;sign(ins.w(3))*norm(ins.w)];
            kf.z = [zvb;
                    zpsi];
        elseif strcmp(update_mode, 'kinematic')
            zvb = vbf.CTMab*(ins.CTMbn'*ins.v) + skew(vbf.w)*vbf.lo - [norm(ins.v);0;0];
            % zvb = vbf.vb + skew(vbf.w)*vbf.lo-[norm(ins.v);0;0];
            zpsi = vbf.CTMab*(ins.CTMbn'*ins.w) - [0;0;sign(ins.w(3))*norm(ins.w)];
            zv3 = vbf.vb - vbf.CTMab*ins.CTMbn'*ins.v;
            kf.z = [zvb;
                    zpsi;
                    zv3];
        elseif strcmp(update_mode, 'zaru')
        end
    end
    