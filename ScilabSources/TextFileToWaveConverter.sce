//Converts a text file to a wave file
//Alain Bonardi//
//2019//

titre = 'Choose SR';
labels = ["SR"];
typeList = list("vec", 1);
defaultValueList = ["48000"];
[ok, fe]=getvalue(titre, labels, typeList, defaultValueList);
cheminFichier = uigetfile("*.txt");
[fd, err]=mopen(cheminFichier, 'r');//we open the file to read it//
s = mfscanf(-1, fd, '%lf');
mclose(fd);
playsnd(s, fe);
cheminFichier2 = uiputfile("*.wav");//we choose a folder and the name of the folder//
wavwrite(s, fe, 16, cheminFichier2);//we write the WAVE FILE (16 bits by default)//
