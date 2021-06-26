function [data_index, data_V] = HitungSAW(x, k, w) % prameter yang dibutuhkan adalah data, attribut kriteria, bobot kriteria
    % nilai return untuk fungsi adalah index_rekomendasi dan data_V
    [baris, kolom] = size(x);
    R = zeros(baris,kolom);

    % normalisasi matriks
    for i=1 : kolom
        if k(i) == 1
            R(:,i) = x(:,i)./max(x(:,i)); % apabila attribut merupakan benefit, maka seluruh data pada suatu kolom
                                            % dibagi nilai maximum dari data pada kolom tersebut
        else
            R(:,i) = min(x(:,i))./x(:,i); % apabila attribut merupakan cost, maka nilai minimum pada data di suatu kolom
                                            % dibagi dengan setiap data
                                            % pada kolom tersebut
        end    
    end

    count = 0;
    data_index = []; % untuk menympan index dari rumah yang direkomendasikan
    data_V = [];
    for i=1 : baris
        V(i) = sum(w.*R(i,:)); % proses perangkingan
        if V(i) >= 0.4
            count = count + 1;
            data_index(count) = i;
            data_V(count) = V(i);
            % untuk data dengan nilai V >= 0.4 maka akan menjadi data
            % rekomendasi untuk user, lalu indexnya akan di ambil yang
            % kemudian akan dijadikan data pencarian rumah
        end
    end
end