//Wav file selection//
cheminFichier = uigetfile("*.wav");

//Wav file reading//
[s, fs, b]=wavread(cheminFichier);

Ntotal = size(s);
Nsamp = Ntotal(1, 2);

//The wav file is played for checking//
playsnd(s, fs);//on joue le fichier des échantillons dans s à la fréquence fs//

//Name and path selection for the text file//
cheminFichier2 = uiputfile("*.txt");

//a text file with 10 sample values per line is generated//
//with commas between samples//
messagebox("Nsamp = " + string(Nsamp), "Wav to text");
write(cheminFichier2, s, '(10(f10.7, '',''))');



