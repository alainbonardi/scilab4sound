//Modifies the sampling rate of a file//
//(number of bits remains the same)
//Alain Bonardi//
//2019//

cheminFichier1 = uigetfile("*.wav");
[s1, fs1, b1] = wavread(cheminFichier1);
Ntotal1 = size(s1);
Nech1 = Ntotal1(1,2);//this is the original number of samples//
messagebox("Original SR="+string(fs1)+"; Number of samples="+string(Nech1), "Original file");
//the file is played at its original sampling rate/
playsnd(s1, fs1);
titre = 'New SR';
labels = ["SR"];
typeList = list("vec", 1);
defaultValueList = ["48000"];
[ok, fs2]=getvalue(titre, labels, typeList, defaultValueList);
Nech2 = floor(Nech1 * fs2 / fs1);
messagebox("New SR="+string(fs2)+"; Number of samples="+string(Nech2), "Original file");
s2 = zeros(1, Nech2);
titre = 'Type of interpolation 1->lin | 2->cos | 3->cub';
labels = ["type"];
typeList = list("vec", 1);
defaultValueList = ["2"];
[ok, ty]=getvalue(titre, labels, typeList, defaultValueList);
for i=1:Nech2
    decimalIndex = i * Nech1 / Nech2;
    i1 = max(floor(decimalIndex), 1);
    i2 = min(i1 + 1, Nech1);
    k = decimalIndex - i1;
    y1 = s1(1, i1);
    y2 = s1(1, i2);
    select ty
    case 1 then 
        s2(1, i) = (1-k) * y1 + k * y2;
    case 2 then
        mu2 = (1 - cos(k * %pi)) * 0.5;
        s2(1, i) = (1 - mu2) *y1 + mu2 * y2;
    case 3 then
        i0 = max(i1 - 1, 1);
        i3 = min(i2+1, Nech1);
        y0 = s1(1, i0);
        y3 = s1(1, i3);
        mu2 = k * k;
        a0 = y3 - y2 - y0 + y1;
        a1 = y0 - y1 - a0;
        a2 = y2 - y0;
        a3 = y1;
        s2(1, i) = a0 * k * mu2 + a1 * mu2 + a2 * k + a3;
    end
end
cheminFichier2 = uiputfile("*.wav");
b2 = b1;
wavwrite(s2, fs2, b2, cheminFichier2);
