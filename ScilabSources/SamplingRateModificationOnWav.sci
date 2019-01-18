//choix d'un fichier WAVE que l'on ouvre//
//filtre sur le choix de fichier//
cheminFichier1 = uigetfile("*.wav");
//on ouvre un fichier wav et on récupère ses échantillons (s), sa fréquence
//d'échantillonnage (fs) et son nombre de bits (16)
[s1, fs1, b1] = wavread(cheminFichier1);
//s est une matrice à 1 ligne et N colonnes correspondant aux N échantillons du fichier//
//size donne les 2 informations de taille d'une matrice :
//nombre de lignes, nombre de colonnes//
//le résultat de size est lui meme est une matrice à 1 ligne et 2 colonnes//
Ntotal1 = size(s1);
Nech1 = Ntotal1(1,2);//on récupère la 2ème information qui est le nombre d'échantillons//
messagebox("Original SR="+string(fs1)+"; Number of samples="+string(Nech1), "Original file");
//on joue le fichier à sa fréquence d'échantillonnage//
playsnd(s1, fs1);
titre = 'New SR';
labels = ["SR"];
typeList = list("vec", 1);
defaultValueList = ["48000"];
[ok, fs2]=getvalue(titre, labels, typeList, defaultValueList);
Nech2 = floor(Nech1 * fs2 / fs1);
messagebox("New SR="+string(fs2)+"; Number of samples="+string(Nech2), "Original file");
s2 = zeros(1, Nech2);
titre = 'Type of interpolation 1->lin 2->cos';
labels = ["type"];
typeList = list("vec", 1);
defaultValueList = ["2"];
[ok, ty]=getvalue(titre, labels, typeList, defaultValueList);
for i=1:Nech2
    decimalIndex = i * Nech1 / Nech2;
    i1 = floor(decimalIndex);
    if (i1 < 1) then i1 = 1;
    end
    i2 = i1 + 1;
    if (i2 > Nech1) then i2 = Nech1;
    end
    k = decimalIndex - i1;
    y1 = s1(1, i1);
    y2 = s1(1, i2);
    select ty
    case 1 then 
        s2(1, i) = (1-k) * y1 + k * y2;
    case 2 then
        mu2 = (1 - cos(k * %pi)) * 0.5;
        s2(1, i) = (1 - mu2) *y1 + mu2 * y2;
    //printf("i1=%f, i2=%f, k=%f\n", i1, i2, k)
    end
end
cheminFichier2 = uiputfile("*.wav");
b2 = b1;
wavwrite(s2, fs2, b2, cheminFichier2);
