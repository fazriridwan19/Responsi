opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (3);
x1 = readmatrix('Real estate valuation data set.xlsx',opts); % membaca data kolom 3

opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (4);
x2 = readmatrix('Real estate valuation data set.xlsx',opts);% membaca data kolom 4

opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (5);
x3 = readmatrix('Real estate valuation data set.xlsx',opts); % membaca data kolom 5

opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (8);
x4 = readmatrix('Real estate valuation data set.xlsx',opts);% membaca data kolom 8

x = [x1 x2 x3 x4];
x = x(1:50,:); % mengambil 50 data dari total keseluruhan data
[baris kolom] = size(x);

for i=1 : baris
    for j=1 : kolom
        if x(i,j) == 0
            x(i,j) = 1; % mengganti data yang bernilai 0 menjadi 1
        end
    end
end

k = [0 0 1 0]; % attribut kategori, 1 untuk benefit 0 untuk cost
w = [3 5 4 1]; % bobot setiap kategori

w = w./sum(w); % normalisasi bobot, rentang bobot menjadi 0-1

for i=1 : kolom
    if k(i) == 0
        w(i) = -1*w(i); % untuk kategori yang merupakan cost nilai nya dibuat min
    end
end

for i=1 : baris
    S(i) = prod(x(i,:).^w); % memangkatkan data dengan bobot yang sesuai
                            % hasil perpangkatannya kemudian dikalikan untuk
                            % baris yg sama
end

V = S/sum(S); % mencari nilai vektor V, dengan membagi setaip nilai S dengan jumlah data dari S

for i=1 : baris
    if max(V) == V(i)
        disp('Real estate terbaik adalah no: '); % menampilkan data real estate yang nilai V nya paling besar
        disp(i)
    end
end
